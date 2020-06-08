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
//= require jquery
//= require popper
//= require bootstrap
//= require activestorage
//= require toastr
//= require_tree .

function loadAll() {
    toggleMainMenu();
    loadBootstrap();
    animateMessageContent();
    animateMessageContent();
    loadPlugins();
    removeCurrentModals();
}

function toggleMainMenu() {
    var $mainMenuToggler = $('#main-menu-toggler'),
        $target = $($mainMenuToggler.data('target'));
    $mainMenuToggler.on('click', function(event) {
        event.preventDefault();
        $(this).find('.material-icons').toggleClass('active');
        $target.fadeToggle('fast', function() {});
    });

    $mainMenuToggler.parent('.input-group').hover(function() {
        /* Stuff to do when the mouse enters the element */
    }, function() {
        $mainMenuToggler.find('.material-icons').removeClass('active');
        $target.fadeOut('fast', function() {});
        /* Stuff to do when the mouse leaves the element */
    });
}

function fullscreenAble() {
    var goFS = document.getElementById("goFS");
    if (goFS != null) {
        goFS.addEventListener("click", function() {
            toggleFullScreen();
        }, false);
    }
}

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
        $('body').toggleClass('dark');
    } else {
        // var docElm = document.body; // dark mode
        var docElm = document.documentElement;
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
        $('body').toggleClass('dark');
    }
}

function loadBootstrap() {
    // tooltip
    $("[data-toggle='tooltip']").tooltip({ boundary: 'window' });
    // dropdown
    $("[data-toggle='dropdown']").dropdown();
}

function animateMessageContent() {
    // message content
    $('.message .content').on('mousedown', function(e) {
        var href = $(this).attr('href'),
            $href = $(href);
        $href.fadeIn('fast');
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
        $href.fadeOut('fast');
    });
}

function loadNiceScroll(data) {
    var $chat_body = $('.chat-body:first');
    if (data['scroll']) {
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
    } else {
        $chat_body.niceScroll({
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
}

function loadPlugins() {
    // remove
    $("[data-toggle='remove']").click(function(event) {
        event.preventDefault();
        var $target = $($(this).data('target'));
        $target.fadeOut('slow', function() {
            $(this).remove();
        });
    });

    // .add-cancel-icons
    $('.add-cancel-icons').click(function(event) {
        event.preventDefault();
        $($(this).attr('href')).fadeToggle('fast', function() {});
        $(this).toggleClass('active');
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

    // submit message
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
}

function removeCurrentModals() {
    $('.modal').fadeOut('fast', function() {});
    $('.modal-backdrop.show').fadeOut('fast', function() {
        $(this).remove();
    });
    $("[data-toggle='remove']").click();
}