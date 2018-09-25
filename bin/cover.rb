# Subportadas para PDF
#
# Las tapas en img/covers/sub son el nombre completo de la categoría en
# lugar del slug (ver _layouts/header.tex).  Para eso vinculamos la
# categoría por su slug a la subportada.
require 'yaml'

%w(ar es en).each do |lang|
  data = YAML.load(File.open(File.join('_data', lang + '.yml')))

  Dir.chdir('img/covers/sub') do
    data['modulos']['grid'].each do |modulo|
      orig = if lang == 'ar'
        modulo['lang']['en'] + ".pdf"
      else
        modulo['lang'][lang] + ".pdf"
      end

      dest = modulo['nombre'] + ".pdf"

      FileUtils.ln_s(File.join('..', lang, orig), dest) unless File.exist? dest
    end
  end
end
