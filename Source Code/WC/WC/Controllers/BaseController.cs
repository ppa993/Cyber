using System;
using System.Linq;
using System.Web.Mvc;
using WC.Constants;
using WC.Data;
using WC.Utils;

namespace WC.Controllers
{
    public class BaseController : Controller
    {
        public CyberEntities db = new CyberEntities();

        [HttpPost]
        public string Register(string firstName, string lastName,string username, 
            string password, string email, string birthDay, string gender)
        {
            var DOB = DateTime.Parse(birthDay);

            if (db.Memberships.Any(x => x.Username.Equals(username)))
            {
                return Message.EXISTED_USERNAME;
            }

            if (db.Memberships.Any(x => x.Email.Equals(email)))
            {
                return Message.EXISTED_EMAIL;
            }

            try
            {
                var encryptedPass = Helper.GetSHA1HashData(password);

                var membership = new Membership
                            {
                                UserID = Guid.NewGuid().ToString().Replace("-",""),
                                Username = username,
                                Email = email,
                                Password = encryptedPass,
                                Status = true,
                                CreatedDate = DateTime.Now,
                                LastTimeLogIn = DateTime.Now
                            };

                db.Memberships.Add(membership);

                var user = new User
                {
                    UserID = membership.UserID,
                    BirthDay = DOB,
                    FirstName = firstName,
                    LastName = lastName,
                    Gender = gender.Equals("1"),
                    RelationshipID = (int)Relationship.Single
                };

                db.Users.Add(user);
                db.SaveChanges();
                return Message.REGISTERED_SUCCESSFULLY;
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            
            return Message.REGISTER_FAILED;
        }

        [HttpPost]
        public bool IsUsernameExisted(string username)
        {
            var result = db.Memberships.Any(x => x.Username == username);
            return result;
        }
        [HttpPost]
        public bool IsEmailExisted(string email)
        {
            var result = db.Memberships.Any(x => x.Email == email);
            return result;
        }
	}
}