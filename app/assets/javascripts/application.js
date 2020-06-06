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
//= require turbolinks
//= require jquery
//= require popper
//= require bootstrap
//= require activestorage
//= require toastr
//= require_tree .

function loadTooltip() {
    $("[data-toggle='tooltip']").tooltip({ boundary: 'window' });
}

function animateMessageContent() {
    // message content
    $('.message .content').on('mousedown', function(e) {
        var href = $(this).attr('href'),
            $href = $(href);
        $href.toggleClass('show');
    });
    $('.message .content').on('dblclick', function(e) {
        e.preventDefault();
        var target = $(this).data('target'),
            $target = $(target);
        $target.modal('show');
    });
    $('.message .content').hover(function() {

    }, function() {
        var target = $(this).data('target'),
            href = $(this).attr('href'),
            $target = $(target),
            $href = $(href);
        $target.removeClass('show');
        $href.removeClass('show');
    });
}

function loadNiceScroll() {
    var $chat_body = $('.chat-body:first');
    $chat_body.scrollTop($chat_body.get(0).scrollHeight, -1).niceScroll({
        cursorcolor: "#424242", // change cursor color in hex
        cursoropacitymin: 0, // change opacity when cursor is inactive (scrollabar "hidden" state), range from 1 to 0
        cursoropacitymax: 1, // change opacity when cursor is active (scrollabar "visible" state), range from 1 to 0
        cursorwidth: "5px", // cursor width in pixel (you can also write "5px")
        cursorborder: "1px solid #fff", // css definition for cursor border
        cursorborderradius: "5px", // border radius in pixel for cursor
        scrollspeed: 100, // scrolling speed
        mousescrollstep: 100 // scrolling speed with mouse wheel (pixel)
    }).resize();
}