import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['input', 'output']

  count() {
    const max = 199;
    let output = this.outputTarget;
    let input = this.inputTarget;
    let counter = 0 + input.value.length;

    output.innerText = `${counter}/200`;
    counter >= 190 ? output.style.cssText='color: red;' : output.style.cssText='color:black;'

    if(input.value.length >= max) {
      input.value = input.value.substr(0, max);
    }
  }
}