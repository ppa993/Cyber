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
    
    public partial class Role
    {
        public string UserID { get; set; }
        public int RoleType { get; set; }
        public System.DateTime AssignedDate { get; set; }
        public string AssignedBy { get; set; }
    
        public virtual Role_Type Role_Type { get; set; }
        public virtual User User { get; set; }
        public virtual User User1 { get; set; }
    }
}
