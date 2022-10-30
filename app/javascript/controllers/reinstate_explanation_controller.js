import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reinstate-explanation"
export default class extends Controller {
  static targets = ['icon', 'text']

  show() {
    if(this.textTarget.innerText == "") {
      this.textTarget.classList.add('explanation', 'rounded', 'p-2', 'mb-4')
      this.textTarget.innerText = "The applicant has removed this application from their list. Check the box and update the status to reinstate this application if they have asked you to do so."
    } else {
      this.textTarget.classList.remove('mb-4', 'explanation', 'rounded', 'p-2')
      this.textTarget.innerText = ""
    }
  }
}
