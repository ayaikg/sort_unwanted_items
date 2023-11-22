module ApplicationHelper
  def set_url(category = nil)
    if category && current_page?(category_items_path(category))
      category_items_path(category)
    elsif current_page?(history_items_path)
      history_items_path
    elsif current_page?(categories_path)
      categories_path
    elsif current_page?(posts_path)
      posts_path
    elsif current_page?(likes_posts_path)
      likes_posts_path
    end
  end

  def set_value(category = nil)
    if category && current_page?(category_items_path(category))
      search_items_path(view: 'index')
    elsif current_page?(history_items_path)
      search_items_path(view: 'history')
    elsif current_page?(categories_path)
      search_categories_path
    elsif current_page?(posts_path)
      search_posts_path
    end
  end

  def set_search_key(category = nil)
    if category && current_page?(category_items_path(category)) || current_page?(history_items_path)
      :name_cont
    elsif current_page?(categories_path)
      :title_cont
    elsif current_page?(posts_path) || current_page?(likes_posts_path)
      :advice_cont
    end
  end

  def set_key(category = nil)
    if category && current_page?(category_items_path(category)) || current_page?(history_items_path)
      :name
    elsif current_page?(categories_path)
      :title
    elsif current_page?(posts_path) || current_page?(likes_posts_path)
      :advice
    end
  end

  def choice_page?(category = nil)
    category && current_page?(category_items_path(category)) ||
    current_page?(history_items_path) ||
    current_page?(categories_path) ||
    current_page?(posts_path) ||
    current_page?(likes_posts_path)
  end
end
