﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProjectTracker.Shared.Models.Account;

namespace ProjectTracker.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly IAccountService _accountService;

        public AccountController(IAccountService accountService)
        {
            _accountService = accountService;
        }

        [HttpPost]
        public async Task<ActionResult<AccountRegistrationResponse>> Register(AccountRegistrationRequest request)
        {
            var result = await _accountService.RegisterAsync(request);
            return Ok(result);
        }

        [HttpPost("role")]
        public async Task<IActionResult> AssignRole(string userName, string roleName)
        {
            await _accountService.AssignRole(userName, roleName);
            return Ok();
        }
    }
}
