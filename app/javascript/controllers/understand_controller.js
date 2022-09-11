import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["button", "understand_button"]

    understand(){
        let disabled_value = this.buttonTarget.disabled

        if(disabled_value)
        {
            this.buttonTarget.disabled = false
        }
        else
        {
            this.buttonTarget.disabled = true
        }
    }

}