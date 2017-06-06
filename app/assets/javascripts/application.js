// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery

$(document).on("click", "[data-role=add-nested]", function (event) {
    // $("[data-role=add-nested]").click(function (event) {
    var date = new Date().getTime();
    var template = $(this).data("template").replace(/__ID__/g, date);
    $(this).before(template);
    event.preventDefault();
    // });
});

$(document).on("click", "[data-role=remove-nested ]", function (event) {
    $(this).prev("input[type=hidden]").val("1");
    $(this).parent().hide();
    event.preventDefault();
});