package controllers;

import beans.User;
import daos.UserDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
@WebServlet("/")
public class UserServlet extends HttpServlet {

    private final UserDAO userDAO;
    private int id;
    public UserServlet() {
        this.userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = "";
        String[] resources = request.getServletPath().split("/");
        if (resources.length > 0) {
            action = resources[1];
        }
        if (resources.length == 3) {
            id = Integer.parseInt(resources[2]);
        }
        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertUser(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateUser(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                default:
                    listUser(request, response);
                    break;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    private void listUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> listUsers = userDAO.selectAllUsers();
        RequestDispatcher dispatcher = request.getRequestDispatcher("/user.jsp");
        request.setAttribute("listUsers", listUsers);
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> listUsers = userDAO.selectAllUsers();
        RequestDispatcher dispatcher = request.getRequestDispatcher("/user.jsp");
        request.setAttribute("listUsers", listUsers);
        dispatcher.forward(request, response);
    }

    private void insertUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String country = request.getParameter("country");
        User newUser = new User(name, email, country);
        if (userDAO.insertUser(newUser) == 1) {
            response.sendRedirect("/list");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (userDAO.selectUser(this.id) != null) {
            User existingUser = userDAO.selectUser(this.id);
            List<User> listUsers = userDAO.selectAllUsers();
            RequestDispatcher dispatcher = request.getRequestDispatcher("/user.jsp");
            request.setAttribute("existingUser", existingUser);
            request.setAttribute("listUsers", listUsers);
            dispatcher.forward(request, response);
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String country = request.getParameter("country");
        User user = new User(this.id, name, email, country);
        if (userDAO.updateUser(user)) {
            response.sendRedirect("/list");
        }
    }
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        if (userDAO.deleteUser(this.id)) {
            response.sendRedirect("/list");
        }
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}