﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WC.Data;

namespace WC.Models
{
    public class PostViewModel
    {
        public Post Post { get; set; }
        public string PostTitle { get; set; }

    }

    public class MorePostViewModel
    {
        public bool NoMore { get; set; }
        public string Posts { get; set; }
    }
}