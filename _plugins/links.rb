# Agrega una biblioteca de links y definiciones al final de cada post,
# para no tener que repetirlas

Jekyll::Hooks.register :posts, :pre_render do |post|
  file = "links.#{post.site.config['lang']}.md"

  if File.exist? file
    post.content << "\n\n\n"
    post.content << File.read(file)
  end
end
