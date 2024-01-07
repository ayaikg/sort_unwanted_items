document.addEventListener('turbo:load', setupCategorySelection);
document.addEventListener('turbo:render', setupCategorySelection);

function setupCategorySelection(){
  const appendOption = category => `<option value="${category.id}">${category.title}</option>`;

  const appendChildrenBox = (insertHTML) => {
    const childSelectHTML = `
      <div class="form-control" id="children_wrapper">
        <select id="child_category" name="item[category_id]" class="select select-bordered">
          <option value="">---</option>
          ${insertHTML}
        </select>
      </div>`;
    document.querySelector('.append__category').insertAdjacentHTML('beforeend', childSelectHTML);
  };

  const itemCategoryIdElement = document.getElementById('item_category_id');
  if (!itemCategoryIdElement) return;

  itemCategoryIdElement.addEventListener('change', function() {
    removeChildrenWrapper('children_wrapper2');

    const parentId = this.value;
    if (parentId != "") {
      fetch(`/items/category_children/?parent_id=${parentId}`)
      .then(response => response.json())
        .then(children => {
          removeChildrenWrapper('children_wrapper');
          let insertHTML = '';
          children.forEach(child => {
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .catch(() => {
          alert('カテゴリー取得に失敗しました');
        });
    } else {
      removeChildrenWrapper('children_wrapper');
    }
  });
}

function removeChildrenWrapper(wrapperId) {
  const wrapperElement = document.getElementById(wrapperId);
  if (wrapperElement) wrapperElement.remove();
}
