import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["increment", "decrement", "value"]

    decrementValue() {
        let price = document.getElementById("dec").getAttribute('value_price')
        let counter = document.getElementById("counter");

        if (counter.value > 1) {
            counter.value--;
            this.calculatePrice(price, counter.value);
        }
    }

    incrementValue() {
        let price = document.getElementById("inc").getAttribute('value_price')
        let quantity = document.getElementById("inc").getAttribute('value_books')
        let counter = document.getElementById("counter");

        if (counter.value != quantity) {
            counter.value++;
            this.calculatePrice(price, counter.value);
        }
    }

    calculatePrice(price, amount) {
        document.getElementById("price").textContent = '€' + (price * amount).toFixed(2);
    }
}
