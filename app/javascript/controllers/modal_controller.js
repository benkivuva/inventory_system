import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.element.classList.add("modal-open")
        // Trap focus, etc. if needed
    }

    disconnect() {
        this.element.classList.remove("modal-open")
    }

    close(event) {
        if (event) event.preventDefault()

        // Target the turbo frame to clear it
        const modalFrame = document.getElementById("modal")
        if (modalFrame) {
            modalFrame.src = ""
            modalFrame.innerHTML = ""
        }
    }

    // Handle ESC key
    onKeyDown(event) {
        if (event.key === "Escape") {
            this.close()
        }
    }
}
