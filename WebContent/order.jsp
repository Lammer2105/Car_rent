<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Car rental | Create a order</title>
	  <link rel="stylesheet" href="http://localhost:8080/Car_rent/default.css">
	</head>
	  <body>
	  <div id="container">
	   <div id="header">Car rental
	   <% 
		  if(request.getAttribute("id") != null){
			  out.append("<p id=succes>Order is placed</p>");
			  request.removeAttribute("id");
		  }
	  %></div>
	   <div id="sidebar">
	    <p><a href="order.jsp">To order a car</a></p>
	   	<p><a href="admin.jsp">Order list (for administrator)</a></p>
	   	<p><a href="pay.jsp">Payment</a></p>
	   <p><a href="statistics.jsp">Statistics</a></p> 
	   </div>
	   <div id="content" align="center">
	    <h2>Select a car from the list and fill out the form</h2>
	   <div class="order_form">
	     <form action="Order" method="post" name="order_form" onsubmit="return validate_form();">
	     <table>
	       <tr>
	         <td>Car</td>
	         <td> 
	         	<select name="car_name" id="car_name">
	         <%
	         	Class.forName("org.postgresql.Driver");
				java.sql.Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/car_rent", "postgres", "lammer2105");
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select * from cars;");
				while (rs.next()) {
					out.append("<option>"+rs.getString("name")+"</option>");
		        }
				stmt.close();
				conn.close();
	         %>
	              </select>  
	         </td>
	       </tr>
	       <tr>
	         <td><label for="first_name">First name *</label></td>
	         <td><input type="text" name="first_name"></td>
	       </tr>
	       <tr>
	         <td><label for="second_name">Second name *</label></td>
	         <td><input type="text" name="second_name"></td>
	       </tr>
	       <tr>
	         <td><label for="passport">Passport *</label></td>
	         <td><input type="text" name="passport"></td>
	       </tr>
	       <tr>
	         <td><label for="time">Lease term, days</label></td>
	         <td><input type="number" name="time" value="1"></td>
	       </tr>
	       <tr>
	         <td><label for="phone_number">Phone number</label></td>
	         <td><input name="phone_number" id="phone_number"></td>
	       </tr>
	       <tr>
	         <td align="right"><input type="checkbox" value="true" name="is_adult"></td>
	         <td><label for="is_adult">I am 18 years old</label></td>
	       </tr>
	       <tr>
	         <td></td>
	         <td align="right"><input type="submit" value="Submit"></td>
	       </tr>
	     </table>
	     * - required field
	   </form>
	   </div>
	   </div>
	   <div id="footer">&copy; </div>
	  </div>
	 </body>
</html>