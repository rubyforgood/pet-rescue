import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    var toast = new bootstrap.Toast(this.element, { delay: 3500 })
    toast.show()
  }
}
