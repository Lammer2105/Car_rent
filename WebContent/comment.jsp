<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Refuse</title>
    <link rel="stylesheet" href="http://localhost:8080/Car_rent/default.css">
</head>
<body>
<div id="container">
	    <div id="header">The reason for refusal</div>
	  <div id="sidebar">
	   <p><a href="order.jsp">To order a car</a></p>
	   <p><a href="admin.jsp">Order list (only for administrator)</a></p>
	   <p><a href="pay.jsp">Payment</a></p>
	  </div>
	  <div id="content" align="center">
	  	<form action="Comment" method="post">
	  		<span>Describe the reason for the customer's refusal</span>
	  		<textarea name="text"></textarea>
	  		<input name="submit" type="submit" value="<%=request.getParameter("submit") %>">
	  	</form>
	</div>
	</div>
	<div id="footer"></div>
</body>
</html>