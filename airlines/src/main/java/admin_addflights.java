import java.io.*;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class admin_addflights extends HttpServlet {
   private static final long serialVersionUID=102831973239L;
   protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String flightId = request.getParameter("flightId");
		String departureDate = request.getParameter("departureDate");
        String departureAirport = request.getParameter("departureAirport");
		String destinationAirport= request.getParameter("destinationAirport");
		String departureTime=request.getParameter("departureTime");
		String arrivalTime=request.getParameter("arrivalTime");
		String economySeats=request.getParameter("economySeats");
		String businessSeats=request.getParameter("businessSeats");
		String economyPrice=request.getParameter("economyPrice");
		String businessPrice=request.getParameter("businessPrice");
	try {

           
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airlines","root","pinky@173");
            out.println("connected");
            PreparedStatement ps = con.prepareStatement("insert into addflight values(?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1,flightId);
			ps.setString(2,departureDate);
            ps.setString(3,departureAirport);
			ps.setString(4,destinationAirport);
			ps.setString(5,departureTime);
			ps.setString(6,arrivalTime);
			ps.setString(7,economySeats);
			ps.setString(8,businessSeats);
			ps.setString(9,economyPrice);
			ps.setString(10,businessPrice);
           int x =ps.executeUpdate();
      if(x>=1)
        {
            RequestDispatcher rd = request.getRequestDispatcher("addflights.html");
            rd.forward(request, response);
        }
        else
        {
           out.println("Enter correct details");
           RequestDispatcher rd = request.getRequestDispatcher("user_register.html");
           rd.include(request, response);
        }
    }  
	catch(Exception e1) {
            e1.printStackTrace();
        }
	}
}