//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WC.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class Comment
    {
        public string PostID { get; set; }
        public string CommentID { get; set; }
        public string CommentContent { get; set; }
        public System.DateTime CommentedDate { get; set; }
        public string CommentedBy { get; set; }
        public System.DateTime LastModified { get; set; }
    
        public virtual Post Post { get; set; }
        public virtual User User { get; set; }
        public virtual User User1 { get; set; }
    }
}