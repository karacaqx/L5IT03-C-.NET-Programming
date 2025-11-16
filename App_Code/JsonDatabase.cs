using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace EmployeeManagement.Data
{
    public class Employee
    {
        public string EmployeeId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Department { get; set; }
        public string Position { get; set; }
        public decimal Salary { get; set; }
        public DateTime HireDate { get; set; }
        public Address Address { get; set; }
        public bool IsActive { get; set; }

        public string FullName => $"{FirstName} {LastName}";
    }

    public class Address
    {
        public string Street { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string ZipCode { get; set; }
    }

    public class Admin
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Department { get; set; }
        public string FullName { get; set; }
    }

    public class JsonDatabase
    {
        private string _dataPath;

        public JsonDatabase()
        {
            _dataPath = HttpContext.Current.Server.MapPath("~/App_Data/employees.json");
        }

        private JObject LoadData()
        {
            if (!File.Exists(_dataPath))
            {
                throw new FileNotFoundException("Database file not found");
            }

            string jsonContent = File.ReadAllText(_dataPath);
            return JObject.Parse(jsonContent);
        }

        private void SaveData(JObject data)
        {
            string jsonContent = data.ToString(Formatting.Indented);
            File.WriteAllText(_dataPath, jsonContent);
        }

        public Admin ValidateAdmin(string username, string password)
        {
            try
            {
                var data = LoadData();
                var admins = data["admins"].ToObject<List<Admin>>();

                return admins.Find(a => a.Username == username && a.Password == password);
            }
            catch (Exception)
            {
                return null;
            }
        }

        public List<Employee> GetAllEmployees()
        {
            try
            {
                var data = LoadData();
                return data["employees"].ToObject<List<Employee>>();
            }
            catch (Exception)
            {
                return new List<Employee>();
            }
        }

        public Employee GetEmployeeById(string employeeId)
        {
            try
            {
                var employees = GetAllEmployees();
                return employees.Find(e => e.EmployeeId.Equals(employeeId, StringComparison.OrdinalIgnoreCase));
            }
            catch (Exception)
            {
                return null;
            }
        }

        public List<Employee> GetEmployeesByDepartment(string department)
        {
            try
            {
                var employees = GetAllEmployees();
                return employees.FindAll(e => e.Department.Equals(department, StringComparison.OrdinalIgnoreCase));
            }
            catch (Exception)
            {
                return new List<Employee>();
            }
        }

        public bool UpdateEmployee(Employee employee)
        {
            try
            {
                var data = LoadData();
                var employees = data["employees"].ToObject<List<Employee>>();

                int index = employees.FindIndex(e => e.EmployeeId == employee.EmployeeId);
                if (index >= 0)
                {
                    employees[index] = employee;
                    data["employees"] = JArray.FromObject(employees);
                    SaveData(data);
                    return true;
                }
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool AddEmployee(Employee employee)
        {
            try
            {
                var data = LoadData();
                var employees = data["employees"].ToObject<List<Employee>>();

                // Check if employee ID already exists
                if (employees.Exists(e => e.EmployeeId == employee.EmployeeId))
                {
                    return false;
                }

                employees.Add(employee);
                data["employees"] = JArray.FromObject(employees);
                SaveData(data);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool DeleteEmployee(string employeeId)
        {
            try
            {
                var data = LoadData();
                var employees = data["employees"].ToObject<List<Employee>>();

                int index = employees.FindIndex(e => e.EmployeeId == employeeId);
                if (index >= 0)
                {
                    employees.RemoveAt(index);
                    data["employees"] = JArray.FromObject(employees);
                    SaveData(data);
                    return true;
                }
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}