import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card"]

  connect() {
    this.defaultBackgroundColor = "bg-white"
    this.selectedBackgroundColor = "bg-gray-300"
  }

  selectCard(event) {
    this.cardTargets.forEach(card => {
      card.classList.remove(this.selectedBackgroundColor)
      card.classList.add(this.defaultBackgroundColor)
    })

    const selectedCard = event.currentTarget.querySelector(".card")
    selectedCard.classList.remove(this.defaultBackgroundColor)
    selectedCard.classList.add(this.selectedBackgroundColor)
  }
}
