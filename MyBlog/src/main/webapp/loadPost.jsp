<%@page import="app.entities.User"%>
<%@page import="app.dao.LikeDao"%>
<%@page import="app.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="app.helper.ConnectionProvider"%>
<%@page import="app.dao.PostDao"%>

<div class="row">

	<%
	PostDao d = new PostDao(ConnectionProvider.getConnection());
	int cid = Integer.parseInt(request.getParameter("cid"));
	ArrayList<Post> post = null;
	if (cid == 0) {
		post = d.getAllPost();
	} else {
		post = d.getPostByCatId(cid);
	}

	if (post.size() == 0) {
		out.println("<h3 class='display-4 text-center'>No Posts here..</h3>");
		return;
	}

	for (Post p : post) {
	%>





	<div class="col-md-6 mt-2 mb-2">

		<div class="card">
			<img class="card-img-top" style="height: 13vw;"
				src="blogPics/<%=p.getPpic()%>" alt="Card image cap">
			<hr>
			<div class="card-body">
				<b><%=p.getPtitle()%></b>
				<p><%=p.getPcontent()%></p>
			</div>
			<div class="card-footer text-center primary-background">

				<%
				LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
				User user = (User) session.getAttribute("currentUser");
				%>
				<i class="fa fa-thumbs-o-up" style="color:white;"><span class="like-counter"><%=ld.countLike(p.getPid())%></span></i>
				&nbsp&nbsp
				<!-- <a href="#" class="btn btn-outline-primary btn-sm"><i
					class="fa fa-commenting-o"><span>10</span></i></a> -->
				<a style="color:white; border:2px solid white" href="showBlog.jsp?post_id=<%=p.getPid()%>"
					class="btn btn-outline-primary btn-sm">Read more</a>
			</div>
		</div>
	</div>

	<%
	}
	%>
</div>

<script src="js/myjs.js" type="text/javascript"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>