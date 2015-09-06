using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WC.Models
{
    public class StatictisViewModel
    {
        public int Users { get; set; }
        public int Posts { get; set; }
        public long Likes { get; set; }
        public int Reports { get; set; }
        public ICollection<Statictis> Statictis { get; set; }
    }

    public class Statictis
    {
        public DateTime RegisteredDate { get; set; }
        public int Count { get; set; }
    }
}