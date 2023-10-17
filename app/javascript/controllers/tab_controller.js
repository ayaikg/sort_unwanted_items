import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["status", "content"]

  statusClick(event) {
    const status = this.statusTargets
    const current = event.currentTarget
    const currentIndex = status.indexOf(current)
    const contents = this.contentTargets
  
    status.forEach((status, index) => {
      if(status == current) {
        status.classList.remove("not-active")
        status.classList.add("tab-active")
        contents[index].classList.remove("hidden")
      } else {
        status.classList.remove("tab-active")
        status.classList.add("not-active")
        contents[index].classList.add("hidden")
      }
    })
  }
}
