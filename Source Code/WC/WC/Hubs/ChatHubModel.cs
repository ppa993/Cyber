using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WC.Hubs
{
    public class MessageDetail
    { 
        public string UserId { get; set; } 
        public string Message { get; set; } 
    }
    public class UserDetail
    {
        public string ConnectionId { get; set; }
        public string UserId { get; set; }
    }
}