import consumer from "./consumer"

consumer.subscriptions.create("ConversationChannel", {
    connected() {
        // Called when the subscription is ready for use on the server
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        const $messages = $("#messages");
        $messages.append(data['message_view']);
        // Called when there's incoming data on the websocket for this channel
    },

    speak: function(data) {
        return this.perform('speak', data);
    }
});

$(document).ready(function() {
    var $newMsgForm = $('#new-message-form'),
        $submitBtn = $newMsgForm.find('[type="submit"]'),
        $input = $newMsgForm.find('textarea');
    $input.keyup(function(event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            $submitBtn.click();
            setTimeout(function() {
                $input.val('');
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
});