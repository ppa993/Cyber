using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using Microsoft.AspNet.Identity;
using WC.Data;
using System.Threading; 
namespace WC.Hubs
{
    public class ChatHub : Hub
    {
        public static List<UserConnection> ListUserConnected = new List<UserConnection>();

        public void Send(string fromUserId, string toUserId, string message)
        {
            CyberEntities db = new CyberEntities();
            var box1 = db.ChatBoxes.FirstOrDefault(x => x.FromUseId == fromUserId && x.ToUseId == toUserId);
            var box2 = db.ChatBoxes.FirstOrDefault(x => x.FromUseId == toUserId && x.ToUseId == fromUserId);

            string id = DateTime.Now.ToString("yyyyMMddHHmmssfff");
            ChatReply cbd = new ChatReply()
            {
                ChatBoxId = id,
                SendDate = DateTime.Now,
                Content = message,
                Deleted = false,
                UserIdReply = fromUserId
            };

            if (box1 == null && box2 == null)
            {
                ChatBox cb = new ChatBox()
                {
                    Id = id,
                    FromUseId = fromUserId,
                    ToUseId = toUserId,
                    CreatedDate = DateTime.Now,
                    Deleted = false,

                };
                db.ChatBoxes.Add(cb);
            }

            if (box1 != null && box2 == null)
            {
                cbd.ChatBoxId = box1.Id;
            }

            if (box2 != null && box1 == null)
            {
                cbd.ChatBoxId = box2.Id;
            }
            db.ChatReplies.Add(cbd);
            db.SaveChanges();

            Clients.All.broadcastMessage(fromUserId, toUserId, message);
        } 

        public override Task OnConnected()
        {
            var connectionId = Context.ConnectionId;
            var user = ListUserConnected.FirstOrDefault(x => x.ConnectionId == connectionId);
            //var id = Context.Request.User.Identity.GetUserId();
            if (user == null)
            {
                UserConnection u = new UserConnection()
                {
                    ConnectionId = connectionId,

                };
                //if (id != null)
                //{
                //    u.UserId = id;
                //}
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