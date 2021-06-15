package Main;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditOrder
 */
@WebServlet("/EditOrder")
public class EditOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditOrder() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	// TODO Auto-generated method stub

		resp.sendRedirect("admin.jsp");
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter writer = response.getWriter();
		int id = Integer.parseInt(request.getParameter("submit"));
		String penalty = request.getParameter("penalty_for_damage_value");
		String falseinput = request.getParameter("falseinput");
		if(penalty != null) {
			try {
				Class.forName("org.postgresql.Driver");
				java.sql.Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/car_rent", "postgres", "lammer2105");
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("UPDATE orders SET penalty_for_damage = "+penalty+" WHERE id = "+id+"; ");
				stmt.close();
				conn.close();
			} catch (SQLException | ClassNotFoundException e) {
				e.printStackTrace();
			}
		}else {
			boolean approve = false;
			try {
				Class.forName("org.postgresql.Driver");
				java.sql.Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/car_rent", "postgres", "lammer2105");
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select * FROM orders  WHERE id = "+id+";");
				while(rs.next()) {
					approve = ! rs.getBoolean("isapproved");
				}
				ResultSet query = stmt.executeQuery("UPDATE orders SET isapproved = "+approve+" WHERE id = "+id+";");
				stmt.close();
				conn.close();
			} catch (SQLException | ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
		response.sendRedirect("admin.jsp");
		
	}

}
