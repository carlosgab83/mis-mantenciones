module ApplicationHelper
  def render_slim(slim_markup)
    Slim::Template.new { slim_markup }.render.html_safe
  end
end
