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
    
    public partial class SettingChatBox
    {
        public int Id { get; set; }
        public string ChatBoxId { get; set; }
        public string User1 { get; set; }
        public Nullable<int> Language1 { get; set; }
        public string User2 { get; set; }
        public Nullable<int> Language2 { get; set; }
    
        public virtual ChatBox ChatBox { get; set; }
        public virtual Language Language { get; set; }
        public virtual Language Language3 { get; set; }
        public virtual User User { get; set; }
        public virtual User User3 { get; set; }
    }
}
