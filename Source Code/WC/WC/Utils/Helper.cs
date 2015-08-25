using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace WC.Utils
{
    public class Helper
    {
        public static void WriteLog(Exception e)
        {
            var filename = AppDomain.CurrentDomain.BaseDirectory + "App_Data\\" + "Log\\" + "logErrors.txt";
            var sw = new StreamWriter(filename, true);
            sw.WriteLine(DateTime.UtcNow);
            sw.WriteLine(e.Message + " - " + e.InnerException);
            sw.WriteLine();
            sw.WriteLine();
            sw.Close();
        }


        public static string PostTime(DateTime date)
        {
            int SECOND = 1;
            int MINUTE = 60 * SECOND;
            int HOUR = 60 * MINUTE;
            int DAY = 24 * HOUR;
            int MONTH = 30 * DAY;

            var ts = new TimeSpan(DateTime.UtcNow.Ticks - date.Ticks);
            double delta = Math.Abs(ts.TotalSeconds);

            if (delta < 1 * MINUTE)
            {
                return "Just now";
            }
            if (delta < 60 * MINUTE)
            {
                return ts.Minutes + " minutes ago";
            }
            if (delta < 24 * HOUR)
            {
                return ts.Hours + " hours ago";
            }
            if (delta < 48 * HOUR)
            {
                return "Yesterday";
            }
            if (delta < 30 * DAY)
            {
                return ts.Days + " days ago";
            }
            if (delta < 12 * MONTH)
            {
                int months = Convert.ToInt32(Math.Floor((double)ts.Days / 30));
                return months + " months ago";
            }
            else
            {
                int years = Convert.ToInt32(Math.Floor((double)ts.Days / 365));
                return years + " years ago";
            }
        }

        public static string GetSHA1HashData(string data)
        {
            //create new instance of md5
            var sha1 = SHA1.Create();

            //convert the input text to array of bytes
            var hashData = sha1.ComputeHash(Encoding.Default.GetBytes(data));

            //create new instance of StringBuilder to save hashed data
            var returnValue = new StringBuilder();

            //loop for each byte and add it to StringBuilder
            for (var i = 0; i < hashData.Length; i++)
            {
                returnValue.Append(i.ToString());
            }

            // return hexadecimal string
            return returnValue.ToString();
        }
    }
}