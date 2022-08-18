import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['additional', 'checked']

  // ensure 'additional' divs are displayed on form load if certain radio is checked
  // i.e. when going back to edit the form
  connect() {    
    let nodeList = this.checkedTarget.childNodes

    for (let i = 0; i < nodeList.length; i++) {
      let child = nodeList[i];
      console.log(child)
      if (child.id == 'adopter_profile_fenced_access_false' &&
          child.checked == true) {
          this.show()
      } else if (child.type == 'radio' &&
                 child.id != 'adopter_profile_fenced_access_true' &&
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