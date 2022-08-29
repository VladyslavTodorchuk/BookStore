// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

global.jQuery = require('jquery');
import 'bootstrap'

require('../../assets/javascripts/bootstrap.js');
require('../../assets/javascripts/jquery.js');
require('../../assets/javascripts/custome.js')

import '../../assets/stylesheets/application.css'


Rails.start()
Turbolinks.start()
ActiveStorage.start()


