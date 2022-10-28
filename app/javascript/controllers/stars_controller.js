import { Controller } from "stimulus"

export default class extends Controller {
    get_rating(event) {
        document.getElementById('rating').value = event.params.star

        for(let i = 0; i < event.params.star; i++) {
            document.getElementById("star" + (i + 1)).className = 'fa fa-star rate-star'
        }

        for(let i = 5; i > event.params.star; i--) {
            document.getElementById("star" + i).className = 'fa fa-star rate-empty'
        }
    }
}
