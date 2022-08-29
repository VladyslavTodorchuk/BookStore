
function readMore(){
    if (document.getElementById('full_description')){
        $("#full_description").replaceWith("= render partial: 'books/show/short_description'");
    }
    else {
        $("#short_description").replaceWith("= render partial: 'books/show/full_description'");
    }
}