import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['input', 'output']


  countMedium() {
    this.count(200)
  }

  countLarge() {
    this.count(500)
  }

  countExtraLarge() {
    this.count(1000)
  }

  count(characters) {
    const max = characters - 1;
    let output = this.outputTarget;
    let input = this.inputTarget;
    let counter = 0 + input.value.length;

    output.innerText = `${counter}/${characters}`;
    counter >= (characters - 10) ? output.style.cssText='color: red;' : output.style.cssText='color:black;'

    if(input.value.length >= max) {
      input.value = input.value.substr(0, max);
    }
  }
}