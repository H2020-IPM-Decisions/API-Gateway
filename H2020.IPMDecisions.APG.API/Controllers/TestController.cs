using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace H2020.IPMDecisions.APG.API.Controllers
{
    [ApiController]
    [Route("/api/test")]

    public class TestController : ControllerBase
    {
        [HttpGet("notprotected")]
        public string NotProtected()
        {
            return "No token needed!";
        }

        [Authorize]
        [HttpGet("protected")]
        public string Protected()
        {
            return "Only if you have a valid token!";
        }

        [Authorize(Roles = "SuperAdmin")]
        [HttpGet("SuperAdmin")]
        public string ProtectedSuperAdmin()
        {
            return "Only if you have a valid token!";
        }

        [Authorize(Roles = "ExtraRole")]
        [HttpGet("ExtraRole")]
        public string ProtectedExtraRole()
        {
            return "Only if you have a valid token!";
        }

        [Authorize(Roles = "SuperAdmin, ExtraRole")]
        [HttpGet("BothRoles")]
        public string ProtectedBothRoles()
        {
            return "Only if you have a valid token!";
        }
    }
}