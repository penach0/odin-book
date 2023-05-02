import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "modal" ]

    show() {
        this.modalTarget.style.display = "block"
    }
}
