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
import app.dao.PostDao;
import app.entities.Post;
import app.entities.User;
import app.helper.ConnectionProvider;
import app.helper.Helper;

@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddPostServlet() {
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
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		int cid = Integer.parseInt(request.getParameter("cid"));
		String ptitle = request.getParameter("ptitle");
		String pcontent = request.getParameter("pcontent");
		Part part = request.getPart("ppic");
		String ppic = getSubmittedFileName(part);
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		int userid = user.getId();
		
//		out.println(ptitle);
//		out.println(pcontent);
//		out.println(pcode);
//		out.println(ppic);
//		out.println(cid);
//		out.println(userid);
		
		
		Post p = new Post(ptitle, pcontent,ppic, null, cid, userid);
		PostDao dao = new PostDao(ConnectionProvider.getConnection());
		if(dao.savePost(p)>0) {
			
			String path = "C:/Users/jagjeet/eclipse-workspace/AdvanceProject/src/main/webapp/"+ "blogPics" + "/" + ppic;
			Helper.saveFile(part.getInputStream(), path);
			out.println("done");

		}
		else {
			out.println("error");
		}
		
	}

}
