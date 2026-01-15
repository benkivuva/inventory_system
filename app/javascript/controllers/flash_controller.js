import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        setTimeout(() => {
            this.dismiss()
        }, 2000)
    }

    dismiss() {
        this.element.classList.add("transition-all", "duration-500", "opacity-0", "translate-y-2")
        setTimeout(() => {
            this.element.remove()
        }, 500)
    }
}
