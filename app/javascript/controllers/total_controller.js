import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="total"
export default class extends Controller {
  static targets = ["quantity", "subtotal"]

  connect() {
    console.log("hello world!")



  }
  decrement(event){
    console.log("This - is working")
  }

  increment(event){
    console.log("This + is working")

  }

  changeTotal(event){
    const quantity = this.quantityTarget.value;
    const price = this.subtotalTarget.innerHTML
    const total = quantity * price
    console.log("This is working")
    console.log(total)


  }

}
