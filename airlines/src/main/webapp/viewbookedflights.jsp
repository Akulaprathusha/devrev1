<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
    <title>View All Bookings</title>
    <style>
    body{
    background: url('images/airlines_viewbookedflights.jpg');
    width: 100%;
    height: 100vh;
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    display: flex;
    justify-content: center;
    align-items: center;
  }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .bottom-button {
  position: fixed;
  bottom: 100px;
  right: 100px;
}

.bottom-button button {
  padding: 10px 20px;
  background-color: #0099cc;
  color: black;
  border: none;
  border-radius: 4px;
  font-weight: bold;
  cursor: pointer;
}
    </style>
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
            
        </tr>
        <% 
        // Retrieve the session object to get the username of the logged-in user
       
        String username = (String) session.getAttribute("username");

        // Establish a database connection
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/airlines", "root", "pinky@173");

            // Execute the query to fetch the rows from the booking table
            String query = "SELECT * FROM booking WHERE username=?";
            statement = connection.prepareStatement(query);
            statement.setString(1, username);
            rs = statement.executeQuery();

            while (rs.next()) {
                String flightId = rs.getString("flightId");
                
                // Retrieve the corresponding flight details from the airflight table
                String query1 = "SELECT * FROM addflight WHERE flightId=?";
                PreparedStatement stat = connection.prepareStatement(query1);
                stat.setString(1, flightId);
                ResultSet r = stat.executeQuery();
                
                if (r.next()) {
                    String departureDate = r.getString("departureDate");
                    String departureAirport = r.getString("departureAirport");
                    String destinationAirport = r.getString("destinationAirport");
                    String departureTime = r.getString("departureTime");
                    String arrivalTime = r.getString("arrivalTime");
                   
        %>
        <tr>
            <td><%= flightId %></td>
            <td><%= departureDate %></td>
            <td><%= departureAirport %></td>
            <td><%= destinationAirport %></td>
            <td><%= departureTime %></td>
            <td><%= arrivalTime %></td>
           
        </tr>
        <%          
                }
                r.close();
                stat.close();
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the database resources
            try {
                if (rs != null) rs.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        %>
            
        
    </table>
    <div class="bottom-button">
    <button type="button" onclick="location.href='homepage.html'">Logout</button>
  </div>
</body>
</html>