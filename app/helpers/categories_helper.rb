module CategoriesHelper
  def category_icon(category)
    category_icons = {
      'ファッション' => 'categories/category_fashion', '書籍' => 'categories/category_book',
      'コスメ' => 'categories/category_cosme', 'ゲーム' => 'categories/category_game',
      '音楽' => 'categories/category_music', '趣味・グッズ・おもちゃ' => 'categories/category_hobby',
      '美容' => 'categories/category_beauty', 'ベビー・キッズ' => 'categories/category_kids',
      '家電' => 'categories/category_appliances', 'スポーツ・レジャー' => 'categories/category_sports',
      'その他' => 'categories/category_others'
    }
    render partial: category_icons[category.title] if category_icons[category.title]
  end
end
