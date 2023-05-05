import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "menu" ]

  toggle() {
      this.isHidden() ? this.show() :  this.hide()
  }

  lightDismiss(e) {
    if(!this.element.contains(e.target)) {
      this.hide()
    }
  }

  isHidden() {
    return getComputedStyle(this.menuTarget).display === "none"
  }

  show() {
    this.menuTarget.style.display = "block"
  }

  hide() {
    this.menuTarget.style.display = "none"
  }
}
