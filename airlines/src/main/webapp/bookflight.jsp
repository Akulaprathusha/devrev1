<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Book Flight</title>
  <link rel="stylesheet" type="text/css" href="bookflightstyle.css">
</head>
<body>
  <% 
  String classType = request.getParameter("classType");
  String seats = request.getParameter("seats");
  String username = (String) session.getAttribute("username");
  

  try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/airlines", "root", "pinky@173");
       String query1="";
       String query2="";
       int updatedRows = 0; 
       String query3 = "insert into booking(username,flightId) values(?,?)";
       
      // Check seat availability
      if(classType.equals("economy")){
       query1 = "SELECT * FROM addflight WHERE  economySeats >= ?";
       query2 = "UPDATE addflight SET economySeats = economySeats - ? WHERE flightId = ?";
  }
       if(classType.equals("business")){
    	   query1 = "SELECT * FROM addflight WHERE  businessSeats >= ?"; 
    	   query2 = "UPDATE addflight SET businessSeats = businessSeats - ? WHERE flightId = ?";
      }
      PreparedStatement statement = connection.prepareStatement(query1);
      
      statement.setString(1, seats);
      ResultSet rs = statement.executeQuery();

      if (rs.next()) {
       
        
          PreparedStatement updateStatement = connection.prepareStatement(query2);
          updateStatement.setString(1, seats);
          updateStatement.setString(2, rs.getString("flightId"));
          updatedRows = updateStatement.executeUpdate();

          if (updatedRows > 0) {
             response.sendRedirect("successfullybooked.html");
              PreparedStatement ps = connection.prepareStatement(query3);
              ps.setString(1,username);
              ps.setString(2,rs.getString("flightId"));
              int x =ps.executeUpdate();
  
              
          } else {
              out.println("<p>Failed to update the available seats in the database.</p>");
          }
      }
 
     else {
          // No seats available for booking
          System.out.println("Sorry, no seats are available for booking.");
      }
     
      rs.close();
      connection.close();
  } catch (ClassNotFoundException | SQLException e) {
      e.printStackTrace();
  }
  %>
</body>
</html>