class BlogGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def create_blog
    generate "scaffold", "Post title:string body:text"
    rails_command "db:migrate"
  end
end
