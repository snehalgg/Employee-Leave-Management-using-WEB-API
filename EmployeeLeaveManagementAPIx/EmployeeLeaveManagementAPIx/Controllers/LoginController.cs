using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Dapper;
using System.Data;
using System.Data.SqlClient;
using EmployeeLeaveManagementAPI.Models;

namespace EmployeeLeaveManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public LoginController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpPost]
        public IActionResult Post([FromBody] LoginRequest request)
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "SELECT Id, Position FROM Employees WHERE Username = @Username AND Password = @Password";

            var result = db.QueryFirstOrDefault<dynamic>(query, new { Username = request.Username, Password = request.Password });

            if (result != null)
            {
                return Ok(new { success = true, id = result.Id, role = result.Position });
            }

            return BadRequest(new { success = false, message = "Invalid credentials" });
        }
    }
}
