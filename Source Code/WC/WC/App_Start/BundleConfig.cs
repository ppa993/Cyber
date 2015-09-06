using System.Web;
using System.Web.Optimization;

namespace WC
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Content/Script/jquery-2.1.4.min.js",
                        "~/Content/Script/jquery-ui.min.js",
                        "~/Content/Script/jquery.autogrow-textarea.js",
                        "~/Content/Script/pace.min.js",
                        "~/Content/Script/jquery.blockui.js",
                        "~/Content/Script/bootstrap.min.js",
                        //"~/Content/Script/jquery.slimscroll.min.js",
                        "~/Content/Script/switchery.min.js",
                        "~/Content/Script/jquery.uniform.min.js",
                        "~/Content/Script/classie.js",
                        "~/Content/Script/main.js",
                        "~/Content/Script/waves.min.js",
                        "~/Content/Script/main(1).js",
                        "~/Content/Script/jquery.waypoints.min.js",
                        "~/Content/Script/jquery.counterup.min.js",
                        "~/Content/Script/toastr.min.js",
                        "~/Content/Script/MetroJs.min.js",
                        "~/Content/Script/Autolinker.min.js",
                        "~/Content/Script/jquery.hashtags.js",
                        "~/Content/Script/modern.min.js"));
                        //"~/Content/Script/dashboard.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Content/Script/jquery.validate*"));

            //// Use the development version of Modernizr to develop with and learn from. Then, when you're
            //// ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            //bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
            //            "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/Theme").Include(
                      "~/Content/Script/modernizr.js",
                      "~/Content/Script/snap.svg-min.js"));

            bundles.Add(new StyleBundle("~/bundles/Style").Include(
                      "~/Content/Style/pace-theme-flash.css",
                      "~/Content/Style/uniform.default.min.css",
                      "~/Content/Style/bootstrap.min.css",
                      "~/Content/Style/font-awesome.css",
                      "~/Content/Style/simple-line-icons.css",
                      "~/Content/Style/menu_cornerbox.css",
                      "~/Content/Style/waves.min.css",
                      "~/Content/Style/switchery.min.css",
                      "~/Content/Style/style.css",
                      "~/Content/Style/component.css",
                      "~/Content/Style/weather-icons.min.css",
                      "~/Content/Style/MetroJs.min.css",
                      "~/Content/Style/toastr.min.css",
                      "~/Content/Style/modern.min.css",
                      "~/Content/Style/jquery.hashtags.css",
                      "~/Content/Style/green.css",
                      "~/Content/Style/custom.css"));
        }
    }
}
