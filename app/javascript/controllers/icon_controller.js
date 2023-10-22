import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="icon"
export default class extends Controller {
  iconClick(event) {
    event.stopPropagation()
  }
}
