import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {

    addToCart(event) {
        let hash = { book_id: event.params.book, order_id: event.params.order, book_count: event.params.count }
        this.sendToRails(hash)
    }

    sendToRails(my_data) {
        Rails.ajax(
            {
                type: "GET",
                url: "/orders/" + my_data.order_id + "/add_to_order?book_id=" + my_data.book_id + "&quantity=" + my_data.book_count ,
                dataType: 'json',
                success(data){
                    document.getElementById('books_count').innerHTML = '<span class="shop-quantity" id="books_count">' + data.count + '</span>'
                    document.getElementById('books_count_mobile').innerHTML = '<span class="shop-quantity" id="books_count_mobile">' + data.count + '</span>'
                }
            }
        )
    }

}
