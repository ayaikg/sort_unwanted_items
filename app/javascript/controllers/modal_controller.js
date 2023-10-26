import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = [ "modal" ]

  connect() {
    this.modalTarget.showModal()
  }

  close(event) {
    if (event.detail.success) {
      this.modalTarget.close()
    }
  }
}
