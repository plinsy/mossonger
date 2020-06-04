function addCancelIcons() {
    $('[href="#add-cancel-icons"]').click(function(event) {
        alert('clicked');
        $(this).css({
            rotate: '45deg',
            'background-color': 'red'
        });
    });
}

function activeMessageForm() {
    $('.new-message-form').find('.input').keyup(function(event) {
        alert('keyed');
    });
}

addCancelIcons();
activeMessageForm();