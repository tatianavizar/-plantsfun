import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity"
export default class extends Controller {
  static targets = ["quantity", "price", "calculation"]
  connect() {
  }
  decrement(){
    const newQuantity = parseInt(this.quantityTarget.value) - 1
    this.calculate(newQuantity)
  }

  increment(){
    const newQuantity = parseInt(this.quantityTarget.value) + 1
    this.calculate(newQuantity)
  }

  changeTotal(){
    const newQuantity = this.quantityTarget.value;
    this.calculate(newQuantity)
  }

  calculate(quantity){
    const articleTotal = quantity * this.priceTarget.innerHTML;
    this.calculationTarget.innerText = articleTotal.toFixed(2);
    this.subtotal()
  }

  subtotal(){
    const event = new CustomEvent("subtotal:updated", { bubbles: true });
    window.dispatchEvent(event); // Émet l'événement au niveau global
  }
}
