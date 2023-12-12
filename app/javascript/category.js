document.addEventListener('turbo:load', setupCategorySelection);
document.addEventListener('turbo:render', setupCategorySelection);

function setupCategorySelection(){
  function appendOption(category) {
    return `<option value="${category.id}">${category.title}</option>`;
  }

  function appendChildrenBox(insertHTML) {
    var childSelectHTML = `<div class="form-control" id="children_wrapper">
                            <select id="child_category" name="item[category_id]" class="select select-bordered">
                              <option value="">---</option>
                              ${insertHTML}
                            </select>
                          </div>`;
    document.querySelector('.append__category').insertAdjacentHTML('beforeend', childSelectHTML);
  }

  var itemCategoryIdElement = document.getElementById('item_category_id');
  if (itemCategoryIdElement) {
    itemCategoryIdElement.addEventListener('change', function() {
      const childrenWrapper2 = document.getElementById('children_wrapper2');
      if (childrenWrapper2) childrenWrapper2.remove();
      var parentId = this.value;
      if (parentId != "") {
        fetch(`/items/category_children/?parent_id=${parentId}`)
        .then(response => response.json())
          .then(children => {
            var childrenWrapper = document.getElementById('children_wrapper');
            if (childrenWrapper) {
              childrenWrapper.remove();
            }
            var insertHTML = '';
            children.forEach(function(child) {
              insertHTML += appendOption(child);
            });
            appendChildrenBox(insertHTML);
          })
          .catch(() => {
            alert('カテゴリー取得に失敗しました');
          });
      } else {
        var childrenWrapper = document.getElementById('children_wrapper');
        if (childrenWrapper) {
          childrenWrapper.remove();
        }
      }
    });
  } 
};
