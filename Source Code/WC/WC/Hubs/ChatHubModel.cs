using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WC.Hubs
{
    public class ChatHubModel
    {
        public string UserId { set; get; }
        public string Name { set; get; }
        public string Message { set; get; }
        public string ProfileImgUrl { set; get; }
        public DateTime SentTime { get; set; }
    }
}