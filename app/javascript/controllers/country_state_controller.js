import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

export default class extends Controller {
  static targets = ["country", "state"];

  updateStates() {
    let country = this.countryTarget.value;
    let path = this.countryTarget.dataset.path;
    let target = this.stateTarget.id;
    let name = this.stateTarget.name;

    fetch(`${path}?country=${country}&target=${target}&name=${name}`, {
      method: "GET",
      headers: { contentType: "text/html" },
    })
      .then((response) => response.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }
}
