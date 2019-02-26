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
      if(element.key == 'primaryColour') {
        var html = document.getElementsByTagName('html')[0];
        html.style.cssText += `--primary: ${element.value}`;
      } else if(element.key == 'secondaryColour') {
          var html = document.getElementsByTagName('html')[0];
          html.style.cssText += `--secondary: ${element.value}`;
      } else if(element.key == 'tertiaryColour') {
          var html = document.getElementsByTagName('html')[0];
          html.style.cssText += `--tertiary: ${element.value}`;
      } else if(element.key == 'quaternaryColour') {
          var html = document.getElementsByTagName('html')[0];
          html.style.cssText += `--quaternary: ${element.value}`;
      } else if(element.key == 'quniaryColour') {
          var html = document.getElementsByTagName('html')[0];
          html.style.cssText += `--quinary: ${element.value}`;
      } else if(element.key == "description"){
        if (!element.value) {
          $(`#${element.key}`).html('');
        } else {
          $(`#${element.key}`).html(element.value);
        }
      } else if (element.key == "showGoal") {
        if(element.value == true) {
          $(`#${element.key}`).show();
        } else {
          $(`#${element.key}`).hide();
        }
      } else if(element.key == "goalInDollars"){
        if (!element.value) {
          $(`#${element.key}`).text(formatCurrency(1000));
        } else {
          $(`#${element.key}`).text(formatCurrency(element.value));
        }
      } else if(element.key == "name") {
        $('#name').text(element.value);

      } else if(element.key == "header") {
        $('#header').text(element.value);
      } else if(element.key == "imageUrl") {
        $('#image').attr('src', element.value);
      } else if(element.key == "facebook_share") {
        if(element.value == "true") {
          $('#facebook_share').show();
          $('#social-header').show();
        } else {
          $('#facebook_share').hide();
        }
      } else if(element.key == "linkedin_share") {
        if(element.value == "true") {
          $('#linkedin_share').show();
          $('#social-header').show();
        } else {
          $('#linkedin_share').hide();
        }
      } else if(element.key == "twitter_share") {
        if(element.value == "true") {
          $('#twitter_share').show();
          $('#social-header').show();

        } else {
          $('#twitter_share').hide();
        }
      } else if(element.key == "email_share") {
        if(element.value == "true") {
          $('#email_share').show();
          $('#social-header').show();

        } else {
          $('#email_share').hide();
        }
      } else if(element.key == "font") {
        var html = document.getElementsByTagName('html')[0];
        html.style.cssText += `--font: ${element.value}`;
      }
    });
  }
})

function formatCurrency(value) {
  var dollars = value;
  var sign = '$';
  var opening = '<span>';
  var closing = '</span>';

  return `${sign}${dollars}.00`;
};

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
