using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;            
using System.Web.Mvc;
namespace WC.Controllers
{
    [System.Web.Mvc.Authorize]
    public class AlbumController : AccountController
    {
        // GET: Album
        public ActionResult Photos(string username)
        {
            var photos = db.AlbumDetails.Where(x => !x.Hide && x.PostedUserId == CurrentUserID && !x.Deleted).ToList();
            return View(photos);
        }

        [HttpPost]
        public string UploadPhotos()
        {
            

            return "";
        }
    }
}