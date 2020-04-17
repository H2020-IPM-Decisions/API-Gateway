using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
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