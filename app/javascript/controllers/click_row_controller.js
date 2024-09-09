import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.element.addEventListener("click", this.handleClick.bind(this));
  }

  handleClick(event) {
    const url = this.urlValue;
    if (url) {
      window.location = url;
    }
  }
}
