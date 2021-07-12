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
                    String dbURL = "jdbc:postgresql://localhost:5432/cse132b?user=postgres&password=Tc0504%25";
                    Connection conn = DriverManager.getConnection(dbURL);

            %>

           

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    conn.setAutoCommit(false);
                    Statement statement1 = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.

                    ResultSet rs1 = statement1.executeQuery("with sec_id as(select * from learning where student_SSN = " + Integer.parseInt(request.getParameter("SSN")) + " and time_period = 'current')" +
                                            "Select * from class c where exists(select s.id, s.class, i.section_id from section s, sec_id i where c.id = s.class and s.id = i.section_id)");
                    Statement statement2 = conn.createStatement();
                  
                    ResultSet rs2 = statement2.executeQuery("Select * from learning where student_SSN = " + request.getParameter("SSN") + " and time_period = 'current' ");

                    



                    conn.commit();
                    conn.setAutoCommit(true);




            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>id</th>
                        <th>title</th>
                        <th>quarter</th>
                        <th>course_id</th>

                        <th>units</th>
                        <th>section_id</th>
                        <th>time_period</th>
                        <th>grading_option</th>
                        <th>grade</th>
                    </tr>
                  

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while (rs1.next() && rs2.next()) {
        
            %>

                <tr>
                    <th><input value="<%= rs1.getInt("id") %>" name="id" size="10" readonly></th>
                    <th><input value="<%= rs1.getString("title") %>" name="title" size="10" readonly></th>
                    <th><input value="<%= rs1.getString("quarter") %>" name="quarter" size="10" readonly></th>
                    <th><input value="<%= rs1.getInt("course_id") %>" name="course_id" size="10" readonly></th>

                    <th><input value="<%= rs2.getInt("units") %>" name="units" size="10" readonly></th>
                    <th><input value="<%= rs2.getInt("section_id") %>" name="section_id" size="10" readonly></th>
                    <th><input value="<%= rs2.getString("time_period") %>" name="time_period" size="10" readonly></th> 
                    <th><input value="<%= rs2.getString("grading_option") %>" name="grading_option" size="10" readonly></th>
                    <th><input value="<%= rs2.getString("grade") %>" name="grade" size="10" readonly></th>            
                </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs1.close();
                    rs2.close();
    
                    // Close the Statement
                    statement1.close();
                    statement2.close();
                    
    
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