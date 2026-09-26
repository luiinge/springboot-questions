-- Filtro pandoc para el EPUB: reproduce la estructura visual de la edición impresa
-- (bloques de color por capítulo, distintivos de pregunta, una pregunta por página)
-- mediante clases que estiliza kindle.css. El texto de los títulos no cambia, así
-- que el índice del Kindle sigue mostrando "Nivel 1 · Básico · ..." y "P001 · ...".

local stringify = pandoc.utils.stringify

local function is_para(b) return b and (b.t == 'Para' or b.t == 'Plain') end

local function split(s)
  local parts = {}
  for p in (s .. ' · '):gmatch('(.-) · ') do table.insert(parts, p) end
  return parts
end

-- "kicker · título" como spans; el separador se oculta con CSS
local function kicker_title(kicker, title)
  return {
    pandoc.Span(pandoc.Str(kicker), {class = 'kicker'}),
    pandoc.Span(pandoc.Str(' · '), {class = 'sep'}),
    pandoc.Span(pandoc.Str(title), {class = 'htitle'}),
  }
end

local function badge_title(badge, title)
  return {
    pandoc.Span(pandoc.Str(badge), {class = 'badge'}),
    pandoc.Span(pandoc.Str(' · '), {class = 'sep'}),
    pandoc.Span(pandoc.Str(title), {class = 'htitle'}),
  }
end

function Pandoc(doc)
  local blocks, out, i = doc.blocks, {}, 1
  local first = true
  while i <= #blocks do
    local b = blocks[i]
    local text = b.t == 'Header' and stringify(b.content) or nil

    if b.t == 'Header' and b.level == 1 then
      first = true
      local parts = split(text)
      local desc, count, j = {}, nil, i + 1
      while is_para(blocks[j]) do
        local n = stringify(blocks[j]):match('^Este capítulo contiene (%d+) preguntas%.$')
        if n then count = n else table.insert(desc, blocks[j]) end
        j = j + 1
      end

      local level = text:match('^Nivel (%d+)')
      local mono = text:match('^Monográfico (%u)')
      if count and (level or mono) then
        b.classes:insert('banner')
        b.classes:insert(level and ('lvl-' .. level) or ('mono-' .. mono))
        b.content = kicker_title(table.concat(parts, ' · ', 1, #parts - 1), parts[#parts])
        table.insert(out, b)
        local body = {pandoc.Para(pandoc.Str(count .. ' preguntas'))}
        body[1] = pandoc.Div(body[1], {class = 'count'})
        for _, d in ipairs(desc) do table.insert(body, d) end
        table.insert(out, pandoc.Div(body, {class = 'banner-body'}))
        i = j
      elseif text:match('^Parte') then
        b.classes:insert('parte')
        b.content = kicker_title(parts[1], table.concat(parts, ' · ', 2))
        table.insert(out, b)
        if #desc > 0 then table.insert(out, pandoc.Div(desc, {class = 'parte-body'})) end
        i = j
      else
        if text == 'Apéndices' then b.classes:insert('apendices') end
        table.insert(out, b)
        i = i + 1
      end

    elseif b.t == 'Header' and b.level == 2 and text:match('^P%d+ · ') then
      local badge, title = text:match('^(P%d+) · (.*)$')
      b.classes:insert('question')
      if first then b.classes:insert('first') end
      first = false
      b.content = badge_title(badge, title)
      table.insert(out, b)
      local nxt = blocks[i + 1]
      local s = is_para(nxt) and stringify(nxt) or ''
      local topic = s:match('^Tema: (.-) · Nivel') or s:match('^Tema: (.-) · Monográfico')
      if topic then
        table.insert(out, pandoc.Div(pandoc.Para(pandoc.Str(topic)), {class = 'topic'}))
        i = i + 2
      else
        i = i + 1
      end

    elseif b.t == 'Header' and b.level == 2 and text:match('^Apéndice %u · ') then
      local letter, title = text:match('^Apéndice (%u) · (.*)$')
      b.classes:insert('question')
      b.classes:insert('apendice')
      if first then b.classes:insert('first') end
      first = false
      b.content = {
        pandoc.Span(pandoc.Str('Apéndice '), {class = 'sep'}),
        pandoc.Span(pandoc.Str(letter), {class = 'badge'}),
        pandoc.Span(pandoc.Str(' · '), {class = 'sep'}),
        pandoc.Span(pandoc.Str(title), {class = 'htitle'}),
      }
      table.insert(out, b)
      i = i + 1

    else
      table.insert(out, b)
      i = i + 1
    end
  end
  doc.blocks = out
  return doc
end
