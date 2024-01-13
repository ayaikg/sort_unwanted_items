document.addEventListener('turbo:load', function() {
  // 「投稿するアイテム」の下に表示するための要素を作成
  const itemInfo = document.createElement('p');
  itemInfo.id = 'item-info'; // この要素を操作しやすくするためにIDを付与
  itemInfo.classList.add('m-auto', 'w-3/4', 'border-b', 'border-secondary', 'text-lg', 'pb-2', 'text-center'); // スタイルを適用

  // 「投稿するアイテム」のpタグを取得して、その後ろにitemInfoを挿入
  const itemLabel = document.querySelector('#title');
  if (itemLabel) {
    itemLabel.after(itemInfo);
  }

  // radioボタンの要素を取得する
  const radioButtons = document.querySelectorAll('input[type="radio"][name="post[item_id]"]');

  if (radioButtons.length > 0) {
    itemInfo.textContent = 'アイテムを選択してください';
  } else {
    itemInfo.textContent = 'アイテムがありません。';
  }

  const updateItemInfo = (radio) => {
    // ラジオボタンが選択されたときの処理
    if (radio.checked) {
      // 選択されたアイテムのラベルテキストを取得
      // itemInfoのテキストを更新
      itemInfo.textContent = radio.nextElementSibling.textContent;
    }
  };

  // 各ラジオボタンにイベントリスナーを設定
  // ページ読み込み時に既に選択されているアイテムがあれば、その情報を表示
  radioButtons.forEach((radio) => {
    updateItemInfo(radio);
    radio.addEventListener('change', () => updateItemInfo(radio));
  });
});