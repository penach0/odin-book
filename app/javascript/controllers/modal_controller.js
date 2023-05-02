import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "modal" ]

    open() {
        this.modalTarget.style.display = "flex"
    }

    close() {
        this.modalTarget.style.display = "none"
    }
}
