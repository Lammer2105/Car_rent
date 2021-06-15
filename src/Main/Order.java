package Main;

import java.io.*;
import java.sql.*;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class Order
 */
@WebServlet("/Order")
public class Order extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Order() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	    response.setContentType("text/html;charset=utf-8");
		response.sendRedirect("order.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=utf-8");
	    String car_name = request.getParameter("car_name");
	    String first_name = request.getParameter("first_name");
	    String second_name = request.getParameter("second_name");
	    String passport = request.getParameter("passport");
	    int time = Integer.parseInt(request.getParameter("time"));
	    String phone_number = request.getParameter("phone_number");
	    boolean is_adult = Boolean.parseBoolean(request.getParameter("is_adult"));
	    if(first_name == "" && second_name == "" || passport =="") {
	    	request.getRequestDispatcher("order.jsp").forward(request, response);
	    	return;
	    }
	    int id = 0;
	    int count_of_orders = 0;
	     try {
		   Class.forName("org.postgresql.Driver");
		   java.sql.Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/car_rent", "postgres", "lammer2105");
		   Statement stmt = conn.createStatement();
		   ResultSet rs = stmt.executeQuery("INSERT INTO orders (first_name, second_name, passport, time, phone_number, isapproved, isadult, ispaid, penalty_for_damage, car_name, summ) VALUES (\'"+ first_name + "\', \'" + second_name + "\', \'" + passport + "\', " + time + ", \'" + phone_number + "\', " + false  + ", " + is_adult + ", " + false + ", " + 0 + ", \'" + car_name +"\', "+ time*1500 +") RETURNING id;");
		   while (rs.next()) {	
		    id = (rs.getInt(rs.getMetaData().getColumnName(1)));
		         }
		   ResultSet rs2 =  stmt.executeQuery("select * from cars where name = "+car_name);
		   while (rs.next()) {
		    count_of_orders = (rs2.getInt("count_of_orders"));
		         }
		   stmt.executeQuery("update cars set count_of_orders = "+ count_of_orders + 1 +  " where name = "+car_name);
		   stmt.close();
		   conn.close();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	   	request.setAttribute("id", id);
	    request.getRequestDispatcher("pay.jsp").forward(request, response);
	   
	}
}
