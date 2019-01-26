// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"
import 'react-select/dist/react-select.css';


// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import "react-phoenix"

import $ from "jquery";

import App from './react/app'
window.Components = {
  App
}

window.addEventListener('message', function(event) {
  if(event.data.type != "INIT_INSTANCE") {
    event.data.forEach(function(element) {
      if(element.key == 'colour') {
        var html = document.getElementsByTagName('html')[0];
        html.style.cssText = `--primary: ${element.value}`;
      } else {
        $(`#${element.key}`).text(element.value)
      }
    });




      // $('#name').text(event.data);
  }
})

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
