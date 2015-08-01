using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WC.Startup))]
namespace WC
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
