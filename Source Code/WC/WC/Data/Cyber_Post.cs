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
    
    public partial class Cyber_Post
    {
        public Cyber_Post()
        {
            this.Cyber_Comment = new HashSet<Cyber_Comment>();
            this.Cyber_Like = new HashSet<Cyber_Like>();
        }
    
        public string UserID { get; set; }
        public string PostID { get; set; }
        public int PostTypeID { get; set; }
        public string PostContent { get; set; }
        public System.DateTime PostedDate { get; set; }
        public System.DateTime LastModified { get; set; }
        public int VisibleTypeID { get; set; }
    
        public virtual ICollection<Cyber_Comment> Cyber_Comment { get; set; }
        public virtual ICollection<Cyber_Like> Cyber_Like { get; set; }
        public virtual Cyber_Post_Type Cyber_Post_Type { get; set; }
        public virtual Cyber_User Cyber_User { get; set; }
        public virtual Cyber_Visible_Type Cyber_Visible_Type { get; set; }
    }
}
