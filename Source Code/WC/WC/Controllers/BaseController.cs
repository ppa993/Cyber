using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Mvc;
using WC.Data;
using WC.Models;
using System.Linq;
using WC.Hubs;
using WC.Constants;
using System.Text;
using System.Web.UI;

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
                },
                new Album(){
                    AlbumId="upload"+userId,
                    AlbumName="Uploat",
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
                },new AlbumDetail(){
                    AlbumId="upload"+userId,
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
            html += RenderViewToString("FriendListPartial", GetListFriendsOf(userId));
            return html;
        }

        public List<ChatHubModel> GetListChatItemOf(string fromUserId, string toUserId)
        {
            var query = from cb in db.ChatBoxes
                        from cbd in db.ChatReplies
                        from u in db.Users
                        from a in db.AlbumDetails
                        where cb.Id == cbd.ChatBoxId
                        && (cb.FromUseId == fromUserId && cb.ToUseId == toUserId ||
                            cb.FromUseId == toUserId && cb.ToUseId == fromUserId)
                        && cbd.UserIdReply == u.UserID
                        && a.AlbumId == "avatar" + u.UserID && a.Active
                        select new ChatHubModel()
                        {
                            UserId = cbd.UserIdReply,
                            Message = cbd.Content,
                            Name = u.FirstName + " " + u.LastName,
                            ProfileImgUrl = a.Url,
                            SentTime = cbd.SendDate
                        };
            var data = query.ToList();
            return data;
        }
        public string GetHtmlListChatItemOf(string fromUserId, string toUserId)
        {
            string html = "";
            html += RenderViewToString("ChatItemViewModel", GetListChatItemOf(fromUserId, toUserId));
            return html;
        }

        public string RenderPartialViewToString(string viewName, object model)
        {
            if (string.IsNullOrEmpty(viewName))
                viewName = ControllerContext.RouteData.GetRequiredString("action");

            ViewData.Model = model;

            using (var sw = new StringWriter())
            {
                var viewResult = ViewEngines.Engines.FindPartialView(ControllerContext, viewName);
                var viewContext = new ViewContext(ControllerContext, viewResult.View, ViewData, TempData, sw);
                viewResult.View.Render(viewContext, sw);

                return sw.GetStringBuilder().ToString();
            }
        }

        public static string RenderViewToString(string controlName, object model)
        {
            ViewPage viewPage = new ViewPage() { ViewContext = new ViewContext() };

            viewPage.ViewData = new ViewDataDictionary(model);
            viewPage.Controls.Add(viewPage.LoadControl(controlName));

            StringBuilder sb = new StringBuilder();
            using (StringWriter sw = new StringWriter(sb))
            {
                using (HtmlTextWriter tw = new HtmlTextWriter(sw))
                {
                    viewPage.RenderControl(tw);
                }
            }

            return sb.ToString();
        }

        public static string TruncateAtWord(string input, int length)
        {
            if (input == null || input.Length < length)
                return input;
            var iNextSpace = input.LastIndexOf(" ", length, StringComparison.InvariantCultureIgnoreCase);
            return string.Format("{0}...", input.Substring(0, (iNextSpace > 0) ? iNextSpace : length).Trim());
        }

        [HttpPost]
        public JsonResult UploadImage()
        {
            //List<string> p = new List<string>();
            List<AlbumDetail> ad = new List<AlbumDetail>(); ;
            for (int i = 0; i < Request.Files.Count; i++)
            {
                var file = Request.Files[i];
                var fileName = Path.GetFileName(file.FileName);
                var path = Path.Combine(Server.MapPath("~/Content/Images/UserUpload/"), fileName);
                file.SaveAs(path);
                //p.Add(path);
                if (Session["PostIDPosted"] != null)
                {
                    string[] postInfo = Session["PostIDPosted"] as string[];

                    ad.Add(new AlbumDetail()
                    {
                        AlbumId = "upload" + postInfo[1],
                        Deleted = false,
                        Active = false,
                        Hide = false,
                        PostID = postInfo[0],
                        Url = "~/Content/Images/UserUpload/" + fileName,
                        PostedUserId = postInfo[1],
                        PostedDate = DateTime.Now
                    });

                    Session["PostIDPosted"] = null;
                }
            }
            //Session["PostIDPosted"] = p;
            if (ad.Count != 0)
            {
                db.AlbumDetails.AddRange(ad);
                db.SaveChanges();
            }
            return Json(new { result = true });
        }

        public string UrlImage(string album, string userId)
        {
            var data = (from u in db.Users
                        from a in db.AlbumDetails
                        where a.PostedUserId == u.UserID
                        && a.AlbumId == album + u.UserID
                        && a.Active && !a.Deleted
                        select new
                        {
                            a.PostedUserId,
                            a.AlbumId,
                            a.Url
                        }).FirstOrDefault(x => x.PostedUserId == userId);
            if (data != null) return data.Url;
            return "";
        } 

        public List<FriendViewModel> FriendList(string userId)
        {
            return (from fl in db.FriendLists
                    from f in db.Friends
                    from u in db.Users
                    from a in db.AlbumDetails
                    where fl.Id == f.FriendsListId && fl.Id == userId
                            && f.FriendId == u.UserID && f.FriendStatus
                            && u.UserID == a.PostedUserId
                            && a.AlbumId == "avatar" + u.UserID
                    select new FriendViewModel()
                    {
                        FriendId = f.FriendId,
                        Name = u.FirstName + " " + u.LastName,
                        ProfileImgUrl = a.Url,
                        UserName = u.UserName
                    }).OrderBy(x => x.Name).ToList();
        }
        public List<FriendViewModel> FriendRequest(string userId)
        {
            return (from fl in db.FriendLists
                    from f in db.Friends
                    from u in db.Users
                    from a in db.AlbumDetails
                    where fl.Id == f.FriendsListId
                            && f.FriendId == u.UserID && !f.FriendStatus
                            && u.UserID == a.PostedUserId
                            && a.AlbumId == "avatar" + u.UserID
                    select new FriendViewModel()
                    {
                        FriendId = f.FriendId,
                        Name = u.FirstName + " " + u.LastName,
                        ProfileImgUrl = a.Url,
                        UserName = u.UserName
                    }).Where(x => x.FriendId == userId).ToList();
        }

        [HttpPost]
        public string GetHintUser(string key)
        { 
            var query = (from u in db.Users.Where(x => x.FirstName.Contains(key) || x.LastName.Contains(key))
                        from ad in db.AlbumDetails
                        where u.UserID == ad.PostedUserId
                        && ad.AlbumId == "avatar" + ad.PostedUserId
                        && ad.Active
                        select new FriendViewModel()
                        {
                            Name = u.LastName + " " + u.FirstName,
                            UserName = u.UserName,
                            ProfileImgUrl = ad.Url
                        }).ToList();

            string html = "";
            html += RenderPartialViewToString("HintFriendPartial", query);
            return html;
        }
    }
}