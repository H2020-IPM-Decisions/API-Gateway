using H2020.IPMDecisions.APG.API.Extensions;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json.Serialization;
using Ocelot.DependencyInjection;
using Ocelot.Middleware;

namespace H2020.IPMDecisions.APG.API
{
    public class Startup
    {
        public IConfiguration Configuration { get; }
        private IWebHostEnvironment CurrentEnvironment { get; set; }

        public Startup(IConfiguration configuration, IWebHostEnvironment environment)
        {
            Configuration = configuration;
            CurrentEnvironment = environment;
        }

        public void ConfigureServices(IServiceCollection services)
        {

            if (!CurrentEnvironment.IsDevelopment())
            {
                services.ConfigureHttps(Configuration);
            }

            services.ConfigureKestrelWebServer(Configuration);

            services.ConfigureCors(Configuration);

            services
                .AddControllers(setupAction =>
                {
                    setupAction.ReturnHttpNotAcceptable = true;
                })
                .AddNewtonsoftJson(setupAction =>
                 {
                     setupAction.SerializerSettings.ContractResolver =
                     new CamelCasePropertyNamesContractResolver();
                 });

            services.AddOcelot();
            services.ConfigureJwtAuthentication(Configuration);
            services.ConfigureAuthorization(Configuration);

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public async void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (CurrentEnvironment.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                if (CurrentEnvironment.IsProduction())
                {
                    app.UseForwardedHeaders();
                    app.UseHsts();
                    app.UseHttpsRedirection();
                }
                app.UseExceptionHandler(appBuilder =>
                {
                    appBuilder.Run(async context =>
                    {
                        context.Response.StatusCode = 500;
                        await context.Response.WriteAsync("An unexpected error happened. Try again later.");
                    });
                });
            }
            
            app.UseCors("ApiGatewayCORS");
            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });

            await app.UseOcelot();
        }
    }
}
