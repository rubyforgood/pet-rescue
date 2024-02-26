import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["recurring", "daysField", "dueDate"];

  updateDueInDaysField() {
    if (this.recurringTarget.checked && this.dueDateTarget.value) {
      this.daysFieldTarget.disabled = false;
    } else {
      this.daysFieldTarget.value = "";
      this.daysFieldTarget.disabled = true;
    }
  }
}
