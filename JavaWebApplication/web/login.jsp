<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $("form").submit(function(event) {
                var username = $("#username").val();
                var password = $("#password").val();

                if (username.trim() === "" || password.trim() === "") {
                    event.preventDefault();
                    alert("Please enter both username and password.");
                }
            });
        });
    </script>
</head>
<body>
    <h1>Login</h1>
    <%-- Display error message if present --%>
    <% if (request.getParameter("error") != null) { %>
        <p style="color: red;">Invalid username or password. Please try again.</p>
    <% } %>
    
    <form method="post" action="LoginServlet">
        <label for="username">User ID</label>
        <input type="text" id="username" name="username"><br><br>
        
        <label for="password">Password</label>
        <input type="password" id="password" name="password"><br><br>
        
        <input type="submit" value="Login">
    </form>
</body>
</html>
