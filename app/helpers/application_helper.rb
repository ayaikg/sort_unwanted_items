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

  def category_icon(category)
    category_icons = {
      'ファッション' => 'category_clothes.png', '書籍' => 'category_book.png', 'コスメ' => 'category_cosme.png',
      'ゲーム' => 'category_game.png', '音楽' => 'category_music.png', 'おもちゃ・ぬいぐるみ' => 'category_doll.png',
      'その他' => 'category_others.png'
    }
    category_icons.fetch(category.title, 'no_image.png')
  end

  def page_title(page_title = '')
    base_title = 'steteco'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end
end
