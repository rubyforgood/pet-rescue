import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reinstate-explanation"
export default class extends Controller {
  static targets = ['icon', 'text']

  show() {
    if(this.textTarget.innerText == "") {
      this.textTarget.innerText = "The applicant has removed this application from their list. Check the box to reinstate this application if they have asked you to do so."
    } else {
      this.textTarget.innerText = ""
    }
  }
}
