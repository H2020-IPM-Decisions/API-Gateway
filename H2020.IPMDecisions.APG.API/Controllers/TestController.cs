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

        [Authorize(Policy = "Level1")]
        [HttpGet("userlevel")]
        public string UserLevel()
        {
            return "Only if you have a valid token!";
        }

        [Authorize(Policy = "Level2")]
        [HttpGet("UserLevel2")]
        public string UserLevel2()
        {
            return "Only if you have a valid token!";
        }

        [Authorize(Policy = "Level3")]
        [HttpGet("UserLevel3")]
        public string UserLevel3()
        {
            return "Only if you have a valid token!";
        }
    }
}