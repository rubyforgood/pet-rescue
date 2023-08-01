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

    // Set state dropdown to empty initially
    this.stateTarget.value = null;
  }

  setStateDropdown() {
    locationHelper.country_states[this.selectedCountry].forEach((state) => {
      this.stateTarget.options.add(new Option(state, state));
    });

    // Set state dropdown to the initial value
    this.stateTarget.value = this.selectedState;
  }

  updateStates() {
    // Remove all state options and add new states according to selected country
    this.stateTarget.options.length = 0;

    this.selectedCountry = this.countryTarget.value;

    this.setStateDropdown();
  }
}
