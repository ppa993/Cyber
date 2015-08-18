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
            sw.WriteLine(DateTime.Now);
            sw.WriteLine(e.Message + " - " + e.InnerException);
            sw.WriteLine();
            sw.WriteLine();
            sw.Close();
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