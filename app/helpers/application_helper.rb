module ApplicationHelper
  def set_url(category = nil)
    if category && current_page?(category_items_path(category))
      category_items_path(category)
    elsif current_page?(history_items_path)
      history_items_path
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
    end
  end

  def set_search_key(category = nil)
    if (category && current_page?(category_items_path(category))) || current_page?(history_items_path)
      :name_cont
    elsif current_page?(posts_path) || current_page?(likes_posts_path)
      :content_or_item_name_cont
    end
  end

  def set_key(category = nil)
    if (category && current_page?(category_items_path(category))) || current_page?(history_items_path)
      :name
    elsif current_page?(posts_path) || current_page?(likes_posts_path)
      :content
    end
  end

  def choice_page?(category = nil)
    (category && current_page?(category_items_path(category))) ||
      current_page?(history_items_path) ||
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
      'ファッション' => 'categories/category_fashion', '書籍' => 'categories/category_book', 'コスメ' => 'categories/category_cosme',
      'ゲーム' => 'categories/category_game', '音楽' => 'categories/category_music', '趣味・グッズ・おもちゃ' => 'categories/category_hobby',
      '美容' => 'categories/category_beauty', 'ベビー・キッズ' => 'categories/category_kids', '家電' => 'categories/category_appliances',
      'スポーツ・レジャー' => 'categories/category_sports', 'その他' => 'categories/category_others'
    }
    if category_icons[category.title]
      svg_content = render partial: category_icons[category.title]
    end
    svg_content.html_safe # HTMLとしてレンダリングするためにhtml_safeを呼ぶ
  end

  def page_title(page_title = '', admin = false)
    base_title = if admin
                    'steteco(管理画面)'
                 else
                    'steteco'
                 end

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end
end
