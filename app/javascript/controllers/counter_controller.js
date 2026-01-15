import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = {
        start: Number,
        end: Number,
        duration: Number
    }

    connect() {
        this.startValue = 0
        this.endValue = this.element.dataset.value ? parseInt(this.element.dataset.value) : 0
        this.durationValue = 1000

        if (this.endValue === 0) return

        this.animate()
    }

    animate() {
        let startTimestamp = null
        const step = (timestamp) => {
            if (!startTimestamp) startTimestamp = timestamp
            const progress = Math.min((timestamp - startTimestamp) / this.durationValue, 1)

            this.element.innerHTML = Math.floor(progress * (this.endValue - this.startValue) + this.startValue).toLocaleString()

            if (progress < 1) {
                window.requestAnimationFrame(step)
            }
        }
        window.requestAnimationFrame(step)
    }
}
