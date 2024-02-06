import { Controller } from "@hotwired/stimulus";
import { patch } from "@rails/request.js";

export default class extends Controller {
  static values = {
    recurring: Boolean,
    completed: Boolean,
    path: String,
  };

  submit(e) {
    if (this.recurringValue && this.completedValue) {
      e.preventDefault();
      alert("Completed recurring tasks cannot be marked incomplete.");
      return;
    }
    patch(this.pathValue, {
      body: JSON.stringify({ completed: !this.completedValue }),
      responseKind: "turbo-stream",
    });
  }
}
