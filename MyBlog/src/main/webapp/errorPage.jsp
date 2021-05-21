<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Something went wrong</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/myStyle.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	clip-path: polygon(0% 0%, 100% 0%, 100% 87%, 75% 87%, 75% 100%, 42% 87%, 0 86%);
}
</style>
</head>
<body>
	<div class="container text-center">
		<img src="images/error-404.png" class="img-fluid" style="width: 25vw;">
		<h3 class="display-4">Something went wrong, go back</h3>
		<div class="display-5"><%=exception%></div>
		<a href="index.jsp" class="btn btn-lg text-white mt-3"
			style="background-color: #4A148C;">Home</a>
	</div>
	<%
	session.removeAttribute("currentUser");
	%>

</body>
</html>