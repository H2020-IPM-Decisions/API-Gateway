using System.Collections.Generic;
using System.Net.Mime;
using Microsoft.AspNetCore.Mvc;
using H2020.IPMDecisions.APG.Core.Dtos;
using System;

namespace H2020.IPMDecisions.APG.API.Controllers
{
    [Produces(MediaTypeNames.Application.Json)]
    [Route("/api")]
    [ApiController]
    public class RootController: ControllerBase
    {
        [HttpGet("", Name = "GetRoot")]
        public IActionResult GetRoot()
        {
            var links = new List<LinkDto>();

            links.Add(
                new LinkDto(Url.Link("GetRoot", new { }),
                "self",
                "GET"));

            links.Add(
                new LinkDto(CreateUri("/api/idp"),
                "idp_root",
                "get"));

            links.Add(
                new LinkDto(CreateUri("/api/upr"),
                "upr_root",
                "GET"));

            links.Add(
                new LinkDto(CreateUri("/api/eml"),
                "eml_root",
                "GET"));

            return Ok(links);
        }

        private string CreateUri(string endPointRoute)
        {
            var absUrl = string.Format("{0}://{1}{2}", Request.Scheme,
                        Request.Host, endPointRoute);
            var uri = new Uri(absUrl, UriKind.Absolute).ToString();
            return uri;
        }
    }
}