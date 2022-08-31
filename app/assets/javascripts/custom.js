function decrementValue(price) {
    let counter = document.getElementById("counter");
    if (counter.value > 1) {
        counter.value--;
        calculatePrice(price, counter.value);
    }
}

function incrementValue(price) {
    let counter = document.getElementById("counter");
    counter.value++;
    calculatePrice(price, counter.value);
}

function calculatePrice(price, amount) {
    document.getElementById("price").textContent = '€ ' + (price * amount).toFixed(2);
}
