import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {

    addToCard(event) {
        this.sendToRails(
            {
                product: {
                    book_id: event.params.book, order_id: event.params.order, book_count: event.params.count
                }
            }
        )
    }

    sendToRails(my_data){
        Rails.ajax(
            {
                type: "GET",
                url: "/order/" + my_data.product.order_id + "/add_to_cart?book_id=" + my_data.product.book_id + "&quantity=" + my_data.product.book_count ,
                dataType: 'json',
                success(data){
                    console.log(data.notice)

                    let count_orders = document.getElementById('books_count').innerText
                    document.getElementById('books_count').innerHTML = '<span class="shop-quantity" id="books_count">' + (parseInt(count_orders) + 1) + '</span>'
                    document.getElementById('books_count_mobile').innerHTML = '<span class="shop-quantity" id="books_count_mobile">' + (parseInt(count_orders) + 1) + '</span>'
                }
            }
        )
    }
}

