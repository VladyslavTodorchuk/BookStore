import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {

    setBookQuantity(event){
        event.params.code = document.getElementById('input').value
        this.getAjax(event.params)
    }

    getAjax(params){
        Rails.ajax(
            {
                type: "PUT",
                url: "/orders/" + params.order + "/order_update_book?book_id=" + params.book + "&quantity=" + params.quantity + "&code=" + params.code,
                dataType: 'json',
                success(data){
                    if(params.quantity != 0){
                        document.getElementById('dec' + params.book).setAttribute('data-quantity-quantity-param', params.quantity - 1)
                    }
                    if(params.quantity < data.book_quantity) {
                        document.getElementById('inc' + params.book).setAttribute('data-quantity-quantity-param', params.quantity + 1)
                    }
                    document.getElementById('counter' + params.book).setAttribute('value', params.quantity)

                    document.getElementById('coupon_price').textContent = '€ ' + data.discount
                    document.getElementById('price' + params.book).textContent = '€ ' + data.price
                    document.getElementById('sub_price').textContent = '€ ' + data.sub_price
                    document.getElementById('total_price').textContent = '€ ' + data.total_price
                }
            }
        )
    }

}
