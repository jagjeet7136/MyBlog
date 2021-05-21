package app.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import app.dao.LikeDao;
import app.helper.ConnectionProvider;

public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LikeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
//		out.println("This is like servlet");
		String operation = request.getParameter("operation");
		int uid = Integer.parseInt(request.getParameter("uid"));
		int pid = Integer.parseInt(request.getParameter("pid"));
		
//		out.println(operation);
//		out.println(uid);
//		out.println(pid);
		LikeDao l = new LikeDao(ConnectionProvider.getConnection());
		if(operation.equals("like")) {
			
			int i = l.insertLike(pid, uid);
			if(i>0) {
				out.println(true);
			}
			else {
				out.println(false);
			}
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("This is like servlet");
	}

}
