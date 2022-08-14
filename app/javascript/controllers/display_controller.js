import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['smell']

  show() {
    let css = this.smellTarget.classList
    css.remove('d-none')
  }

  hide() {
    let css = this.smellTarget.classList
    css.add('d-none')
  }
}