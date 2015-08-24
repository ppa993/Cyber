using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WC.Models
{
    public class AddFriendViewModel
    {
        public string CurrentUserId { set; get; }
        public string TargetUserId { set; get; }
        public FriendType Type { set; get; }
    }

    public enum FriendType
    {
        NoneFriend,
        MyPendingFriend,
        HisPendingFriend,
        Friend
    }
}