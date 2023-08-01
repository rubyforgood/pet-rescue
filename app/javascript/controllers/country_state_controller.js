import { Controller } from "@hotwired/stimulus";
import { locationHelper } from "../helpers/locationHelper.js";

export default class extends Controller {
  static targets = ["country", "state"];

  connect() {
    this.selectedCountry = this.countryTarget.dataset.initialValue;
    this.selectedState = this.stateTarget.dataset.initialValue;

    this.setCountryDropdown();
    this.setStateDropdown();
  }

  setCountryDropdown() {
    locationHelper.countries.forEach((country) => {
      this.countryTarget.options.add(new Option(country, country));
    });

    // Set country dropdown to the initial value
    this.countryTarget.value = this.selectedCountry;

    // Set state dropdown to empty
    this.stateTarget.options.length = 0;
  }

  setStateDropdown() {
    locationHelper.country_states[this.selectedCountry].forEach((state) => {
      this.stateTarget.options.add(new Option(state, state));
    });

    // Set state dropdown to the initial value
    this.stateTarget.value = this.selectedState;
  }

  updateStates() {
    // Remove old state options
    this.stateTarget.options.length = 0;

    // Update the selected country based on the user's selection
    this.selectedCountry = this.countryTarget.value;

    // Add new states according to the selected country
    this.setStateDropdown();
  }
}
