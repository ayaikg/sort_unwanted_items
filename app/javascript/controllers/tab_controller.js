import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["status", "content"]

  connect() {
    this.showCurrentTab()
  }

  status(event) {
    const status = this.statusTargets
    const current = event.currentTarget
    const currentIndex = status.indexOf(current)
    this.saveCurrentTab(currentIndex)
    this.showTab(currentIndex)
  }

  saveCurrentTab(index) {
    localStorage.setItem('currentTab', index)
  }

  showCurrentTab() {
    const savedIndex = localStorage.getItem('currentTab') || 0
    this.showTab(savedIndex)
  }

  showTab(index) {
    const status = this.statusTargets
    const contents = this.contentTargets

    status.forEach((status, idx) => {
      if(idx == index) {
        status.classList.remove("not-active")
        status.classList.add("tab-active")
        contents[idx].classList.remove("hidden")
      } else {
        status.classList.remove("tab-active")
        status.classList.add("not-active")
        contents[idx].classList.add("hidden")
      }
    })
  }
}
