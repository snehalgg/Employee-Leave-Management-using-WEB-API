// Helper function to make API requests
// Helper function to make API requests
function makeApiRequest(url, method, data) {
    return new Promise(function (resolve, reject) {
        var xhttp = new XMLHttpRequest();
        xhttp.open(method, url, true);
        xhttp.setRequestHeader('Content-Type', 'application/json');

        xhttp.onload = function () {
            if (xhttp.status >= 200 && xhttp.status < 300) {
                resolve(JSON.parse(xhttp.responseText));
            } else {
                reject(JSON.parse(xhttp.responseText));
            }
        };

        xhttp.onerror = function () {
            reject({ status: xhttp.status, message: 'Network error' });
        };

        if (data) {
            xhttp.send(JSON.stringify(data));
        } else {
            xhttp.send();
        }
    });
}

async function login() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    try {
        const response = await makeApiRequest('https://localhost:7116/api/Login', 'POST', { Username: username, Password: password });

        if (response && response.success) {
            localStorage.setItem('userId', response.id);
            localStorage.setItem('userRole', response.role);

            // Redirect to dashboard based on role (adminDashboard.html, employeeDashboard.html, managerDashboard.html)
            window.location.href = response.role + 'Dashboard.html';
        } else {
            alert("Invalid credentials. Please try again.");
        }
    } catch (error) {
        console.error('Error:', error);
        alert('An error occurred. Please try again later.');
    }
}




// Rest of your functions remain unchanged

// ...


async function createEmployee() {
    const employee = {
        Name: prompt("Enter employee name"),
        Username: prompt("Enter username"),
        Password: prompt("Enter password"),
        Position: prompt("Enter position"),
        SeekLeaves: parseInt(prompt("Enter seek leaves")),
        CasualLeaves: parseInt(prompt("Enter casual leaves"))
    };

    const response = await makeApiRequest('https://localhost:7116/api/Employees', 'POST', employee);

    if (response) {
        alert('Employee created successfully!');
        window.location.href = "index.html";
    }
}


async function updateEmployeeDetailsUI() {
    const userId = localStorage.getItem('userId');

    if (!userId) {
        alert('User ID not found. Please log in.');
        return;
    }

    try {
        const response = await makeApiRequest(`https://localhost:7116/api/Employees/${userId}`, 'GET');
        const leaveRequests = await makeApiRequest(`https://localhost:7116/api/LeaveRequests?employeeId=${userId}`, 'GET');

        if (response) {
            const employeeDetails = response;
            document.getElementById("employeeName").innerText = employeeDetails.name;
            document.getElementById("seekLeaves").innerText = employeeDetails.seekLeaves;
            document.getElementById("casualLeaves").innerText = employeeDetails.casualLeaves;

            // Calculate pending leaves based on leave requests
            const pendingLeaves = leaveRequests.filter(request => !request.approved).length;
            document.getElementById("pendingLeaves").innerText = pendingLeaves;

            document.getElementById("pastLeaves").innerText = 'To be implemented';
        } else {
            alert("Employee details not found.");
        }
    } catch (error) {
        console.error('Error:', error);
        alert('An error occurred while fetching employee details.');
    }
}





// Call the function to fetch and display employee details
fetchEmployeeDetails();


// Call the function to fetch and display employee details
fetchEmployeeDetails();


async function createManager() {
    const manager = {
        Name: prompt("Enter manager name"),
        Username: prompt("Enter username"),
        Password: prompt("Enter password"),
        Position: "manager",
        SeekLeaves: 0,
        CasualLeaves: parseInt(prompt("Enter casual leaves"))
    };

    const response = await makeApiRequest('https://localhost:7116/api/Employees', 'POST', manager);

    if (response) {
        alert('Manager created successfully!');
        window.location.href = "index.html";
    }
}



async function createLeave() {
    const startDate = prompt("Enter start date (YYYY-MM-DD)");
    const endDate = prompt("Enter end date (YYYY-MM-DD)");
    const leaveType = prompt("Enter leave type (casual or seek)");

    const leaveRequest = {
        EmployeeId: 1, // Replace with the actual employee ID
        StartDate: startDate,
        EndDate: endDate,
        LeaveType: leaveType,
        Approved: false
    };

    const response = await makeApiRequest('https://localhost:7116/api/LeaveRequests', 'POST', leaveRequest);

    if (response) {
        alert('Leave requested successfully!');
        // Increase pending leaves and save to database (you need to implement this logic)
    }
}

// Function to approve leave request
// Function to approve leave request
async function approveLeave(leaveRequestId) {
    const response = await makeApiRequest(`https://localhost:7116/api/LeaveRequests/Approve/${leaveRequestId}`, 'PUT');
    if (response) {
        alert('Leave request approved!');
        removeLeaveRequestCard(leaveRequestId); // Remove the card after approval

        // Assuming you have a function to update employee details in the UI
        updateEmployeeDetailsUI(); // Implement this function as per your UI structure
    } else {
        alert('Failed to approve leave request.');
    }
}

// Function to deny leave request
async function denyLeave(leaveRequestId) {
    const response = await makeApiRequest(`https://localhost:7116/api/LeaveRequests/Deny/${leaveRequestId}`, 'PUT');
    if (response) {
        alert('Leave request denied!');
        removeLeaveRequestCard(leaveRequestId); // Remove the card after denial

        // Assuming you have a function to update employee details in the UI
        updateEmployeeDetailsUI(); // Implement this function as per your UI structure
    } else {
        alert('Failed to deny leave request.');
    }
}

// Function to remove a leave request card
function removeLeaveRequestCard(leaveRequestId) {
    const leaveRequestElement = document.getElementById(`leaveRequest_${leaveRequestId}`);
    if (leaveRequestElement) {
        leaveRequestElement.remove();
    }
}


// Function to update employee details UI (assuming you have a function for this)


// Additional logic for fetching employee details, leave requests, etc.
// ...
