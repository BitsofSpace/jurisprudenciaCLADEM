Jekyll::Hooks.register :posts, :pre_render do |post|
  next if post.data.dig('sesion')

  site = post.site
  data = post.data
  i18n = site.data[site.config['lang']]

  sesion = ""
  %w(objetivos duracion formato habilidades conocimientos
     sesiones_ejercicios_relacionados materiales_requeridos
     recomendaciones).each do |key|

    next unless data.dig(key)
    d = data[key]

    next if d.is_a?(String) && d == ""
    next if d.is_a?(Array) && d.size == 0

    sesion << "* **#{i18n['sesion'][key]}:** "

    if d.is_a? String
      sesion << d.capitalize
    elsif d.is_a? Array
      sesion << d.map do |i|
        a_post = site.posts.docs.select { |p| p.data['title'] == i }.first

        if a_post
          "\n  * [#{i}][]"
        else
          unless key == 'materiales_requeridos'
            Jekyll.logger.warn "Sesion", "No se encontró \"#{i}\" en \"#{post.data['title']}\": #{post.path}"
          end
          "\n  * #{i}"
        end

      end.join('')
    end

    sesion << "\n"
  end

  post.content.gsub!(/^# .*/, "\\0\n\n#{sesion}")
  post.data['sesion'] = true
end
