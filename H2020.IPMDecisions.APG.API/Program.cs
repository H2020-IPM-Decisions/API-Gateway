using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Ocelot.DependencyInjection;

namespace H2020.IPMDecisions.APG.API
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args)
        {
            var host = Host.CreateDefaultBuilder(args);

            host.ConfigureWebHostDefaults(webBuilder =>
            {
                webBuilder.ConfigureAppConfiguration((hostingContext, config) => 
                {
                    config
                        .SetBasePath(hostingContext.HostingEnvironment.ContentRootPath)
#if DEBUG
                        .AddOcelot("Configuration.Local", hostingContext.HostingEnvironment)
#else
                        .AddOcelot("Configuration", hostingContext.HostingEnvironment)
#endif                    
                        .AddEnvironmentVariables();
                });

                webBuilder.UseStartup<Startup>();
            });

            return host;
        }
    }
}
