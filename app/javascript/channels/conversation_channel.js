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
            var $messages = $("#messages");
            if ($('body').data('profile') == data['sender_id']) {
                $messages.prepend(data['message_sender_view']);
            } else {
                $messages.prepend(data['message_guests_view']);
            }
            // $messages.animate({ scrollTop: 999999999 }, 'fast', function() {});
        }
        // Called when there's incoming data on the websocket for this channel
    },

    speak: function(data) {
        return this.perform('speak', data);
    }
});

$(document).ready(function() {
    function gotoBottom(id) {
        var element = document.getElementById(id);
        element.scrollTop = element.scrollHeight - element.clientHeight;
    }

    var $messages = $("#messages"),
        lastMessage = $messages.find('.message:last');
    // $messages.animate({ scrollTop: 999999999 }, 1500, function() {});
    $("[data-toggle='tooltip']").tooltip({ boundary: 'window' });
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

    // message content
    $('.message .content').contextmenu(function(e) {
        e.preventDefault();
        var target = $(this).data('target'),
            $target = $(target);
        $target.show();
    });
});