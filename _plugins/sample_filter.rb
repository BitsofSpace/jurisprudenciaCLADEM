require 'pry'
module Jekyll
  module SampleFilter
    # Obtiene un elemento al azar de un array
    def sample(input)
      input.sample
    end

    # Recibe un array y devuelve los primeros elementos hasta el límite
    # especificado
    #
    # También funciona con hashes
    def limit(input, limited_to)
      if input.is_a? Array
        input[0..(limited_to - 1)]
      elsif input.is_a? Hash
        input.slice(*input.keys[0..(limited_to - 1)])
      end
    end

    # Recibe una colección de ítems y devuelve un array con las filas y
    # las columnas, para que podamos ponerlos en una grilla
    #
    # XXX Tal vez debería llamarse `grid`
    def rows(input, cols)
      input.each_slice(cols).to_a
    end

    # Recibe un número y obtiene un array del 1 a la cantidad
    def to_array(input)
      (1..input).to_a
    end

    # Un post falso para usar en JS con mustache
    # TODO obtener todos los valores de la plantilla
    def fake_post(input)
      {
        'title' => '{{ title }}',
        'thumb' => '{{ thumb }}',
        'url' => '{{ url }}',
        'año' => '{{ año }}'
      }
    end

    def collect_field(input, field)
      input.map do |i|
        i[field]
      end.compact.uniq.sort
    end

    def filter_by(input, key, value)
      input.select do |p|
        p.data[key] == value
      end
    end

    # Obtiene la url de una categoría
    def to_category_url(input)
      @context.registers[:site].config.dig('jekyll-archives', 'permalinks', 'category').gsub(':name', Jekyll::Utils.slugify(input).to_s)
    end
  end

  class AssetTag < Liquid::Tag
    def render(context)
      "?#{Time.now.to_i.to_s}"
    end
  end
end


Liquid::Template.register_filter(Jekyll::SampleFilter)
Liquid::Template.register_tag('asset', Jekyll::AssetTag)
