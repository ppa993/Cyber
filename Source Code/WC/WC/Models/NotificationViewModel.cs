using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WC.Models
{
    public class NotificationViewModel
    {
        public string Time { set; get; }
        public string Message { set; get; }
        public int Type { set; get; }
        public string PostId { set; get; }
    }
}