import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "modal" ]

    open() {
        this.modalTarget.showModal();
        document.body.style.overflow = "hidden"
    }

    close() {        
        this.modalTarget.close()
        document.body.style.overflow = "auto"
    }

    lightDismiss(e) {
        if (e.target === this.modalTarget) {
            this.close()
        }
    }
}
