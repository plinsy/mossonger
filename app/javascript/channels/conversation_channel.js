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
            $.getScript('/assets/application.js', function() {
                loadBootstrap();
                animateMessageContent();
                loadNiceScroll({ scroll: true });
                loadPlugins();
                removeCurrentModals();
            });
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

    // no right click
    $('body.conversations').on('contextmenu', function(e) {
        e.preventDefault();
    });

    $.getScript('/assets/application', function() {
        fullscreenAble();
        loadBootstrap();
        animateMessageContent();
        loadNiceScroll({ scroll: true });
        loadPlugins();
        removeCurrentModals();
    });
});