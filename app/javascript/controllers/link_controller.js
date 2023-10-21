import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="link"
export default class extends Controller {
  static targets = ["toLink"]

  toLink(event) {
    event.preventDefault()
    const href = this.toLinkTarget.dataset['href']
    window.location.href = href
    console.log('Clicked!')
  }
}
