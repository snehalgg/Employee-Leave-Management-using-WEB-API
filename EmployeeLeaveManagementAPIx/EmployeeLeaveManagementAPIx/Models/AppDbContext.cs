// Models/AppDbContext.cs

using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace EmployeeLeaveManagementAPI.Models
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public DbSet<Employee> Employees { get; set; }
    }
}
