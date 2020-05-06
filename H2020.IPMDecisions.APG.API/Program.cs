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
                    var jsonConfig = new ConfigurationBuilder()
                        .SetBasePath(hostingContext.HostingEnvironment.ContentRootPath)
                        .AddJsonFile("appsettings.json")
                        .AddJsonFile($"appsettings.{hostingContext.HostingEnvironment.EnvironmentName}.json")
                        .AddEnvironmentVariables()
                        .Build();

                    var microservicesInHttps =  bool.Parse(jsonConfig["ENFORCE_MICROSERVICES_HTTPS_REDIRECT"]);

                    var ocelotConfiguration = "Configuration";
                    if (!hostingContext.HostingEnvironment.IsDevelopment() && microservicesInHttps)
                    {
                        ocelotConfiguration = $"{ocelotConfiguration}.HTTPS";
                    }

                    config
#if DEBUG
                        .AddOcelot($"{ocelotConfiguration}.Local", hostingContext.HostingEnvironment);
#else
                        .AddOcelot(ocelotConfiguration, hostingContext.HostingEnvironment);
#endif
                });

                webBuilder.UseStartup<Startup>();
            });

            return host;
        }
    }
}
