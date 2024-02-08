import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select"
export default class extends Controller {
  static targets = [ "modal", "link", "hiddenSelect" ]
  
  connect() {
    this.updateLinkTextFromSelected();
  }

  closeModal() {
    this.reflectSelection()
    this.modalTarget.close()
  }

  reflectSelection() {
    const selectedRadioButton = this.modalTarget.querySelector('input[type="radio"]:checked');
    if (selectedRadioButton) {
      const label = selectedRadioButton.nextElementSibling.textContent;
      this.linkTarget.textContent = label;

      // 更新が必要なhiddenフォームのラジオボタンを選択する
      const hiddenSelectBox = document.querySelector('select.hidden');
      if (hiddenSelectBox) {
        hiddenSelectBox.value = selectedRadioButton.value;
      }
    }
  }

  updateLinkTextFromSelected() {
    const selectedOption = this.hiddenSelectTarget.querySelector('option:checked');
    if (selectedOption) {
      this.linkTarget.textContent = selectedOption.textContent;
    }
  }
}
