using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WC.Models
{
    public class EventViewModel
    {
        public string id { get; set; }
        public string title { get; set; }
        public string start { get; set; }
        public string end { get; set; }
        public bool editable { get; set; }
        public string textColor { get; set; }
        public string backgroundColor { get; set; }
        public string borderColor { get; set; }
        public string className { get; set; }
    }
}