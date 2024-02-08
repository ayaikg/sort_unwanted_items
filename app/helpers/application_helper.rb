module ApplicationHelper
  def page_title(page_title = '', admin: false)
    base_title = admin ? 'steteco(管理画面)' : 'steteco'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def login_class
    logged_in? ? "hidden lg:block" : ""
  end
end
