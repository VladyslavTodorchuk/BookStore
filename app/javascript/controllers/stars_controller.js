import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["star1", "star2", "star3", "star4", "star5", "input"]

    get_rating(event) {
        document.getElementById('rating').value = event.params.star

        for(let i = 0; i < event.params.star; i++) {
            console.log("star" + (i + 1))
            document.getElementById("star" + (i + 1)).className = 'fa fa-star rate-star'
        }

        for(let i = 5; i > event.params.star; i--) {
            console.log("empty" + i)
            document.getElementById("star" + i).className = 'fa fa-star rate-empty'
        }

    }
}