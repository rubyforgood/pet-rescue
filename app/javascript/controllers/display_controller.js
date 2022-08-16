import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['additional']

  // ensure 'additional' divs are displayed if they have received input
  // i.e. when going back to edit the form
  connect() {    
    let nodeList = this.additionalTarget.childNodes

    for (let i = 0; i < nodeList.length; i++) {
      let child = nodeList[i];
      if (child.tagName == 'TEXTAREA' && child.value.length > 0) {
        this.show()
      } else if (child.tagName == 'INPUT' && child.checked == true) {
        this.show()
      }
    }
  }
  
  show() {
    let style = this.additionalTarget.classList
    style.remove('d-none')
  }

  hide() {
    let style = this.additionalTarget.classList
    style.add('d-none')
  }
}