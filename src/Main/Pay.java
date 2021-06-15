package Main;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Pay
 */
@WebServlet("/Pay")
public class Pay extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Pay() {
        super();
        // TODO Auto-generated constructor stub
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	// TODO Auto-generated method stub
    	resp.sendRedirect("order.jsp");
    	
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		try {
			Class.forName("org.postgresql.Driver");
			java.sql.Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/car_rent", "postgres", "lammer2105");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("UPDATE orders SET ispaid = true WHERE id = "+id+";");
			stmt.close();
			conn.close();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		System.out.println(id);
		request.setAttribute("id", id);
		request.getRequestDispatcher("order.jsp").forward(request, response);
	}

}
