﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WC.Constants
{
    public class Common
    {
    }

    public class DateTimeFormat
    {
        public const string DDMMYYYY = "dd/MM/yyyy";
    }

    public class Message
    {
        public const string EXISTED_USERNAME = "Your username is already existed. Please select another username.";
        public const string EXISTED_EMAIL = "This email is already in use. Please user another email.";
        public const string REGISTERED_SUCCESSFULLY = "Your new account has been registered successfully!";
        public const string REGISTER_FAILED = "Failed to register new account. Please try again later.";
    }

    public enum Gender
    {
        Male,
        Female
    }

    public enum Relationship
    {
        Single,
        Engaged,
        Married,
        Divorced
    }
}