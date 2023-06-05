<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="my.com.Student" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Student Table</title>
        <style>
            table {
                border-collapse: collapse;
                width: 30%;
            }
            
            th {
                padding: 8px;
                text-align: left;
                border: 1px solid black;
                color: white;
                background-color: #6699ff;
            }
            
            td {
                padding: 8px;
                text-align: left;
                border: 1px solid black;
            }
            
            td.studentId{
                text-align: left;
            }
            
            td.marks{
                text-align: right;
            }
            
            td.department{
                text-align: center;
            }
            
            td.pass{
                text-align: center;
            }
        </style>
        <script>
            function printStudentName(studentName) {
                document.getElementById("userID").innerHTML = studentName;
            }
        </script>
    </head>
    <body>
        <h1>Welcome <span id="userID"><?:userID></h1>

        <table>
            <thead>
                <tr>
                    <th>Department</th>
                    <th>Student ID</th> 
                    <th>Marks</th>
                    <th>Pass%</th>
                </tr>
            </thead>

            <tbody>
                <%
                    List<Student> students = (List<Student>) request.getAttribute("students");
                    Map<String, Double> passPercentages = (Map<String, Double>) request.getAttribute("passPercentages");
                    String previousDepartment = "";
                    double previousPassPercentage = 0.0;
                    int p = 0;
                    int j = 0;
                    int maxDepartmentValue = 0;
                    for (Student student : students) {
                            String department = student.getDepartment();
                            String numericValue = department.substring(department.lastIndexOf(" ") + 1);
                            int value = Integer.parseInt(numericValue);

                            if (value > maxDepartmentValue) {
                                maxDepartmentValue = value;
                            }
                        }
                    System.out.println("Max Department Value: " + maxDepartmentValue);
                    for (Student student : students) {
                        String currentDepartment = student.getDepartment();
                        double currentPassPercentage = passPercentages.get(currentDepartment);  
                        String passPercentageText = String.format("%.2f", currentPassPercentage);
                            if (passPercentageText.endsWith(".00")) {
                                passPercentageText = passPercentageText.substring(0, passPercentageText.indexOf("."));
                            }
                        if (!currentDepartment.equals(previousDepartment) || currentPassPercentage != previousPassPercentage) {     
                            if (j < maxDepartmentValue - 1) {
                                    j++;
                                }
                            int i = 0;
                            int rowspanVal = 0;
                            for (int z = 0; z < students.size(); z++) {
                                Student students1 = students.get(p);
                                String studentRecord = students1.getDepartment();
                                if (!studentRecord.equals("Dep " +j)) {
                                    break; // Found the matching department, exit the loop
                                }
                                p++;
                                i++;
                            }
                            rowspanVal = i;
                %>
                <tr>
                    <td class="department" rowspan="<%= rowspanVal %>"><%= currentDepartment%></td>
                    <td><a href="#" onclick="printStudentName('<%= student.getStudentName()%>')" style="color: #6699ff;"><%= student.getStudentID()%></a></td>
                    <td class="marks"><%= student.getMark()%></td>
                    <td class="pass" rowspan="<%= rowspanVal %>"><%= passPercentageText%></td>
                </tr>
                <%
                } else {
                    // Same department and pass percentage, show only the student data
                %>
                <tr>
                    
                    <td><a href="#" onclick="printStudentName('<%= student.getStudentName()%>')" style="color: #6699ff;"><%= student.getStudentID()%></a></td>
                    <td class="marks"><%= student.getMark()%></td>
                   
                </tr>
                <%
                        }

                        previousDepartment = currentDepartment;
                        previousPassPercentage = currentPassPercentage;
                    }
                %>
            </tbody>
   
        </table>
    </body>
</html>
