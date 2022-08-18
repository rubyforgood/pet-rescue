import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['additional', 'checked']

  // ensure 'additional' divs are displayed if Yes radio is checked
  // i.e. when going back to edit the form
  connect() {    
    let nodeList = this.checkedTarget.childNodes

    for (let i = 0; i < nodeList.length; i++) {
      let child = nodeList[i];
      console.log(child)
      if (child.type == 'radio' && 
          child.value == 'true' && 
          child.checked == true) {
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