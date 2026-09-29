-- Vocabulario estructural del libro en cada idioma, compartido por print.lua y epub.lua.
-- Son las marcas que el markdown usa para capítulos, preguntas y apéndices.

local V = {
  es = {
    count      = '^Este capítulo contiene (%d+) preguntas%.$',
    part       = '^Parte ',
    question   = '^(P%d+) · (.*)$',
    topics     = { '^Tema: (.-) · Nivel', '^Tema: (.-) · Monográfico' },
    level      = '^Nivel (%d+)',
    mono       = '^Monográfico (%u)',
    appendix   = '^Apéndice (%u) · (.*)$',
    appendices = 'Apéndices',
    words      = { questions = 'preguntas', appendix = 'Apéndice' },
  },
  en = {
    count      = '^This chapter contains (%d+) questions%.$',
    part       = '^Part ',
    question   = '^(Q%d+) · (.*)$',
    topics     = { '^Topic: (.-) · Level', '^Topic: (.-) · Deep Dive' },
    level      = '^Level (%d+)',
    mono       = '^Deep Dive (%u)',
    appendix   = '^Appendix (%u) · (.*)$',
    appendices = 'Appendices',
    words      = { questions = 'questions', appendix = 'Appendix' },
  },
}

return function(meta)
  local lang = meta.lang and pandoc.utils.stringify(meta.lang):sub(1, 2) or 'es'
  local v = V[lang] or V.es
  v.topic_of = function(s)
    for _, p in ipairs(v.topics) do
      local t = s:match(p)
      if t then return t end
    end
  end
  return v
end
