import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "menu" ]

  toggle() {
    if(getComputedStyle(this.menuTarget).display === "none") {
      this.menuTarget.style.display = "block" 
    } else {
      this.menuTarget.style.display = "none"
    }
  }
}
