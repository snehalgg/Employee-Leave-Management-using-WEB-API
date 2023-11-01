namespace EmployeeLeaveManagementAPI.Models
{
    public class Employee
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Position { get; set; }
        public int SeekLeaves { get; set; }
        public int CasualLeaves { get; set; }
    }
}
