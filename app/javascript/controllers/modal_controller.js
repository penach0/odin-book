import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "modal" ]

    open() {
        this.modalTarget.style.display = "flex"
        document.body.style.overflow = "hidden"
    }

    close() {
        this.modalTarget.style.display = "none"
        document.body.style.overflow = "auto"
    }
}
