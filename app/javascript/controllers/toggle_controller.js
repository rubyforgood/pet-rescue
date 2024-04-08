import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = [ "toToggle" ]
  static classes = [ "change" ]

  toggle() {
    this.toToggleTarget.classList.toggle(this.changeClass)
  }
}
