using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WC.Data;

namespace WC.Models
{
    public class AlbumViewModel
    {
        public List<PhotoViewModel> Photo { set; get; }
        public bool IsMyTimeLine { set; get; }
        public string Name { set; get; }
    }
    public class PhotoViewModel
    {
        public string UserID { set; get; }
        public string UserName { set; get; }
        public string AlbumID { set; get; }
        public int PhotoID { set; get; }
        public string PostID { set; get; }
        public string Url { set; get; }
        public string Filter { set; get; }
        public DateTime PostedDate { set; get; }
    }
}