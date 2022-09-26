
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//  https://github.com/rails/jquery-rails
//= require jquery
//= require_tree .

function showPassword(field) {
      let passwordField = document.getElementById(field);

       if (passwordField.type === "password") {
            passwordField.type = "text";
      } else  {
            passwordField.type = "password";
      }
}

function searchAddress(field) {
        let postalCode = $('#professional_postal_code').val();

        Rails.ajax({
                type: 'GET',
                url: '/users/address',
                data: new URLSearchParams({'postal_code': postalCode}).toString(),
                success: function (response) {
                        console.log(response.address);

                        $('#professional_address').val(response.address.address);
                        $('#professional_district').val(response.address.neighborhood);
                        $('#professional_state').val(response.address.state);

                        listCities(response.address.state, professional_city);

                        disableProfessionalFields(true);
                },
                error: function(xhr,status,error){
                        console.log(xhr);
                }
        });
}

function disableProfessionalFields(value) {
        $('#professional_address').prop('disabled', value);
        $('#professional_district').prop('disabled', value);
        $('#professional_state').prop('disabled', value);
}

function listCities(state_name, receptorField) {
        let citiesList = [];
        let citiesTotal = 0;

        Rails.ajax({
                type: 'GET',
                url: '/users/cities',
                data: new URLSearchParams({'state_name': state_name}).toString(),
                success: function (response) {
                        let citiesList = [];
                        let citiesLength = 0;
                        let citiesOptions = "";

                        citiesList = response.cities;
                        citiesLength = citiesList.length

                        for(let i = 0; i < citiesLength ; i++) {
                                citiesOptions += "<option>" + citiesList[i] + "</option>"
                        }

                        receptorField.innerHTML = citiesOptions;
                },
                error: function(xhr,status,error){
                        console.log(xhr);
                }
        });
}
