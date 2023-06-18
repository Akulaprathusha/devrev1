import java.io.*;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class User_registration extends HttpServlet {
   private static final long serialVersionUID=102831973239L;
   protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String name = request.getParameter("name");
		String username = request.getParameter("username");
        String password = request.getParameter("password");
		String email= request.getParameter("email");
		String phoneno=request.getParameter("phoneno");
	try {

           
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airlines","root","pinky@173");
            out.println("connected");
            PreparedStatement ps = con.prepareStatement("insert into user values(?,?,?,?,?)");
            ps.setString(1,name);
			ps.setString(2,username);
            ps.setString(3,password);
			ps.setString(4,email);
			ps.setString(5,phoneno);
           int x =ps.executeUpdate();
      if(x>=1)
        {
            RequestDispatcher rd = request.getRequestDispatcher("user_login.html");
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