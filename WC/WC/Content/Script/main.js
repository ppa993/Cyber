
function InitializeMenuJS() {
    /*LEFT SIDE BAR*/
    $("#bt-right-sb").click(function () {
        if ($("#right-sb").css('display') === 'block') {
            $("#right-sb").hide();
            return;
        }

        $("#right-sb").show(); return false;
    }); 

    /*LEFT SIDE BAR*/
    $("#bt-left-sb").click(function () {
        if ($("#left-sb").css('display') === 'block') {
            $("#left-sb").hide();
            return;
        }
        $("#left-sb").show(); return false;
    }); 

    /*PROFILE*/
    $("#bt-small-profile").click(function () {
        if ($("#ul-friend-notify").css('display') === 'block') {
            $("#ul-friend-notify").hide();
        }
        if ($("#ul-notification").css('display') === 'block') {
            $("#ul-notification").hide();
        }
        $("#ul-small-profile").show(); return false;
    }); 

    $("#bt-small-profile").click(function (e) {
        e.stopPropagation();
    });

    /*NOTIFY*/
    $('#bt-notification').click(function () {
        if ($("#ul-friend-notify").css('display') === 'block') {
            $("#ul-friend-notify").hide();
        }
        if ($("#ul-small-profile").css('display') === 'block') {
            $("#ul-small-profile").hide();
        }
        $('#ul-notification').show(); return false;
    }); 

    $('#bt-notification').click(function (e) {
        e.stopPropagation();
    });

    /*FRIEND NOTIFY*/
    $('#bt-friend-notify').click(function () {
        if ($("#ul-notification").css('display') === 'block') {
            $("#ul-notification").hide();
        }
        if ($("#ul-small-profile").css('display') === 'block') {
            $("#ul-small-profile").hide();
        }
        $('#ul-friend-notify').show(); return false;
    }); 

    $('#bt-friend-notify').click(function (e) {
        e.stopPropagation();
    });

    $(document).click(function () { 
        $('#ul-friend-notify').hide();
        $('#ul-notification').hide();
        $("#ul-small-profile").hide();
    });

    var selector = '.chat-filter li a'; 
    $(selector).on('click', function () {
        $(selector).removeClass('active');
        $(this).addClass('active');
    });
}