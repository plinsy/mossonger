import consumer from "./consumer"

consumer.subscriptions.create("ConversationChannel", {
    connected() {
        // Called when the subscription is ready for use on the server
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        if ($('body').data('c_id') == data['c_id']) {
            var $messages = $("#messages"),
                $conversation = $('#conversation-' + data['c_id']);
            if ($('body').data('profile') == data['sender_id']) {
                $messages.append(data['message_sender_view']);
            } else {
                $messages.append(data['message_guests_view']);
            }
            $conversation.replaceWith(data['c_view']);
            var $chat_body = $('.chat-body:first');
            $chat_body.scrollTop($chat_body.get(0).scrollHeight, -1).niceScroll({
                cursorcolor: "#424242",
                cursoropacitymin: 0,
                cursoropacitymax: 1,
                cursorwidth: "5px",
                cursorborder: "1px solid #fff",
                cursorborderradius: "5px",
                scrollspeed: 100,
                mousescrollstep: 40
            }).resize();
            // $messages.animate({ scrollTop: 999999999 }, 'fast', function() {});
        }
        // Called when there's incoming data on the websocket for this channel
    },

    speak: function(data) {
        return this.perform('speak', data);
    }
});

$(document).on('turbolinks:load', function() {
    // $("#messages").niceScroll({cursorcolor:"#00F"});
    var goFS = document.getElementById("goFS");
    goFS.addEventListener("click", function() {
        toggleFullScreen();
    }, false);

    function toggleFullScreen() {
        var isInFullScreen = document.fullscreenElement && document.fullscreenElement !== null;
        if (isInFullScreen) {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            } else if (document.webkitExitFullscreen) {
                document.webkitExitFullscreen();
            } else if (document.mozCancelFullScreen) {
                document.mozCancelFullScreen();
            } else if (document.msExitFullscreen) {
                document.msExitFullscreen();
            }
            $('#fullscreen-icon').html('fullscreen');
        } else {
            var docElm = document.body; // dark mode
            // var docElm = document.documentElement;
            if (docElm.requestFullscreen) {
                docElm.requestFullscreen();
            } else if (docElm.mozRequestFullScreen) {
                docElm.mozRequestFullScreen();
            } else if (docElm.webkitRequestFullScreen) {
                docElm.webkitRequestFullScreen();
            } else if (docElm.msRequestFullscreen) {
                docElm.msRequestFullscreen();
            }
            $('#fullscreen-icon').html('fullscreen_exit');
        }
    }

    var $messages = $("#messages"),
        lastMessage = $messages.find('.message:last');
    // $messages.animate({ scrollTop: 999999999 }, 1500, function() {});
    var $newMsgForm = $('#new-message-form'),
        $submitBtn = $newMsgForm.find('[type="submit"]'),
        $input = $newMsgForm.find('textarea');
    $input.keyup(function(event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            $submitBtn.click();
            setTimeout(function() {
                $input.val('');
                $input.focusout();
            }, 100);
        }
    });

    // tabs
    $('[data-toggle="linx-tab"]').click(function(event) {
        event.preventDefault();
        var targets = $(this).attr('href'),
            $targets = $(targets);

        $.each($targets, function(index, target) {
            var $target = $(target);
            $target.siblings('.tab-pane').removeClass('active');
            $target.addClass('active');
        });
    });

    // conversations search
    $('#conversations_q').keyup(function(event) {
        var target = $(this).data('target'),
            $target = $(target);

        if ($target.hasClass('dropdown-menu')) {
            if (event.target.value == "") {
                $target.dropdown('hide');
            } else {
                $target.dropdown('show');
            }
        }
        $('#search-conversation-btn').click();
    });

    // no right click
    $('body.conversations').on('contextmenu', function(e) {
        e.preventDefault();
    });

    // .add-cancel-icons
    $('.add-cancel-icons').click(function(event) {
        /* Act on the event */
        $(this).toggleClass('active');
    });

    $.getScript('/assets/application.js', function() {
        loadTooltip();
        animateMessageContent();
        loadNiceScroll();
    });
});