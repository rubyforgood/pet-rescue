import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="delete"
export default class extends Controller {
  static targets = ['input', 'button', 'output']

  showButton() {
    let inputValue = this.inputTarget.value
    let button = this.buttonTarget

     inputValue == 'goodbye' ? button.disabled = false : button.disabled = true
  }
}
