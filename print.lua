-- Filtro pandoc para la edición impresa: pasa a la plantilla Typst los datos
-- que se maquetan fuera del flujo normal (cabeceras de capítulo y de pregunta).
--
--   # Nivel 1 · ...            + descripción + "Este capítulo contiene N preguntas."
--   ## P001 · ...              + "*Tema: X · Nivel ...*"
--
-- Las marcas de cada idioma están en vocab.lua.

local vocab = dofile(PANDOC_SCRIPT_FILE:gsub('[^/]*$', '') .. 'vocab.lua')

local function typst(blocks)
  local out = pandoc.write(pandoc.Pandoc(blocks), 'typst')
  return (out:gsub('%s+$', ''))
end

local function is_para(b) return b and (b.t == 'Para' or b.t == 'Plain') end

function Pandoc(doc)
  local v = vocab(doc.meta)
  local blocks, out, i = doc.blocks, {}, 1
  local first_question = true
  while i <= #blocks do
    local b = blocks[i]
    local text = b.t == 'Header' and pandoc.utils.stringify(b.content) or nil

    if b.t == 'Header' and b.level == 1 then
      first_question = true
      -- Descripción (párrafos antes del primer subtítulo) y número de preguntas
      local desc, count, j = {}, '', i + 1
      while is_para(blocks[j]) do
        local n = pandoc.utils.stringify(blocks[j]):match(v.count)
        if n then count = n else table.insert(desc, blocks[j]) end
        j = j + 1
      end
      -- Solo capítulos con recuento (niveles, monográficos) y partes llevan cabecera propia
      if count ~= '' or text:match(v.part) then
        table.insert(out, pandoc.RawBlock('typst', string.format(
          '#metadata((desc: [%s], count: "%s"))<chapter-info>', typst(desc), count)))
        table.insert(out, b)
        i = j
      else
        table.insert(out, pandoc.RawBlock('typst', '#metadata(none)<chapter-info>'))
        table.insert(out, b)
        i = i + 1
      end

    elseif b.t == 'Header' and b.level == 2 and text:match(v.question) then
      local topic = ''
      local nxt = blocks[i + 1]
      if is_para(nxt) then
        local t = v.topic_of(pandoc.utils.stringify(nxt))
        if t then topic = t; i = i + 1 end
      end
      table.insert(out, pandoc.RawBlock('typst', string.format(
        '#metadata((topic: "%s", first: %s))<question-topic>',
        topic:gsub('"', '\\"'), tostring(first_question))))
      first_question = false
      table.insert(out, b)
      i = i + 1

    elseif b.t == 'Header' and b.level == 2 and text:match(v.appendix) then
      -- Cada apéndice en página nueva, salvo el primero (va tras el título "Apéndices")
      if not first_question then
        table.insert(out, pandoc.RawBlock('typst', '#pagebreak(weak: true)'))
      end
      first_question = false
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
