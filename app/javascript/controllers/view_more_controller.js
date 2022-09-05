import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
    static targets = ["entries", "pagination", "button"]


    next() {
        let next_page = this.paginationTarget.querySelector("a[rel='next']")

        if(next_page == null) {
            return
        }

        let url = next_page.href
        this.loadMore(url)
    }

    loadMore(url){
        Rails.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            success: (data) => {
                this.hide(data.pagination)
                this.entriesTarget.insertAdjacentHTML("beforeend", data.entries)
                this.paginationTarget.innerHTML = data.pagination
            }
        })
    }

    //<li class="next next_page disabled"><a href="#">Next &#8594;</a></li>
    hide(data){
        if (data.search("\<li class=\"next next_page disabled\"><a href=\"#\">Next &#8594;</a></li\>") > 0){
            this.buttonTarget.classList.add("hidden")
        } else {
            this.buttonTarget.classList.remove("hidden")
        }
    }
}
