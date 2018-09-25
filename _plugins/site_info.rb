Jekyll::Hooks.register :site, :post_read do |site|
  lang = site.config.dig('lang')
  site.config['title'] = site.data[lang]['meta']['title'] if lang
end
