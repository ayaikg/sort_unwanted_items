import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="item-select"
export default class extends Controller {
  static targets = ["select"]

  connect() {
    this.selectTarget.addEventListener('change', this.showInfo.bind(this));
  }

  showInfo(event) {
    const itemId = event.target.value;
    Turbo.visit(`/items/${itemId}/show_info`);
  }
}
