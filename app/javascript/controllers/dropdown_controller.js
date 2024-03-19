import { Controller } from "@hotwired/stimulus";

// Dropdown menu controller
// Use only where theme dropdown menu defaults (hover-open) are undesirable.
export default class extends Controller {
  static targets = ["button", "menu"];

  initialize() {
    this.close();
    this.closeMenuOnOutsideClick = this.closeMenuOnOutsideClick.bind(this);
  }

  connect() {
    window.addEventListener("click", this.closeMenuOnOutsideClick);
  }

  disconnect() {
    window.removeEventListener("click", this.closeMenuOnOutsideClick);
  }

  toggle() {
    this.menuTarget.hidden === true ? this.open() : this.close();
  }

  open() {
    this.menuTarget.hidden = false;
    this.menuTarget.setAttribute("aria-hidden", "false");
    this.buttonTarget.setAttribute("aria-expanded", "true");
  }

  close() {
    this.menuTarget.hidden = true;
    this.menuTarget.setAttribute("aria-hidden", "true");
    this.buttonTarget.setAttribute("aria-expanded", "false");
  }

  closeMenuOnOutsideClick(event) {
    if (this.element === event.target || this.element.contains(event.target)) {
      return;
    }

    this.close();
  }
}
