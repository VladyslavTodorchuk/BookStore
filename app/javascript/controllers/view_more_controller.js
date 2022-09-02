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
        console.log(url)
        this.loadMore(url)
    }

    loadMore(url){
        Rails.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            success: (data) => {
                //this.entriesTarget.insertAdjacentHTML("beforeend", data.entries)
                //this.paginationTarget.insertAdjacentHTML = data.pagination
                console.log(data)
            }
        })
    }
}