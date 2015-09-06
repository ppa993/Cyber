using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WC.Data;
using WC.Models;

namespace WC.Controllers
{
    [System.Web.Mvc.Authorize]
    public class AlbumController : AccountController
    {
        // GET: Album
        public ActionResult Photos(string username)
        {
            var query = (from u in db.Users
                         from ad in db.AlbumDetails
                         where u.UserID == ad.PostedUserId
                         && !ad.Hide && !ad.Deleted && u.UserName == username
                         select new PhotoViewModel()
                         {
                             UserID = u.UserID,
                             UserName = u.UserName,
                             AlbumID = ad.AlbumId,
                             PhotoID = ad.Id,
                             PostID = ad.PostID,
                             Url = ad.Url,
                             Filter=ad.Filter,
                             PostedDate = ad.PostedDate
                         }).OrderByDescending(x => x.PostedDate).ToList();

            AlbumViewModel alb = new AlbumViewModel();
            alb.Photo = query;
            alb.IsMyTimeLine = false;

            var user = db.Users.FirstOrDefault(x => x.UserName == username);
            if (user != null)
            {
                alb.Name = user.FirstName + " " + user.LastName;
                if (user.UserID == CurrentUserID)
                {
                    alb.IsMyTimeLine = true;
                }
            }
            return View(alb);
        }

        public ActionResult Editor(int photoID)
        {
            var photo = db.AlbumDetails.FirstOrDefault(x => x.Id == photoID);
            return View(photo);
        }

        [HttpPost]
        public string UploadPhotos()
        {
            //List<string> p = new List<string>();
            List<AlbumDetail> ad = new List<AlbumDetail>();
            for (int i = 0; i < Request.Files.Count; i++)
            {
                var file = Request.Files[i];
                var fileName = Path.GetFileName(file.FileName);
                var path = Path.Combine(Server.MapPath("~/Content/Images/UserUpload/"), fileName);
                file.SaveAs(path);

                ad.Add(new AlbumDetail()
                {
                    AlbumId = "upload" + CurrentUserID,
                    Deleted = false,
                    Active = false,
                    Hide = false,
                    PostID = "",
                    Url = "~/Content/Images/UserUpload/" + fileName,
                    PostedUserId = CurrentUserID,
                    PostedDate = DateTime.Now
                });
            }
            db.AlbumDetails.AddRange(ad);
            db.SaveChanges();

            return "1";
        }

        [HttpPost]
        public string DeletePhoto(int photoId)
        {
            var photo = db.AlbumDetails.FirstOrDefault(x => x.Id == photoId);
            if (photo != null)
            {
                photo.Deleted = true;
                photo.DeletedDate = DateTime.Now;
                db.SaveChanges();

                return "1";
            }
            return "0";
        }

        [HttpPost]
        public string SetAvatarPhoto(int photoId)
        {
            var photo = db.AlbumDetails.FirstOrDefault(x => x.Id == photoId);
            if (photo != null)
            {
                if (photo.Active) return "2";

                var currAvatar = db.AlbumDetails.FirstOrDefault(x => x.AlbumId == "avatar" + CurrentUserID && x.Active);
                if (currAvatar != null)
                {
                    currAvatar.Active = false;
                    currAvatar.AlbumId = "upload" + CurrentUserID;
                }
                photo.Active = true;
                photo.AlbumId = "avatar" + CurrentUserID;
                db.SaveChanges();
                return "1";
            }
            return "0";
        }

        [HttpPost]
        public string SetCoverPhoto(int photoId)
        {
            var photo = db.AlbumDetails.FirstOrDefault(x => x.Id == photoId);
            if (photo != null)
            {
                if (photo.Active) return "2";
                var currCover = db.AlbumDetails.FirstOrDefault(x => x.AlbumId == "cover" + CurrentUserID && x.Active);
                if (currCover != null)
                {
                    currCover.Active = false;
                    currCover.AlbumId = "upload" + CurrentUserID;
                }
                photo.Active = true;
                photo.AlbumId = "cover" + CurrentUserID;
                db.SaveChanges();
                return "1";
            }
            return "0";
        }

        [HttpPost]
        public string SetFilter(int photoId, string filter)
        {
            var photo = db.AlbumDetails.FirstOrDefault(x => x.Id == photoId);
            if (photo != null)
            {
                var f1 = "filter: " + filter + "; ";
                var f2 = "-webkit-filter: " + filter + "; ";
                var f3 = "-moz-filter: " + filter + "; ";
                var f4 = "-ms-filter: " + filter + "; ";
                var f5 = "-o-filter: " + filter + "; ";

                photo.Filter = f1 + f2 + f3 + f4 + f5;
                db.SaveChanges();
                Photos(CurrentUserName);
            } 
            return "1";
        }
    }
}