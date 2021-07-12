<html>

<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    Class.forName("org.postgresql.Driver");
                    String dbURL = "jdbc:postgresql:cse132b?user=postgres&password=Tc0504%25";
                    Connection conn = DriverManager.getConnection(dbURL);

            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO learning VALUES (?, ?, ?, ?, ?, ?, ?)");

                        
			            pstmt.setInt(1, Integer.parseInt(request.getParameter("student_SSN")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
                        pstmt.setString(3, request.getParameter("time_period"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("units")));
                        pstmt.setString(5, request.getParameter("grading_option"));
                        pstmt.setString(6, request.getParameter("grade"));
                        pstmt.setDouble(7, Double.parseDouble(request.getParameter("gpa")));

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }

            %>
            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE learning SET time_period = ?, units = ?, grading_option = ?, grade = ?, gpa = ? WHERE student_SSN = ? AND section_id = ?");

                        pstmt.setString(1, request.getParameter("time_period"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("units")));
                        pstmt.setString(3, request.getParameter("grading_option"));
                        pstmt.setString(4, request.getParameter("grade"));
                        pstmt.setDouble(5, Double.parseDouble(request.getParameter("gpa")));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("student_SSN")));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("section_id")));
                        
                      
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>
            

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM learning WHERE section_id = ? AND student_SSN = ?");
                        
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("section_id")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("student_SSN")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM learning");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>student_SSN</th>
                        <th>section_id</th>
                        <th>time_period</th>
                        <th>units</th>
                        <th>grading_option</th>
                        <th>grade</th>
                        <th>gpa</th>>

                        
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="learning_records.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="student_SSN" size="15"></th>
                            <th><input value="" name="section_id" size="10"></th>

                            <th><input type="radio"  value="before"  name="time_period" size="15">before
                                <input type="radio"  value="current"  name="time_period" size="15">current</th>
                            
                            <th><input value="" name="units" size="10"></th>    
                            <th><input value="" name="grading_option" size="10"></th>
                            <th><input value="" name="grade" size="10"></th>    
                            <th><input value="" name="gpa" size="10"></th>  
                            
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="learning_records.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            
    
                            <%-- Get the SSN --%>
                            <td>
                                <input value="<%= rs.getInt("student_SSN") %>" 
                                    name="student_SSN" size="10">
                            </td>
    
                          

                            <%-- Get the section_id --%>
                            <td>
                                <input value="<%= rs.getInt("section_id") %>" 
                                    name="section_id" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("time_period") %>" 
                                    name="time_period" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getInt("units") %>" 
                                    name="units" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("grading_option") %>" 
                                    name="grading_option" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getString("grade") %>" 
                                    name="grade" size="15">
                            </td>

                            <td>
                                <input value="<%= rs.getDouble("gpa") %>" 
                                    name="gpa" size="15">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
    
                            
                        </form>
                        <form action="learning_records.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("student_SSN") %>" name="student_SSN">
                            <input type="hidden" 
                                value="<%= rs.getInt("section_id") %>" name="section_id">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
