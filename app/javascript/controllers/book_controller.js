import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {

    addToCard(event) {
        let hash = { product: {
                book_id: event.params.book, order_id: event.params.order, book_count: event.params.count
            } }
        this.sendToRails(hash, 'Get', 'add_to_cart')
    }

    sendToRails(my_data, type, controller_method) {
        Rails.ajax(
            {
                type: "GET",
                url: "/order/" + my_data.product.order_id + "/" + controller_method + "?book_id=" + my_data.product.book_id + "&quantity=" + my_data.product.book_count ,
                dataType: 'json',
                success(data){
                    let count_orders = parseInt(document.getElementById('books_count').innerText)
                    count_orders += 1

                    document.getElementById('books_count').innerHTML = '<span class="shop-quantity" id="books_count">' + count_orders + '</span>'
                    document.getElementById('books_count_mobile').innerHTML = '<span class="shop-quantity" id="books_count_mobile">' + (parseInt(count_orders) + 1) + '</span>'
                }
            }
        )
    }

}

