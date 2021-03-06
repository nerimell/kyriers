$(document).ready(function() {


    $('body').on('click', '.AppLabsSelectProto .currentValue', function() {
        var thisSelect = $(this).closest('.AppLabsSelectProto');
        $('.AppLabsSelectProto').not(thisSelect).removeClass('toggled');
        $(thisSelect).toggleClass('toggled');
    });

    $('body').on('click', '.AppLabsSelectProto ul li', function() {
        var alsp = $(this).closest('.AppLabsSelectProto');
        var ul = $(this).closest('ul');
        var connect = $(alsp).attr('data-connect');
        var theValue = $(this).attr('data-value');
        var textValue = $(this).html();
        if(!theValue) {
            return false;
        }
        $(alsp).find('.currentValue').html(textValue);
        if(connect) {
            var currentVal = $('#' + connect).val();
            if(currentVal != theValue) {
                $('#' + connect).val(theValue).trigger('change');
            }
        }

        $(ul).find('li').not(this).removeClass('current');
        $(this).addClass('current');
        $(this).closest('.AppLabsSelectProto').removeClass('toggled');

    });

    $('body').on('click', '.div_based_checkbox', function() {
        $(this).toggleClass('checked');
    });

    $('body').on('click', '#toggle_all_cbs', function() {
        var target = $(this).attr('data-target');
        if($(this).hasClass('checked')) {
            $('#'+target).find('.div_based_checkbox').addClass('checked');
        } else {
            $('#'+target).find('.div_based_checkbox').removeClass('checked');
        }
    });

    $(document).click(function (event) {
        if (!$(event.target).closest('.AppLabsSelectProto').length) {
            $('.AppLabsSelectProto').removeClass('toggled');
        }
    })



});


$(function () {
    $.widget("custom.combobox", {
        _create: function () {
            this.wrapper = $("<span>")
                .addClass("combobox-wrapper")
                .insertAfter(this.element);

            this.element.hide();
            this._createAutocomplete();
            this._createShowAllButton();
        },

        _createAutocomplete: function () {
            var input_id = $(this.element).attr('id') + '_input';
            var selected = this.element.children(":selected"),
                value = selected.val() ? selected.text() : "";

            this.input = $("<input>")
                .appendTo(this.wrapper)
                .val(value)
                .attr("title", "")
                .addClass("combobox-input form-control")
                .attr('id',  input_id)
                .autocomplete({
                    delay: 0,
                    minLength: 0,
                    appendTo: this.wrapper,
                    width: 'auto',
                    source: $.proxy(this, "_source")
                })
                .tooltip({
                    classes: {
                        "ui-tooltip": "ui-state-highlight"
                    }
                });

            this._on(this.input, {
                autocompleteselect: function (event, ui) {
                    ui.item.option.selected = true;
                    this._trigger("select", event, {
                        item: ui.item.option
                    });
                },

                autocompletechange: "_removeIfInvalid"
            });
        },

        _createShowAllButton: function () {
            var input = this.input,
                wasOpen = false;

            $("<a>")
                .attr("tabIndex", -1)
                .appendTo(this.wrapper)
                .removeClass("ui-corner-all")
                .addClass("combobox-toggle fa fa-caret-down ui-corner-right")
                .on("mousedown", function () {
                    wasOpen = input.autocomplete("widget").is(":visible");
                })
                .on("click", function () {
                    input.trigger("focus");

                    // Close if already visible
                    if (wasOpen) {
                        return;
                    }

                    // Pass empty string as value to search for, displaying all results
                    input.autocomplete("search", "");
                });
        },

        _source: function (request, response) {
            var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
            response(this.element.children("option").map(function () {
                var text = $(this).text();
                if (this.value && ( !request.term || matcher.test(text) ))
                    return {
                        label: text,
                        value: text,
                        option: this
                    };
            }));
        },

        _removeIfInvalid: function (event, ui) {

            // Selected an item, nothing to do
            if (ui.item) {
                return;
            }

            // Search for a match (case-insensitive)
            var value = this.input.val(),
                valueLowerCase = value.toLowerCase(),
                valid = false;
            this.element.children("option").each(function () {
                if ($(this).text().toLowerCase() === valueLowerCase) {
                    this.selected = valid = true;
                    return false;
                }
            });

            // Found a match, nothing to do
            if (valid) {
                return;
            }

            // Remove invalid value

            this.element.val("");
            this._delay(function () {
                this.input.tooltip("close").attr("title", "");
            }, 2500);
            this.input.autocomplete("instance").term = "";
        },

        _destroy: function () {
            this.wrapper.remove();
            this.element.show();
        }
    });



});




$(document).ready(function() {
    $(".combobox").combobox({

    });
    $('#registrationCity_input').attr('placeholder', 'Выберите город');
});