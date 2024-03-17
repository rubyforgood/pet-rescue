import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "menu"];

  initialize() {
    this.close();
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
}
