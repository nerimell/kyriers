@extends('layouts.wrapper')




@section('page')
<div id="calcForm" class="col-xs-12">
    <div class="row">
        <div class="col-xs-12" id="calcFormTitle">
            <span>Заявка на отправку</span>
            <div id="calculationSections">
                <ul>
                    <li>
                        Обычная
                    </li>
                    <li>
                        Для магазина
                    </li>
                    <li>
                        Для ресторана
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-xs-12">
        {{ Form::open(['method' => 'POST', 'class' => 'form-control', 'id' => 'defaultDelivery']) }}
            <div class="form-group">
              <label class="control-label">Откуда</label>
              <input type="text" name="source" class="form-control source" id="source" onFocus="geolocate()" placeholder="Московский проспект, 25"></input>
            </div>
        {{ Form::close() }}
        </div>
    <!-- AIzaSyBi6MTjAMf0rk9fGX0krZL5f8qEcu1RFRI -->
    </div>
<div>
<div id="testLocationAutocomplete">




    <script>
        // This example displays an address form, using the autocomplete feature
        // of the Google Places API to help users fill in the information.

        var placeSearch, autocomplete;
        var componentForm = {
            street_number: 'short_name',
            route: 'long_name',
            locality: 'long_name',
            administrative_area_level_1: 'short_name',
            country: 'long_name',
            postal_code: 'short_name'
        };

        function initAutocomplete() {
            // Create the autocomplete object, restricting the search to geographical
            // location types.
            autocomplete = new google.maps.places.Autocomplete(
                    /** @type {!HTMLInputElement} */(document.getElementById('source')),
                    {types: ['geocode']});

            // When the user selects an address from the dropdown, populate the address
            // fields in the form.
            autocomplete.addListener('place_changed', fillInAddress);
        }

        // [START region_fillform]
        function fillInAddress() {
            // Get the place details from the autocomplete object.
            var place = autocomplete.getPlace();

            for (var component in componentForm) {
                document.getElementById(component).value = '';
                document.getElementById(component).disabled = false;
            }

            // Get each component of the address from the place details
            // and fill the corresponding field on the form.
            for (var i = 0; i < place.address_components.length; i++) {
                var addressType = place.address_components[i].types[0];
                if (componentForm[addressType]) {
                    var val = place.address_components[i][componentForm[addressType]];
                    document.getElementById(addressType).value = val;
                }
            }
        }
        // [END region_fillform]

        // [START region_geolocation]
        // Bias the autocomplete object to the user's geographical location,
        // as supplied by the browser's 'navigator.geolocation' object.
        function geolocate() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var geolocation = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };
                    var circle = new google.maps.Circle({
                        center: geolocation,
                        radius: position.coords.accuracy
                    });
                    autocomplete.setBounds(circle.getBounds());
                });
            }
        }
        // [END region_geolocation]

    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBi6MTjAMf0rk9fGX0krZL5f8qEcu1RFRI&signed_in=true&libraries=places&callback=initAutocomplete"
            async defer></script>
</div>
@endSection

@section('head_data')
<script src="{{ URL::asset('js/calcActions.js') }}"></script>
@endSection