<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Order management</title>
    <link rel="stylesheet" href="http://localhost:8080/Car_rent/default.css">
    <link rel="stylesheet" href="http://localhost:8080/Car_rent/buttons.css">
</head>
<body>
    <div id="container">
	    <div id="header">Admin panel</div>
	  <div id="sidebar">
	   <p><a href="order.jsp">To order a car</a></p>
	   <p><a href="admin.jsp">Order list (only for administrator)</a></p>
	   <p><a href="pay.jsp">Payment</a></p>
	   <p><a href="statistics.jsp">Statistics</a></p> 
	  </div>
	  <div id="content">
	        <%
	        Class.forName("org.postgresql.Driver");
			java.sql.Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/car_rent", "postgres", "lammer2105");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from orders;");
			int iterator = 1;
			out.append("<table align=\"center\" border=\"1\"> <th>id</th> <th>Passport</th> <th>First name</th> <th>Second name</th> <th>Adult</th> <th>Phone number</th> <th>Penalty for damage</th> <th>Time</th> <th>Paid</th> <th>Approved</th> <th>Car name</th> <th>Summ</th> <th>Decline</th>");
			
			while (rs.next()) {
				String color_approved = "red";
				String color_paid = "red";
				String color_adult = "red";
				if (rs.getBoolean("isapproved")){
					color_approved = "green";
				}
				if(rs.getBoolean("ispaid")){
					color_paid = "green";
				}
				if(rs.getBoolean("isadult")){
					color_adult = "green";
				}
				out.append("<tr> <td> " + 
				rs.getInt("id") + " </td> <td> " + 
				rs.getString("passport") + " </td> <td> " +
				rs.getString("first_name") + " </td> <td> " + 
				rs.getString("second_name") + " </td> <td align=center class="+color_adult+"> " +
				rs.getString("isadult") + " </td> <td> " + 
				rs.getString("phone_number") + " </td> <td> <form method=post action=EditOrder><input type=text width=auto name=penalty_for_damage_value value="+
				rs.getString("penalty_for_damage")+"> <input type=submit value="+
				rs.getInt("id")+" name=submit> </form>" + " </td> <td> " + 
				rs.getString("time") + " </td> <td align=center class="+color_paid+"> " +
				rs.getString("ispaid") + " </td> <td align=center class="+color_approved+"> <form action=EditOrder method=post><input type=submit name=submit value=" + 
				rs.getInt("id")+"></form> </td> <td> " + 
				rs.getString("car_name") + " </td> <td>" + 
				rs.getString("summ") + "</td> <td><form action=comment.jsp><input name=submit type=submit value=" + 
				rs.getInt("id")+"> <input type=hidden name=falseinput value=falseinput></form> <p>"+
				rs.getString("comment")+"</p></td> </tr>");
	        }
			out.append("</table> <style>.red{background-color:red;} .green{background-color:green;}</style>");
			stmt.close();
			conn.close();
	        %>
	        
	  </div>
	  	<div id="footer"><form action="Query" method="post"><textarea name="q"></textarea> <input type="submit"></form></div>
    </div>
</body>
</html>