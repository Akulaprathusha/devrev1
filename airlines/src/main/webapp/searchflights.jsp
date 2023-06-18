<%@page import="java.sql.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
    
    <link rel="stylesheet" type="text/css" href="viewallflightsstyle.css">
</head>
<body>
    
    <table>
        <tr>
            <th>Flight Id</th>
            <th>Departure Date</th>
            <th>Departure Airport</th>
            <th>Destination Airport</th>
            <th>Departure Time</th>
            <th>Arrival Time</th>
            <th>Economy Seats</th>
            <th>Business Seats</th>
            <th>Economy Price</th>
            <th>Business Price</th>
            
            <th>Book Flight</th>
        </tr>
        
        <% 
        
        String from=request.getParameter("from");
        String to=request.getParameter("to");
        String depart=request.getParameter("depart");
        String classType=request.getParameter("classType");
        String seats=request.getParameter("seats");
        
        try {
        	Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/airlines","root","pinky@173");
            
            // Prepare and execute the query
            String query = "SELECT * FROM addflight WHERE departureAirport=? AND destinationAirport=? AND departureDate=?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, from);
            statement.setString(2, to);
            statement.setString(3, depart);
            //
           
            ResultSet rs= statement.executeQuery();
            while (rs.next()) {
                String flightId = rs.getString("flightId");
                String departureDate = rs.getString("departureDate");
                String departureAirport = rs.getString("departureAirport");
                String destinationAirport = rs.getString("destinationAirport");
               // Date date = rs.getDate("date");
                String departureTime = rs.getString("departureTime");
                String arrivalTime = rs.getString("arrivalTime");
                String economySeats = rs.getString("economySeats");
                String businessSeats = rs.getString("businessSeats");
                String economyPrice = rs.getString("economyPrice");
                String businessPrice = rs.getString("businessPrice");
                
     %>           
                <tr>
                    <td><%= flightId %></td>
                    <td><%= departureDate %></td>
                    <td><%= departureAirport %></td>
                    <td><%= destinationAirport %></td>
                    <td><%=departureTime %></td>
                    <td><%=arrivalTime %></td>
                    <td><%=economySeats %></td>
                    <td><%=businessSeats %></td>
                     <td><%=economyPrice %></td>
                     <td><%=businessPrice %></td>
                    
                  <!--   <td> <button> <a href="bookflight.jsp?classType=<%= classType %>&seats=<%= seats %>>  class="delete-button"  >Book flight   </a></button></td>
                    -->
                   <td>
                     <a href="bookflight.jsp?classType=<%= classType %>&seats=<%= seats %>">
                    <button class="delete-button">Book Flight</button>
                     </a>
                     </td>
                </tr>
               <% 
            
            }   
            rs.close();
            connection.close();
        }
            catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        %>
        
    </table>
   
</body>
</html>