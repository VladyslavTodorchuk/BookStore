
let readMore = () => {
    if (document.getElementById('full_description')){
        $("#full_description").replaceWith("= render partial: 'books/show/short_description'");
    }
    else {
        $("#short_description").replaceWith("= render partial: 'books/show/full_description'");
    }
}

let decrementValue = (price) => {
    let input = document.getElementById("counter");

    if (input.value > 1) {
        input.value--;
        calculatePrice(price, input.value);
    }

}

let incrementValue = (price) => {
    let input = document.getElementById("counter");

    input.value++;
    calculatePrice(price, input.value);
}

let calculatePrice = (price, amount) => {
    let price_element = document.getElementById("price");
    let currency = price_element.textContent.substring(0, 1);

    price_element.textContent = currency + (price * amount).toFixed(2);
}