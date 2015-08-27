using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WC.Constants
{
    public class Common
    {
        public const string SESSION_USER = "User";
        public const string MALE_AVATAR = "~/Content/Images/Avatar/men.png";
        public const string FEMALE_AVATAR = "~/Content/Images/Avatar/women.png";

        public static string GetAvatarDefault(bool gender)
        {
            string img = "~/Content/Images/Avatar/@NAME.png";
            string name = "";
            Random rand = new Random();
            if (gender)
            {
                name += "men" + rand.Next(1, 5).ToString();
            }
            else
            {
                name += "woman" + rand.Next(1, 5).ToString();
            }

            return img.Replace("@NAME", name);
        }
        public static string GetCoverDefault()
        {
            Random rand = new Random();
            string cover = "~/Content/Images/Cover/cover@INDEX.jpg";
            cover = cover.Replace("@INDEX", rand.Next(1, 10).ToString());
            return cover;
        }

        
    }

    public class DateTimeFormat
    {
        public const string DMYYYY = "d/M/yyyy";
        public const string DDMMYYYY_HHMM = "dd/MM/yyyy HH:mm";
        public const string HHMM = "HH:mm";
    }

    public class Message
    {
        public const string EXISTED_USERNAME = "Your username is already existed. Please select another username.";
        public const string EXISTED_EMAIL = "This email is already in use. Please user another email.";
        public const string REGISTERED_SUCCESSFULLY = "Your new account has been registered successfully!";
        public const string REGISTER_FAILED = "Failed to register new account. Please try again later.";
        public const string INVALID_EMAIL = "Invalid email address.";
        public const string INVALID_BIRTHDAY = "Invalid birthday";
        public const string PAGE_NOT_FOUND = "Page not found";
    }

    public class NotificationMessage
    {
        public const string NOTIF_POST = "{0} posted on your Timeline.";
        public const string NOTIF_COMMENT_MY_POST = "{0} commented on your post.";
        public const string NOTIF_COMMENT_OTHER = "{0} also commented on {1} post.";
        public const string NOTIF_LIKE_MY_POST = "{0} likes your post.";
        public const string NOTIF_LIKE_MY_COMMENT = "{0} likes your comment.";
        public const string NOTIF_ADD_FRIEND = "{0} want to add you as {1} friend.";
        public const string NOTIF_ACCEPT_REQUEST = "{0} and you are friend now.";
        public const string NOTIF_CANCEL_REQUEST = "{0} cancelled your friend request.";
    }

    public enum Gender
    {
        Male,
        Female
    }

    public enum Relationship
    {
        Single = 1,
        Engaged,
        Married,
        Divorced
    }

    public enum ActionResults
    {
        Deleted,
        Failed,
        Succeed,
        AlreadyDone
    }

    public enum PostType
    {
        Status = 1,
        Photo
    }

    public enum VisibleType
    {
        Public = 1,
        Friend,
        Private
    }

    public enum NotificationType
    {
        Post = 1,
        CommentMyPost,
        CommentOthers,
        LikeMyPost,
        LikeMyComment,
        AcceptFriendRequest,
        CancelFriendRequest
    }

    public enum LogInResult
    {
        Failed,
        Successfully
    }

    public class DefautValue
    {
        public static int PostLoad = 10;
    }
}