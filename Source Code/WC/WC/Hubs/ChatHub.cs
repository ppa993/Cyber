using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using Microsoft.AspNet.Identity;

namespace WC.Hubs
{
    [HubName("chatHub")]
    public class ChatHub : Hub
    {
        public static List<UserConnection> ListUserConnected = new List<UserConnection>();

        public void Send(string fromUserId, string toUserId, string message)
        {
            Clients.All.broadcastMessage(fromUserId, fromUserId, message);
        }

        public override Task OnConnected()
        {
            var connectionId = Context.ConnectionId;
            var user = ListUserConnected.FirstOrDefault(x => x.ConnectionId == connectionId);
            if (user == null)
            {
                UserConnection u = new UserConnection()
                {
                    ConnectionId = connectionId,
                    UserId = HttpContext.Current.User.Identity.GetUserId()
                };
                ListUserConnected.Add(u);
            }

            return base.OnConnected();
        }

        public override Task OnDisconnected(bool stopCalled)
        {
            var connectionId = Context.ConnectionId;
            var user = ListUserConnected.FirstOrDefault(x => x.ConnectionId == connectionId);
            if (user != null)
            {
                ListUserConnected.Remove(user);
            }

            return base.OnDisconnected(stopCalled);
        }
    }
}