using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WorldConnecting.Startup))]
namespace WorldConnecting
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
