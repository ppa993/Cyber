using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using WC.Constants;
using WC.Data;
using WC.Models;
using WC.Utils;

namespace WC.Controllers
{
    [Authorize]
    public class CalendarController : AccountController
    {
        //
        // GET: /Calendar/
        public ActionResult Calendar()
        {
            ViewBag.MyEvents =
                db.MyEvents.Where(x => x.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase))
                .OrderBy(x => x.CreatedDate)
                .ToList();
            return View();
        }
        
        [ChildActionOnly]
        public ActionResult MyEvents(List<MyEvent> Model)
        {
            return PartialView(Model);
        }

        [HttpGet]
        public ActionResult GetEvents(string start, string end)
        {
            try
            {
                var startDate = DateTime.Parse(start, CultureInfo.InvariantCulture);
                var endDate = DateTime.Parse(end, CultureInfo.InvariantCulture);
                var startDateOfYyear = startDate.DayOfYear;
                var endDateOfYear = endDate.DayOfYear;

                var events = new List<EventViewModel> ();
                var friends =
                    db.Friends.Where(
                        x =>
                            x.FriendsListId.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase)
                            && x.User.MySettings.First().ShowBirthday != (int)ShowBirthDay.Hide);

                foreach (var friend in friends)
                {
                    if (startDateOfYyear > friend.User.BirthDay.DayOfYear ||
                        friend.User.BirthDay.DayOfYear > endDateOfYear) continue;
                    var birthdayEvent = new EventViewModel
                    {
                        id = Guid.NewGuid().ToString(),
                        title = friend.User.FirstName + "\'s birthday",
                        editable = false,
                        start = friend.User.BirthDay.ToString(DateTimeFormat.YYYYMMDD),
                        backgroundColor = "#fad165",
                        borderColor = "#ed6807",
                        textColor = "#333333",
                        className = "birthday"
                    };
                    events.Add(birthdayEvent);
                }

                var myCalendarEvents =
                    db.CalendarEvents.Where(
                        x => x.UserID.Equals(CurrentUserID, StringComparison.InvariantCultureIgnoreCase) && x.EventDate >= startDate && x.EventDate <= endDate);

                foreach (var calendarEvent in myCalendarEvents)
                {
                    var myEvent = new EventViewModel
                    {
                        id = calendarEvent.EventID,
                        title = calendarEvent.EventTitle,
                        editable = true,
                        start = calendarEvent.EventDate.ToString(DateTimeFormat.YYYYMMDD),
                        backgroundColor = "#b3dc6c",
                        borderColor = "#16a765",
                        textColor = "#333333",
                        className = "myevent"

                    };
                    events.Add(myEvent);
                }

                return Json(events, JsonRequestBehavior.AllowGet);
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return null;
            }
        }

        [HttpPost]
        public string AddCalendarEvent(string eventDate, string eventTitle)
        {
            try
            {
                var calendarEvent = new CalendarEvent
                {
                    EventID = Guid.NewGuid().ToString(),
                    EventTitle = eventTitle,
                    EventDate = DateTime.Parse(eventDate, CultureInfo.InvariantCulture),
                    UserID = CurrentUserID
                };
                db.CalendarEvents.Add(calendarEvent);
                db.SaveChanges();
                return calendarEvent.EventID;
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        }

        [HttpPost]
        public string EditCalendarEvent(string eventID, string eventDate)
        {
            try
            {
                var calendarEvent = db.CalendarEvents.FirstOrDefault(x => x.EventID.Equals(eventID));
                if (calendarEvent == null) return ActionResults.Deleted.ToString();

                calendarEvent.EventDate = DateTime.Parse(eventDate, CultureInfo.InvariantCulture);
                db.SaveChanges();
                return ActionResults.Succeed.ToString();
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        }

        [HttpPost]
        public string DeleteCalendarEvent(string eventID)
        {
            try
            {
                var calendarEvent = db.CalendarEvents.FirstOrDefault(x => x.EventID.Equals(eventID));
                if (calendarEvent == null) return ActionResults.Deleted.ToString();

                db.CalendarEvents.Remove(calendarEvent);
                db.SaveChanges();
                return ActionResults.Succeed.ToString();
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        }

        [HttpPost]
        public string AddMyEvent(string eventTitle)
        {
            try
            {
                var isExisted =
                    db.MyEvents.Any(x => x.EventTitle.Equals(eventTitle.Trim(), StringComparison.InvariantCultureIgnoreCase));
                if (isExisted) return ActionResults.AlreadyDone.ToString();

                var myEvent = new MyEvent
                {
                    EventID = Guid.NewGuid().ToString(),
                    EventTitle = eventTitle.Trim(),
                    UserID = CurrentUserID,
                    CreatedDate = DateTime.UtcNow
                };
                db.MyEvents.Add(myEvent);
                db.SaveChanges();
                return myEvent.EventID;
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        }

        [HttpPost]
        public string DeleteMyEvent(string eventID)
        {
            try
            {
                var myEvent = db.MyEvents.FirstOrDefault(x => x.EventID.Equals(eventID));
                if (myEvent == null) return ActionResults.Deleted.ToString();

                db.MyEvents.Remove(myEvent);
                db.SaveChanges();
                return ActionResults.Succeed.ToString();
            }
            catch (Exception exception)
            {
                Helper.WriteLog(exception);
                return ActionResults.Failed.ToString();
            }
        }
    }
}