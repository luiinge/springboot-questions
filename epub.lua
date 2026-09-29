-- Filtro pandoc para el EPUB: reproduce la estructura visual de la edición impresa
-- (bloques de color por capítulo, distintivos de pregunta, una pregunta por página:
-- cada pregunta va en su propio fichero, porque muchos lectores ignoran page-break-before)
-- mediante clases que estiliza kindle.css. El texto de los títulos no cambia, así
-- que el índice del Kindle sigue mostrando "Nivel 1 · Básico · ..." y "P001 · ...".
--
-- Las marcas de cada idioma están en vocab.lua.

local vocab = dofile(PANDOC_SCRIPT_FILE:gsub('[^/]*$', '') .. 'vocab.lua')
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
  local v = vocab(doc.meta)
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
        local n = stringify(blocks[j]):match(v.count)
        if n then count = n else table.insert(desc, blocks[j]) end
        j = j + 1
      end

      local level = text:match(v.level)
      local mono = text:match(v.mono)
      if count and (level or mono) then
        b.classes:insert('banner')
        b.classes:insert(level and ('lvl-' .. level) or ('mono-' .. mono))
        b.content = kicker_title(table.concat(parts, ' · ', 1, #parts - 1), parts[#parts])
        table.insert(out, b)
        local body = {pandoc.Div(pandoc.Para(pandoc.Str(count .. ' ' .. v.words.questions)), {class = 'count'})}
        for _, d in ipairs(desc) do table.insert(body, d) end
        table.insert(out, pandoc.Div(body, {class = 'banner-body'}))
        i = j
      elseif text:match(v.part) then
        b.classes:insert('parte')
        b.content = kicker_title(parts[1], table.concat(parts, ' · ', 2))
        table.insert(out, b)
        if #desc > 0 then table.insert(out, pandoc.Div(desc, {class = 'parte-body'})) end
        i = j
      else
        if text == v.appendices then b.classes:insert('apendices') end
        table.insert(out, b)
        i = i + 1
      end

    elseif b.t == 'Header' and b.level == 2 and text:match(v.question) then
      local badge, title = text:match(v.question)
      b.classes:insert('question')
      if first then b.classes:insert('first') end
      first = false
      b.content = badge_title(badge, title)
      table.insert(out, b)
      local nxt = blocks[i + 1]
      local topic = is_para(nxt) and v.topic_of(stringify(nxt))
      if topic then
        table.insert(out, pandoc.Div(pandoc.Para(pandoc.Str(topic)), {class = 'topic'}))
        i = i + 2
      else
        i = i + 1
      end

    elseif b.t == 'Header' and b.level == 2 and text:match(v.appendix) then
      local letter, title = text:match(v.appendix)
      b.classes:insert('question')
      b.classes:insert('apendice')
      if first then b.classes:insert('first') end
      first = false
      b.content = {
        pandoc.Span(pandoc.Str(v.words.appendix .. ' '), {class = 'sep'}),
        pandoc.Span(pandoc.Str(letter), {class = 'badge'}),
        pandoc.Span(pandoc.Str(' · '), {class = 'sep'}),
        pandoc.Span(pandoc.Str(title), {class = 'htitle'}),
      }
      table.insert(out, b)
      i = i + 1

    elseif b.t == 'Header' and b.level == 2 then
      -- Subsecciones de la introducción: se bajan a nivel 3 para que el EPUB, que se
      -- divide en un fichero por pregunta (--split-level=2), no las separe en páginas
      b.level = 3
      b.classes:insert('subsection')
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
