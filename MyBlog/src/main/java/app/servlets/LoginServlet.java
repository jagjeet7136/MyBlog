package app.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import app.dao.UserDao;
import app.entities.Message;
import app.entities.User;
import app.helper.ConnectionProvider;


//@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("Hello World");
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
//		out.println(email);
//		out.println(password);
		
		UserDao dao = new UserDao(ConnectionProvider.getConnection());
		
		User user = dao.getUser(email, password);
		
		if(user==null) {
//			out.println("invalid");
			Message m = new Message("Invalid Details", "error", "alert-danger");
			HttpSession session = request.getSession();
			session.setAttribute("message", m);
			response.sendRedirect("loginPage.jsp");
		}
		else {
			HttpSession session = request.getSession();
			session.setAttribute("currentUser", user);
			response.sendRedirect("profile.jsp");
		}
	}

}
