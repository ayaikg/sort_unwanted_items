document.addEventListener('turbo:load', () => {
  // 現在のページのURLパスを取得
  const currentPath = window.location.pathname;
  const categoriesPath = '/categories';
  // すべてのリンクを取得し、現在のURLパスと一致するリンクを探す
  document.querySelectorAll('.button').forEach(link => {
    // リンクのhref属性からパス部分だけを取り出す
    const linkPath = new URL(link.href).pathname;
    const activeClass = link.dataset.activeClass;
    const CategoryItemPath = currentPath.startsWith('/categories/') && currentPath.includes('/items');
    // 現在のパスとリンクのパスが一致していれば、色を変える
    if (linkPath === currentPath || (CategoryItemPath && linkPath === categoriesPath)) {
      link.classList.add(activeClass);
    } else {
      link.classList.remove(activeClass);
    }
  });
});