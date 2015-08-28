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
    
    public partial class User
    {
        public User()
        {
            this.Albums = new HashSet<Album>();
            this.AlbumDetails = new HashSet<AlbumDetail>();
            this.CalendarEvents = new HashSet<CalendarEvent>();
            this.ChatBoxes = new HashSet<ChatBox>();
            this.ChatBoxes1 = new HashSet<ChatBox>();
            this.ChatBoxes2 = new HashSet<ChatBox>();
            this.ChatBoxes3 = new HashSet<ChatBox>();
            this.ChatReplies = new HashSet<ChatReply>();
            this.ChatReplies1 = new HashSet<ChatReply>();
            this.Comments = new HashSet<Comment>();
            this.CommentLikes = new HashSet<CommentLike>();
            this.FriendLists = new HashSet<FriendList>();
            this.FriendLists1 = new HashSet<FriendList>();
            this.Friends = new HashSet<Friend>();
            this.Friends1 = new HashSet<Friend>();
            this.MySettings = new HashSet<MySetting>();
            this.Notifications = new HashSet<Notification>();
            this.Posts = new HashSet<Post>();
            this.Posts1 = new HashSet<Post>();
            this.PostLikes = new HashSet<PostLike>();
            this.Reports = new HashSet<Report>();
            this.Roles = new HashSet<Role>();
            this.SettingChatBoxes = new HashSet<SettingChatBox>();
            this.SettingChatBoxes1 = new HashSet<SettingChatBox>();
            this.MyEvents = new HashSet<MyEvent>();
        }
    
        public string UserID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string UserName { get; set; }
        public System.DateTime BirthDay { get; set; }
        public bool Gender { get; set; }
        public int Relationship { get; set; }
        public string About { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string Work { get; set; }
        public string ContactNumber { get; set; }
        public string Studied { get; set; }
    
        public virtual ICollection<Album> Albums { get; set; }
        public virtual ICollection<AlbumDetail> AlbumDetails { get; set; }
        public virtual ICollection<CalendarEvent> CalendarEvents { get; set; }
        public virtual ICollection<ChatBox> ChatBoxes { get; set; }
        public virtual ICollection<ChatBox> ChatBoxes1 { get; set; }
        public virtual ICollection<ChatBox> ChatBoxes2 { get; set; }
        public virtual ICollection<ChatBox> ChatBoxes3 { get; set; }
        public virtual ICollection<ChatReply> ChatReplies { get; set; }
        public virtual ICollection<ChatReply> ChatReplies1 { get; set; }
        public virtual ICollection<Comment> Comments { get; set; }
        public virtual ICollection<CommentLike> CommentLikes { get; set; }
        public virtual ICollection<FriendList> FriendLists { get; set; }
        public virtual ICollection<FriendList> FriendLists1 { get; set; }
        public virtual ICollection<Friend> Friends { get; set; }
        public virtual ICollection<Friend> Friends1 { get; set; }
        public virtual ICollection<MySetting> MySettings { get; set; }
        public virtual ICollection<Notification> Notifications { get; set; }
        public virtual ICollection<Post> Posts { get; set; }
        public virtual ICollection<Post> Posts1 { get; set; }
        public virtual ICollection<PostLike> PostLikes { get; set; }
        public virtual Profile_Photo Profile_Photo { get; set; }
        public virtual Relationship_Type Relationship_Type { get; set; }
        public virtual ICollection<Report> Reports { get; set; }
        public virtual Role Role { get; set; }
        public virtual ICollection<Role> Roles { get; set; }
        public virtual ICollection<SettingChatBox> SettingChatBoxes { get; set; }
        public virtual ICollection<SettingChatBox> SettingChatBoxes1 { get; set; }
        public virtual ICollection<MyEvent> MyEvents { get; set; }
    }
}
