import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["country", "state", "form"];

  connect() {
    this.jsonData = JSON.parse(this.formTarget.attributes["data-json"].value);
    this.country_states = this.jsonData.country_states;
  }

  updateStates() {
    // Remove all options from state select
    this.stateTarget.options.length = 0;

    let country = this.countryTarget.value;
    let states = this.country_states[country] || [];

    // Add new options
    states.forEach((state) => {
      // <option value="Ontario">Ontario</option>
      this.stateTarget.options.add(new Option(state, state));
    });
  }
}
