class CustomLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer

  # From Will paginate gem:
    # Process it! This method returns the complete HTML string which contains
    # pagination links. Feel free to subclass LinkRenderer and change this
    # method as you see fit.
  # Please read:  https://github.com/mislav/will_paginate/blob/master/lib/will_paginate/view_helpers/link_renderer.rb

  def previous_page
    ''
  end

  def next_page
    ''
  end

  def page_number(page)
    tag(:div, "<a> #{page} </a>", :class => (page == current_page ? 'active' : ''), "data-page" => "#{page}")
  end
end