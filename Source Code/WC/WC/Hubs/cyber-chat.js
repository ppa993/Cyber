
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
    chat.client.recieveNotify = function (receiver, html) {
        AddNotify(receiver, html);
    }
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
 