<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Car`s statistics</title>

    <link rel="stylesheet" href="http://localhost:8080/Car_rent/default.css">
    <link rel="stylesheet" href="http://localhost:8080/Car_rent/buttons.css">
</head>
<body>
	
	  <div id="container">
	   <div id="header">Car`s statistics</div>
	   <div id="sidebar">
	    <p><a href="order.jsp">To order a car</a></p>
	   	<p><a href="admin.jsp">Order list (for administrator)</a></p>
	   	<p><a href="pay.jsp">Payment</a></p>
	   </div>
	   <div id="content" align="center">
	   <%
	        Class.forName("org.postgresql.Driver");
			java.sql.Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/car_rent", "postgres", "lammer2105");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from cars order by count_of_orders;");
			int iterator = 1;
			out.append("<table align=\"center\" border=\"1\"> <th>id</th> <th>Car name</th> <th>Count of orders</th> <th>Price</th>");
			
			while (rs.next()) {
				out.append("<tr> <td> " + 
				rs.getInt("id") + " </td> <td> " + 
				rs.getString("name") + " </td> <td> " +
				rs.getInt("count_of_orders") + " </td> <td> " +
				rs.getInt("price") + "</td> </tr>");
	        }
			out.append("</table> <style>.red{background-color:red;} .green{background-color:green;}</style>");
			stmt.close();
			conn.close();
	        %>
	   </div>
	   <div align = "left"><p>Supplier recommendations: text</p></div>
	   <div id="footer">&copy; </div>
	  </div>
</body>
</html>