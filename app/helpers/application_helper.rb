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
    end
  end

  def set_search_key(category = nil)
    if (category && current_page?(category_items_path(category))) || current_page?(history_items_path)
      :name_cont
    elsif current_page?(categories_path)
      :title_or_items_name_cont
    elsif current_page?(posts_path) || current_page?(likes_posts_path)
      :content_or_item_name_cont
    end
  end

  def set_key(category = nil)
    if (category && current_page?(category_items_path(category))) || current_page?(history_items_path)
      :name
    elsif current_page?(categories_path)
      :title
    elsif current_page?(posts_path) || current_page?(likes_posts_path)
      :content
    end
  end

  def choice_page?(category = nil)
    (category && current_page?(category_items_path(category))) ||
      current_page?(history_items_path) ||
      current_page?(categories_path) ||
      current_page?(posts_path) ||
      current_page?(likes_posts_path)
  end

  def set_diposal_key(category = nil)
    if (category && current_page?(category_items_path(category))) || current_page?(history_items_path)
      :disposal_method_eq
    elsif current_page?(posts_path) || current_page?(likes_posts_path)
      :item_disposal_method_eq
    end
  end

  def set_listing_key(category = nil)
    if (category && current_page?(category_items_path(category))) || current_page?(history_items_path)
      :listing_status_eq
    elsif current_page?(posts_path) || current_page?(likes_posts_path)
      :item_listing_status_eq
    end
  end

  def default_categories
    %w[ファッション 書籍 コスメ ゲーム 音楽 ぬいぐるみ その他]
  end

  def set_category
    if current_page?(history_items_path)
      :category_id_eq
    elsif current_page?(posts_path) || current_page?(likes_posts_path)
      :item_category_id_eq
    end
  end

  def set_categories_collection
    parent_categories = Category.where(ancestry: nil)
    grouped_options_for_select(parent_categories.map { |p| [p.title, p.children.map { |c| [c.title, c.id] }] })
  end

  def category_icon(category)
    case category.title
    when 'ファッション'
      'category_clothes.png'
    when '書籍'
      'category_book.png'
    when 'コスメ'
      'category_cosme.png'
    when 'ゲーム'
      'category_game.png'
    when '音楽'
      'category_music.png'
    when 'おもちゃ・ぬいぐるみ'
      'category_doll.png'
    when 'その他'
      'category_others.png'
    else
      'no_image.png'
    end
  end
end
