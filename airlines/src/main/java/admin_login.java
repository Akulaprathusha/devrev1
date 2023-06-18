import java.io.*;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class admin_login extends HttpServlet {
protected void doPost(HttpServletRequest request, HttpServletResponse response)throws
ServletException, IOException {
response.setContentType("text/html");
PrintWriter out = response.getWriter();
String name = request.getParameter("name");
String password = request.getParameter("password");
try {

Class.forName("com.mysql.jdbc.Driver");

Connection con =
DriverManager.getConnection("jdbc:mysql://localhost:3306/airlines","root","pinky@173");
PreparedStatement ps = con.prepareStatement("select name,password from admin where name=? and password=?"); 

ps.setString(1, name);
ps.setString(2, password);

ResultSet rs =ps.executeQuery();
boolean st = rs.next();
if(st)
{

RequestDispatcher rd = request.getRequestDispatcher("addflights.html");
rd.forward(request, response);
}
else
{
out.println("Username or Password incorrect");
RequestDispatcher rd = request.getRequestDispatcher("admin_login.html");
rd.include(request, response);
}
}
catch(Exception e) {
e.printStackTrace();
}
}
}