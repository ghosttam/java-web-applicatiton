package my.com;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tam
 */
@WebServlet("/")
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String validUserID = "admin";
        String validPassword = "password";

        if (username.equals(validUserID) && password.equals(validPassword)) {
            List<Student> studentList = new ArrayList<>();
            request.setAttribute("students", studentList);
            studentList.add(new Student("S1", "John Doe", "Dep 1", 35));
            studentList.add(new Student("S2", "Will Smith", "Dep 1", 70));
            studentList.add(new Student("S3", "Alice", "Dep 1", 60));
            studentList.add(new Student("S4", "Ali", "Dep 1", 90));
            studentList.add(new Student("S5", "Jonathan", "Dep 2", 30));
            studentList.add(new Student("S6", "Sabrina", "Dep 3", 32));
            studentList.add(new Student("S7", "Angeline", "Dep 3", 70));
            studentList.add(new Student("S8", "Kamal", "Dep 3", 20));
            // ... add more students

            Map<String, Double> passPercentages = calculatePassPercentages(studentList);

            // Store the list of students and pass percentages in request attributes
            request.setAttribute("students", studentList);
            request.setAttribute("passPercentages", passPercentages);

            // Redirect to the welcome page
            RequestDispatcher dispatcher = request.getRequestDispatcher("welcomePage.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }

    private Map<String, Double> calculatePassPercentages(List<Student> students) {
        Map<String, Integer> departmentCounts = new HashMap<>();
        Map<String, Integer> departmentPassCounts = new HashMap<>();

        for (Student student : students) {
            String department = student.getDepartment();
            int mark = student.getMark();

            departmentCounts.put(department, departmentCounts.getOrDefault(department, 0) + 1);

            if (mark >= 40) {
                departmentPassCounts.put(department, departmentPassCounts.getOrDefault(department, 0) + 1);
            }
        }

        Map<String, Double> passPercentages = new HashMap<>();
        for (String department : departmentCounts.keySet()) {
            int count = departmentCounts.get(department);
            int passCount = departmentPassCounts.getOrDefault(department, 0);
            double passPercentage = (passCount / (double) count) * 100;
            passPercentages.put(department, passPercentage);
        }

        return passPercentages;
    }
}
