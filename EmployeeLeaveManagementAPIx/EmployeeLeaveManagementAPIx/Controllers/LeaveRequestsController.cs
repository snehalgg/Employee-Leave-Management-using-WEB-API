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
    public class LeaveRequestsController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public LeaveRequestsController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        // GET: api/LeaveRequests
        [HttpGet]
        public IEnumerable<LeaveRequest> Get()
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "SELECT * FROM LeaveRequests";
            return db.Query<LeaveRequest>(query);
        }

        // GET: api/LeaveRequests/5
        [HttpGet("{id}")]
        public LeaveRequest Get(int id)
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "SELECT * FROM LeaveRequests WHERE Id = @id";
            return db.QueryFirstOrDefault<LeaveRequest>(query, new { id });
        }

        // POST: api/LeaveRequests
        [HttpPost]
        public void Post([FromBody] LeaveRequest leaveRequest)
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "INSERT INTO LeaveRequests (EmployeeId, StartDate, EndDate, LeaveType, Approved) " +
                           "VALUES (@EmployeeId, @StartDate, @EndDate, @LeaveType, @Approved)";
            db.Execute(query, leaveRequest);
        }

        // PUT: api/LeaveRequests/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] LeaveRequest leaveRequest)
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "UPDATE LeaveRequests " +
                           "SET EmployeeId = @EmployeeId, StartDate = @StartDate, EndDate = @EndDate, " +
                           "LeaveType = @LeaveType, Approved = @Approved " +
                           "WHERE Id = @Id";
            leaveRequest.Id = id;
            db.Execute(query, leaveRequest);
        }

        // DELETE: api/LeaveRequests/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "DELETE FROM LeaveRequests WHERE Id = @id";
            db.Execute(query, new { id });
        }

        // PUT: api/LeaveRequests/Approve/5
        [HttpPut("Approve/{id}")]
        public void ApproveLeave(int id)
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "UPDATE LeaveRequests SET Approved = 1 WHERE Id = @id";
            db.Execute(query, new { id });
        }

        // PUT: api/LeaveRequests/Deny/5
        [HttpPut("Deny/{id}")]
        public void DenyLeave(int id)
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "DELETE FROM LeaveRequests WHERE Id = @id";
            db.Execute(query, new { id });
        }
    }
}
