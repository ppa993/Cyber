using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
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
        public string Register(string username, string pass, string email, string birthDay, string firstName,
            string lastName)
        {
            var encryptedPass = Helper.GetSHA1HashData(pass);
            var DOB = DateTime.ParseExact(birthDay, DateTimeFormat.DDMMYYYY, null);

            var newUser = (from data in db.Cyber_Membership
                where data.Username == username
                select data).FirstOrDefault();

            if (newUser != null)
            {
                return Message.EXISTED_USERNAME;
            }

            try
            {
                var membership = new Cyber_Membership
                            {
                                UserID = new Guid().ToString(),
                                Username = username,
                                Email = email,
                                Password = encryptedPass,
                                Status = true,
                                CreatedDate = DateTime.Now,
                                LastTimeLogIn = DateTime.Now
                            };

                db.Cyber_Membership.Add(membership);
                db.SaveChanges();

                var user = new Cyber_User
                {
                    UserID = membership.UserID,
                    BirthDay = DOB,
                    FirstName = firstName,
                    LastName = lastName
                };

                db.Cyber_User.Add(user);
                db.SaveChanges();
                return Message.REGISTERED_SUCCESSFULLY;
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
            }
            
            return Message.REGISTER_FAILED;
        }
      
	}
}