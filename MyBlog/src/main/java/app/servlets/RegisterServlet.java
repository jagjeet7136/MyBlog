package app.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import app.dao.UserDao;
import app.entities.User;
import app.helper.ConnectionProvider;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		//		out.println("<!DOCTYPE html");
		//		out.println("<html>");
		//		out.println("<head>");
		//		out.println("<title>Servlet RegisterServlet</title>");
		//		out.println("</head>");
		//		out.println("<body>");

		String check = request.getParameter("check");
		if(check==null) {
			out.println("Box not checked");
		}
		else {
			try {
				String username = request.getParameter("user_name");
				String password = request.getParameter("user_password");
				String email = request.getParameter("user_email");
				String gender = request.getParameter("gender");
				String about = request.getParameter("about");

				User user = new User(username, email, password, gender, about);
				UserDao addUser = new UserDao(ConnectionProvider.getConnection());
				int i = addUser.saveUser(user);

				if(i>0) {
					out.println("Done");
				}
				else {
					out.println("Something is wrong");
				}
			} catch (Exception e) {
				out.println("Already registered email");
			}


		}

		//		out.println("</body>");
		//		out.println("</html>");
	}

}
