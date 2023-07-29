import { Controller } from "@hotwired/stimulus"

/**
 * Add mutation to move the scroll to the bottom of the chat when
 * it is updated.
 */

export default class extends Controller {
  connect() {
    this.element.scrollIntoView()
  }
}
