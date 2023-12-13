# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

fashion = Category.create!(title: 'ファッション')
book = Category.create!(title: '書籍')
cosme = Category.create!(title: 'コスメ')
beauty = Category.create!(title: '美容')
kids = Category.create!(title: 'ベビー・キッズ')
music = Category.create!(title: '音楽')
game = Category.create!(title: 'ゲーム')
appliances = Category.create!(title: '家電')
hobby = Category.create!(title: '趣味・グッズ・おもちゃ')
sports = Category.create!(title: 'スポーツ・レジャー')
others = Category.create!(title: 'その他')

fashion.children.create!(
  [
    { title: 'トップス' },
    { title: 'ジャケット/アウター' },
    { title: 'パンツ' },
    { title: 'スカート' },
    { title: 'ワンピース' },
    { title: 'スーツ/フォーマル/ドレス' },
    { title: '靴' },
    { title: '帽子' },
    { title: 'バッグ' },
    { title: '時計' },
    { title: 'その他' }
  ]
)

book.children.create!(
  [
    { title: '文学/小説' },
    { title: '人文/社会' },
    { title: 'ノンフィクション/教養' },
    { title: 'ビジネス/経済' },
    { title: '健康/医学' },
    { title: 'コンピュータ/IT' },
    { title: '趣味/スポーツ/実用' },
    { title: '住まい/暮らし/子育て' },
    { title: 'アート/エンタメ' },
    { title: '参考書' },
    { title: '少年漫画' },
    { title: '少女漫画' },
    { title: '青年漫画' },
    { title: '女性漫画' },
    { title: 'その他' }
  ]
)

cosme.children.create!(
  [
    { title: 'ベースメイク' },
    { title: 'アイシャドウ'},
    { title: 'アイライナー'},
    { title: 'アイブロウ' },
    { title: 'マスカラ' },
    { title: 'チーク' },
    { title: 'リップ'},
    { title: '香水/女性用' },
    { title: '香水/男性用' },
    { title: '香水/ユニセックス' },
    { title: '香水/ボディミスト' },
    { title: 'その他'}
  ]
)

beauty.children.create!(
  [
    { title: 'スキンケア/化粧水' },
    { title: 'スキンケア/乳液' },
    { title: 'ボディケア' },
    { title: 'ヘアケア' },
    { title: 'ネイルケア' },
    { title: 'リラクゼーショングッズ' },
    { title: 'その他' }
  ]
)

kids.children.create!(
  [
    { title: 'ベビー服' },
    { title: 'キッズ服' },
    { title: 'キッズ靴' },
    { title: '子ども用バッグ' },
    { title: 'おむつ/トイレ/バス'},
    { title: 'ベビーカー' },
    { title: '抱っこ紐/スリング' },
    { title: 'チャイルドシート' },
    { title: 'ベビー家具' },
    { title: 'ベビーフード' },
    { title: 'その他' }
  ]
)

music.children.create!(
  [
    { title: 'CD/邦楽' },
    { title: 'CD/洋楽' },
    { title: 'CD/アニメ' },
    { title: 'CD/クラシック' },
    { title: 'CD/K-POP・アジア' },
    { title: 'CD/キッズ・ファミリー' },
    { title: 'DVD/外国映画' },
    { title: 'DVD/日本映画' },
    { title: 'DVD/アニメ' },
    { title: 'DVD/TVドラマ' },
    { title: 'DVD/お笑い・バラエティ' },
    { title: 'DVD/スポーツ・フィットネス' },
    { title: 'DVD/キッズ・ファミリー' },
    { title: 'レコード' },
    { title: 'その他' }
  ]
)

game.children.create!(
  [
    { title: '家庭用ゲーム本体' },
    { title: '家庭用ゲームソフト' },
    { title: '携帯用ゲーム本体' },
    { title: '携帯用ゲームソフト' },
    { title: 'PCゲーム' },
    { title: 'カードゲーム' },
    { title: 'その他' }
  ]
)

appliances.children.create!(
  [
    { title: 'スマートフォン/携帯電話' },
    { title: 'PC/タブレット' },
    { title: 'カメラ' },
    { title: 'テレビ/映像機器' },
    { title: '生活家電' },
    { title: 'オーディオ機器' },
    { title: '美容/健康' },
    { title: 'スマホアクセサリー' },
    { title: 'バッテリー/充電器' },
    { title: 'その他' }
  ]
)

hobby.children.create!(
  [
    { title: 'タレントグッズ' },
    { title: 'キャラクターグッズ' },
    { title: 'アニメグッズ' },
    { title: 'ぬいぐるみ' },
    { title: 'フィギュア' },
    { title: 'プラモデル' },
    { title: 'ラジコン' },
    { title: 'ミニカー' },
    { title: '切手/貨幣' },
    { title: '楽器/器材' },
    { title: '美術品' },
    { title: 'アート用品' },
    { title: 'ハンドメイド' },
    { title: 'その他' }
  ]
)

sports.children.create!(
  [
    { title: 'ゴルフ' },
    { title: 'フィッシング'},
    { title: '自転車' },
    { title: '野球' },
    { title: 'サッカー/フットサル' },
    { title: 'テニス' },
    { title: 'スノーボード' },
    { title: 'スキー' },
    { title: 'トレーニング/エクササイズ' },
    { title: 'キャンプ/登山' },
    { title: '旅行用品' },
    { title: 'その他' }
  ]
)

others.children.create!(
  [
    { title: 'ペット用品' },
    { title: '文房具/事務用品' },
    { title: '日用品/生活雑貨' },
    { title: '飲料/酒' },
    { title: 'その他' }
  ]
)