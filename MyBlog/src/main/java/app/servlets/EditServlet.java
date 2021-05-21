package app.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import app.dao.UserDao;
import app.entities.Message;
import app.entities.User;
import app.helper.ConnectionProvider;
import app.helper.Helper;

@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EditServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	private static String getSubmittedFileName(Part part) {
		for (String cd : part.getHeader("content-disposition").split(";")) {
			if (cd.trim().startsWith("filename")) {
				String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
				return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
			}
		}
		return null;
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String email = request.getParameter("user_email");
		String name = request.getParameter("user_name");
		String password = request.getParameter("user_password");
		String about = request.getParameter("user_about");
		Part part = request.getPart("image");
		String image = getSubmittedFileName(part);

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");

		user.setEmail(email);
		user.setName(name);
		user.setPassword(password);
		user.setAbout(about.trim());
		String oldFile = user.getProfile();
		user.setProfile(image);

		UserDao d = new UserDao(ConnectionProvider.getConnection());
		boolean bool = d.updateUser(user);
		if(bool) {

			String path = "C:/Users/jagjeet/eclipse-workspace/AdvanceProject/src/main/webapp/"+ "pics" + "/" + user.getProfile();
			
			String oldFilePath = "C:/Users/jagjeet/eclipse-workspace/AdvanceProject/src/main/webapp/"+ "pics" + "/" + oldFile;
			if(oldFile.equals("default.png")) {
				Helper.deleteFile(oldFilePath);
			}
			
			if(Helper.saveFile(part.getInputStream(), path)) {
				out.println(path);
				Message m = new Message("Profile Updated", "success", "alert-success");
				session.setAttribute("message2", m);
			}
			else {
				out.println("not updated");
				Message m = new Message("Something went wrong", "error", "alert-danger");
				session.setAttribute("message2", m);
			}
		}
		else {
			out.println("Not updated");
			Message m = new Message("Something went wrong", "error", "alert-danger");
			session.setAttribute("message2", m);
		}

		response.sendRedirect("profile.jsp");
	}

}
