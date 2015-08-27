using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Mvc;
using WC.Data;
using WC.Models;
using System.Linq;
using WC.Hubs;
using WC.Constants;

namespace WC.Controllers
{
    [Authorize]
    public class BaseController : Controller
    {
        public CyberEntities db = new CyberEntities();

        public Album[] DefaultAlbum(string userId)
        {
            return new Album[]{
                new Album(){
                    AlbumId="avatar"+userId,
                    AlbumName="Avatar",
                    CreatedDate=DateTime.Now,
                    CreatedUserId=userId,
                    Deleted=false, 
                },
                new Album(){
                    AlbumId="cover"+userId,
                    AlbumName="Cover",
                    CreatedDate=DateTime.Now,
                    CreatedUserId=userId,
                    Deleted=false, 
                }
            };
        }
        public AlbumDetail[] DefaultImage(string userId, bool gender)
        {
            return new AlbumDetail[]{
                new AlbumDetail(){
                    AlbumId="avatar"+userId,
                    Deleted=false,
                    Hide=true,
                    PostedDate=DateTime.Now,
                    PostedUserId=userId,
                    Url=Common.GetAvatarDefault(gender),
                    Active=true, 
                },
                new AlbumDetail(){
                    AlbumId="cover"+userId,
                    Deleted=false,
                    Hide=true,
                    PostedDate=DateTime.Now,
                    PostedUserId=userId,
                    Url=Common.GetCoverDefault(),
                    Active=true, 
                }
            };
        }


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

        [HttpPost]
        public void Upload()
        {
            for (int i = 0; i < Request.Files.Count; i++)
            {
                var file = Request.Files[i];
                var fileName = Path.GetFileName(file.FileName);
                var path = Path.Combine(Server.MapPath("~/[Your_Folder_Name]/"), fileName);

                file.SaveAs(path);
            }
        }
    }
}