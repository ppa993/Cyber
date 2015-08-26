using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Mvc;
using WC.Data;
using WC.Models;
using System.Linq;
using WC.Hubs;

namespace WC.Controllers
{
    [Authorize]
    public class BaseController : Controller
    {
        public CyberEntities db = new CyberEntities();

        public List<FriendViewModel> GetListFriendsOf(string userId)
        {
            var query = from fl in db.FriendLists
                        from f in db.Friends
                        from u in db.Users
                            //from pp in db.Profile_Photo
                        where fl.Id == f.FriendsListId
                        && f.FriendId == u.UserID
                        && fl.Id == userId
                        select new FriendViewModel()
                        {
                            FriendId = f.FriendId,
                            Name = u.FirstName + " " + u.LastName,
                            //ProfileImgUrl=pp.ProfileImageUrl
                        };
            return query.ToList();
        }

        public string GetHtmlListFriendsOf(string userId)
        {
            string html = "";
            html += RenderPartialViewToString("FriendListPartial", GetListFriendsOf(userId));
            return html;
        }

        public List<ChatHubModel> GetListChatItemOf(string fromUserId, string toUserId)
        {
            var query = from cb in db.ChatBoxes
                        from cbd in db.ChatReplies
                        from u in db.Users
                        where cb.Id == cbd.ChatBoxId
                        && (cb.FromUseId == fromUserId && cb.ToUseId == toUserId ||
                            cb.FromUseId == toUserId && cb.ToUseId == fromUserId)
                        && cbd.UserIdReply == u.UserID
                        select new ChatHubModel()
                        {
                            UserId = cbd.UserIdReply,
                            Message = cbd.Content,
                            Name = u.FirstName + " " + u.LastName,
                            ProfileImgUrl = u.Profile_Photo.ProfileImageUrl,
                            SentTime = cbd.SendDate
                        };
            var data = query.ToList();
            return data;
        }
        public string GetHtmlListChatItemOf(string fromUserId, string toUserId)
        {
            string html = "";
            html += RenderPartialViewToString("ChatItemViewModel", GetListChatItemOf(fromUserId, toUserId));
            return html;
        }

        public string RenderPartialViewToString(string viewName, object model)
        {
            if (string.IsNullOrEmpty(viewName))
                viewName = ControllerContext.RouteData.GetRequiredString("action");

            ViewData.Model = model;

            using (var sw = new StringWriter())
            {
                var viewResult =
                    ViewEngines.Engines.FindPartialView(ControllerContext, viewName);
                var viewContext = new ViewContext
                    (ControllerContext, viewResult.View, ViewData, TempData, sw);
                viewResult.View.Render(viewContext, sw);

                return sw.GetStringBuilder().ToString();
            }
        }


        public static string TruncateAtWord(string input, int length)
        {
            if (input == null || input.Length < length)
                return input;
            var iNextSpace = input.LastIndexOf(" ", length, StringComparison.InvariantCultureIgnoreCase);
            return string.Format("{0}...", input.Substring(0, (iNextSpace > 0) ? iNextSpace : length).Trim());
        }
    }
}