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
            <th>Delete Flight</th>
        </tr>
        
        <% 
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airlines", "root", "pinky@173");
            
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM addflight");
            
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
                   
                    <td> <a href="admin_deleteflight.jsp?flightId=<%=rs.getString("flightId") %>">
                    <button   class="delete-button"  >Delete</button></a></td>
                    
                </tr>
                <%
            }
            
            rs.close();
            stmt.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        %>
    </table>
   
</body>
</html>