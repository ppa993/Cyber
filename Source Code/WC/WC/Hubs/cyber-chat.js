
function OpenSmallChatBox(e, url) {
    var id = e.getAttribute("data-item-id");
    var name = e.getAttribute("data-item-name");

    $("#chat-box-name").text(name);
    $("#chat-box-message").attr("data-item-toid", id);

    var fromId = $("#chat-box-message").attr("data-item-fromid"); 
    $.post(url,
    {
        fromUserId: fromId,
        toUserId: id
    }, function (data) { 
        if (data != "") {
            $("#chat-box-content").html('');
            $("#chat-box-content").append(data);

            $("#chat-box-content").scrollTop($("#chat-box-content").height()+50);
        }
    });
}

$(function () {
    var chat = $.connection.chatHub;

    chat.client.broadcastMessage = function (fromUserId, toUserId, message) { 
        ClientMethods(fromUserId, toUserId);
    };
    chat.client.recieveNotify = function(receiver, html) {
        AddNotify(receiver, html);
        //update notif scroll 
        $(".slimscroll").niceScroll({
            styler: "fb",
            cursorcolor: "#22baa0",
            cursorwidth: '3',
            cursorborderradius: '10px',
            background: '#F7F7F7',
            cursorborder: '',
            zindex: '600'
        });
    };
    chat.client.updateRequest = function (receiver, html) {
        ProcessFriendRequest(receiver, html);
    };
    chat.client.toastNotif = function (receiver, toastUrl, toastMessage) {
        Toaster(receiver, toastUrl, toastMessage);
    };
    $.connection.hub.start().done(function () {
        $("#chat-box-message").keypress(function (event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {
                var fromId = $("#chat-box-message").attr("data-item-fromid");
                var toId = $("#chat-box-message").attr("data-item-toid");
                var msg = $("#chat-box-message").val();
                if (fromId == "" && toId == "" && msg == "") return;
                chat.server.send(fromId, toId, msg);
                $("#chat-box-message").val('');
            }
        });
    })
});

function AddNotify( receiver, html) {
    var curId = $("#chat-box-message").attr("data-item-fromid");
    if (curId==receiver) {
        $("#notify-box").html('');
        $("#notify-box").append(html);
    }
}

function ProcessFriendRequest(receiver, html) {
    var curId = $("#chat-box-message").attr("data-item-fromid");
    if (curId == receiver) {
        $("#friend-request").html('');
        $("#friend-request").append(html);
    }
}

function Toaster(receiver, toastUrl, toastMessage) {
    var curId = $("#chat-box-message").attr("data-item-fromid");
    if (curId == receiver) {
        toastr.options = {
            "closeButton": true,
            "debug": false,
            "newestOnTop": false,
            "progressBar": false,
            "positionClass": "toast-bottom-left",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        }
        toastr.options.onclick = function () {
            location.href = toastUrl;
        };
        toastr.info(toastMessage);
    }
}

function ClientMethods(fromId, toId) {
    var id = $("#chat-box-message").attr("data-item-fromid");
    var url = $("#chat-box-message").attr("data-item-url");
    if (id != fromId && id != toId) return;

    $.post(url,
    {
        fromUserId: fromId,
        toUserId: toId
    }, function (data) { 
        if (data != "") {
            if (!$("#cbp-spmenu-s2").hasClass("cbp-spmenu-open"))
            { 
                $("#cbp-spmenu-s2").toggleClass("cbp-spmenu-open");
            }

            $("#chat-box-content").html('');
            $("#chat-box-content").append(data);

            $("#chat-box-content").scrollTop($("#chat-box-content").height() + 50);
        }
    });
}
 
$("#Upload").click(function () {
    var formData = new FormData();
    var totalFiles = document.getElementById("FileUpload").files.length;
    for (var i = 0; i < totalFiles; i++) {
        var file = document.getElementById("FileUpload").files[i];

        formData.append("FileUpload", file);
    }
    $.ajax({
        type: "POST",
        url: '/Home/Upload',
        data: formData,
        dataType: 'json',
        contentType: false,
        processData: false,
        success: function (response) {
            alert('succes!!');
        },
        error: function (error) {
            alert("Failed");
        }
    });
});