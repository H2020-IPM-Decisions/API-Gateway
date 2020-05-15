using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;

namespace H2020.IPMDecisions.APG.API.Extensions
{
    public static class ServiceExtensions
    {
        public static void ConfigureJwtAuthentication(this IServiceCollection services, IConfiguration config)
        {
            var jwtSecretKey = config["JwtSettings:SecretKey"];
            var authorizationServerUrl = config["JwtSettings:IssuerServerUrl"];
            var audiencesServerUrl = Audiences(config["JwtSettings:ValidAudiencesUrls"]);

            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
            .AddJwtBearer(JwtBearerDefaults.AuthenticationScheme, options =>
            {
                options.RequireHttpsMetadata = false;
                options.SaveToken = true;
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,

                    ValidIssuer = authorizationServerUrl,
                    ValidAudiences = audiencesServerUrl,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSecretKey))
                };
            });
        }

        public static void ConfigureAuthorization(this IServiceCollection services, IConfiguration config)
        {
            var claimType = config["AccessClaims:ClaimTypeName"];
            var accessLevels = AccessLevels(config["AccessClaims:UserAccessLevels"]);

            services.AddAuthorization(options =>
            {
                accessLevels.ToList().ForEach(
                    (level => 
                    {
                        options.AddPolicy(level, policy => policy.RequireClaim(claimType, level));                    
                    }
                ));
            });
        }

        public static void ConfigureCors(this IServiceCollection services, IConfiguration config)
        {
            var allowedHosts = config["AllowedHosts"];
            services.AddCors(options =>
            {
                options.AddPolicy("ApiGatewayCORS", builder =>
                {
                    builder
                    .WithOrigins(allowedHosts)
                    .AllowAnyHeader();
                });
            });
        }

        public static void ConfigureKestrelWebServer(this IServiceCollection services, IConfiguration config)
        {
            services.Configure<KestrelServerOptions>(
                config.GetSection("Kestrel")
            );
        }

        public static void ConfigureForwardedHeaders(this IServiceCollection services, IConfiguration config)
        {
            services.Configure<ForwardedHeadersOptions>(options =>
            {
                options.ForwardedHeaders =
                    ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto;

                options.KnownProxies.Add(IPAddress.Parse(config["ProxyIpAddress"]));
            });
        }
        
        public static void ConfigureHttps(this IServiceCollection services, IConfiguration config)
        {
            services.AddHsts(options =>
            {
                options.Preload = true;
                options.IncludeSubDomains = true;
                options.MaxAge = TimeSpan.FromDays(60);
            });

            services.AddHttpsRedirection(options =>
            {
                options.RedirectStatusCode = StatusCodes.Status308PermanentRedirect;
                options.HttpsPort = int.Parse(config["ASPNETCORE_HTTPS_PORT"]);
            });
        }
        
        public static IEnumerable<string> Audiences(string audiences)
        {
            var listOfAudiences = audiences.Split(';').ToList();
            return listOfAudiences;
        }

        public static IEnumerable<string> AccessLevels(string levels)
        {
            var listOfLevels = levels.Split(';').ToList();
            return listOfLevels;
        }
    }
}