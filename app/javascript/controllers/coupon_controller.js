import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {

    checkCoupon(event){
        let code = document.getElementById('input').value
        this.sendToRails(code)
    }

    sendToRails(code) {
        Rails.ajax(
            {
                type: "GET",
                url: "/coupon_check?code=" + code,
                dataType: 'json',
                success(data){
                    if(data.error){
                        document.getElementById('error').innerText = "  " + data.error
                        document.getElementById('coupon_price').textContent = '€ 0.00'
                        document.getElementById('total_price').textContent = '€ ' + data.total_price
                    } else {
                        document.getElementById('coupon_price').textContent = '€ ' + data.discount
                        document.getElementById('total_price').textContent = '€ ' + data.total_price
                    }
                }
            }
        )
    }
}