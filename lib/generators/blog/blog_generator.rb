class BlogGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def create_blog
    generate "scaffold", "#{file_name} title:string body:text"
    rails_command "db:migrate"
  end
end
