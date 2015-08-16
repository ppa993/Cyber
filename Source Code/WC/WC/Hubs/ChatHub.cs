using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace WC.Hubs
{
    [HubName("chatHub")]
    public class ChatHub : Hub
    {
        public void Send(string boxChatId, string fromUserId, string message)
        {
            Clients.All.broadcastMessage(boxChatId, fromUserId, message);
        }
    }
}