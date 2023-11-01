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
    public class EmployeesController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public EmployeesController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        // GET: api/Employees
        [HttpGet]
        public IEnumerable<Employee> Get()
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "SELECT * FROM Employees";
            return db.Query<Employee>(query);
        }

        // GET: api/Employees/5
        [HttpGet("{id}")]
        public Employee Get(int id)
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "SELECT * FROM Employees WHERE Id = @id";
            return db.QueryFirstOrDefault<Employee>(query, new { id });
        }

        // POST: api/Employees
        [HttpPost]
        public void Post([FromBody] Employee employee)
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "INSERT INTO Employees (Name, Username, Password, Position, SeekLeaves, CasualLeaves) " +
                           "VALUES (@Name, @Username, @Password, @Position, @SeekLeaves, @CasualLeaves)";
            db.Execute(query, employee);
        }

        // PUT: api/Employees/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] Employee employee)
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "UPDATE Employees " +
                           "SET Name = @Name, Username = @Username, Password = @Password, Position = @Position, " +
                           "SeekLeaves = @SeekLeaves, CasualLeaves = @CasualLeaves " +
                           "WHERE Id = @Id";
            employee.Id = id;
            db.Execute(query, employee);

            // Assuming a manager approves a leave request
            if (employee.Position == "manager" && employee.CasualLeaves > 0)
            {
                employee.CasualLeaves--;
                employee.SeekLeaves++;
                db.Execute(query, employee);
            }
        }

        // DELETE: api/Employees/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            using IDbConnection db = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            string query = "DELETE FROM Employees WHERE Id = @id";
            db.Execute(query, new { id });
        }


    }
}
