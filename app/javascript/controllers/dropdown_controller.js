import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  initialize() {
    this.close();
  }

  toggle() {
    this.menuTarget.hidden === true ? this.open() : this.close();
  }

  open() {
    this.menuTarget.hidden = false;
  }

  close() {
    this.menuTarget.hidden = true;
  }
}
