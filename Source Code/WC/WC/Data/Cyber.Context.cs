﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class CyberEntities : DbContext
    {
        public CyberEntities()
            : base("name=CyberEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Cyber_Comment> Cyber_Comment { get; set; }
        public virtual DbSet<Cyber_Friend> Cyber_Friend { get; set; }
        public virtual DbSet<Cyber_Like> Cyber_Like { get; set; }
        public virtual DbSet<Cyber_Membership> Cyber_Membership { get; set; }
        public virtual DbSet<Cyber_Notification> Cyber_Notification { get; set; }
        public virtual DbSet<Cyber_Notification_Type> Cyber_Notification_Type { get; set; }
        public virtual DbSet<Cyber_Post> Cyber_Post { get; set; }
        public virtual DbSet<Cyber_Post_Type> Cyber_Post_Type { get; set; }
        public virtual DbSet<Cyber_Profile_Photo> Cyber_Profile_Photo { get; set; }
        public virtual DbSet<Cyber_Role> Cyber_Role { get; set; }
        public virtual DbSet<Cyber_Role_Type> Cyber_Role_Type { get; set; }
        public virtual DbSet<Cyber_User> Cyber_User { get; set; }
        public virtual DbSet<Cyber_Visible_Type> Cyber_Visible_Type { get; set; }
        public virtual DbSet<sysdiagram> sysdiagrams { get; set; }
    }
}
