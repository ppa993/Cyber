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
    
    public partial class Cyber_Like
    {
        public byte[] LikeID { get; set; }
        public string LikeOf { get; set; }
        public string UserID { get; set; }
    
        public virtual Cyber_Comment Cyber_Comment { get; set; }
        public virtual Cyber_Post Cyber_Post { get; set; }
    }
}
