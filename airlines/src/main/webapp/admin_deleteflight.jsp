<%@ page import="java.sql.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String flightId = request.getParameter("flightId");

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airlines", "root", "pinky@173");
    Statement st=con.createStatement();
   String ps = "DELETE FROM addflight WHERE flightId ="+flightId;
 int x= st.executeUpdate(ps);
  if(x>0){
	 
          response.sendRedirect("addflights.html");
      } else {
          response.sendRedirect("error.html");
      }
  con.close();
}
catch(Exception e){
	out.println("Error" +e.toString());
}
  

%>
</body>
</html>