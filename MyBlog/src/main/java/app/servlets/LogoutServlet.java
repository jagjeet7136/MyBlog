package app.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import app.entities.Message;

public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
//		PrintWriter out = response.getWriter();
//		out.println("Hello World");
		
		HttpSession session = request.getSession();
		session.removeAttribute("currentUser");
		Message m = new Message("Logout Successfully", "sucess", "alert-success");
		session.setAttribute("message", m);
		response.sendRedirect("loginPage.jsp");
	}

}
