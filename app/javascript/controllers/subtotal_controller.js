import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="subtotal"
export default class extends Controller {
  static targets = ["subtotal", "shipping", "final"]

  connect() {
    console.log("hello from subtotal");
    this.total = 0; // Initialise le sous-total global
    window.addEventListener("subtotal:updated", this.updateSubtotal.bind(this));
  }

  updateSubtotal(event) {
    const calculations = document.querySelectorAll("[data-quantity-target='calculation']");

    // Additionne leurs valeurs
    let total = 0;
    calculations.forEach(calculation => {
      total += parseFloat(calculation.innerText || "0");
    });
    // Met à jour le sous-total global
    this.subtotalTarget.textContent = total.toFixed(2);
    this.finalTarget.textContent = (total + parseInt(this.shippingTarget.innerText)).toFixed(2)
  }
}
