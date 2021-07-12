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

                    ResultSet rs1 = statement1.executeQuery("Select c.id, c.title, c.quarter, c.course_id, le.units, le.grade from class c, learning le where le.student_SSN = " + request.getParameter("SSN") + " and exists(select s.id, s.class from section s where le.section_id = s.id and s.class = c.id) order by c.quarter");


                    Statement statement2 = conn.createStatement();

                    ResultSet rs2 = statement2.executeQuery("Select c.quarter, sum(le.GPA * le.units) / sum(le.units) as gpa from class c, learning le where le.time_period = 'before' and le.student_SSN = " + request.getParameter("SSN") + " and exists(select s.id, s.class from section s where le.section_id = s.id and s.class = c.id) group by c.quarter");


                    Statement statement3 = conn.createStatement();

                    ResultSet rs3 = statement3.executeQuery("Select sum(le.GPA * le.units) / sum(le.units) as gpa from class c, learning le where le.time_period = 'before' and le.student_SSN = " + request.getParameter("SSN") + " and exists(select s.id, s.class from section s where le.section_id = s.id and s.class = c.id)");
  



                    conn.commit();
                    conn.setAutoCommit(true);




            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>CLASS_ID</th>
                        <th>TITLE</th>
                        <th>QUARTER</th>
                        <th>COURSE_ID</th>

                        <th>UNITS</th>
                        <th>GRADES</th>
                    </tr>
                  

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet1
        
                    while (rs1.next()) {
        
            %>

                <tr>
                    <th><input value="<%= rs1.getString("id") %>" name="class_id" size="10" readonly></th>
                    <th><input value="<%= rs1.getString("title") %>" name="title" size="10" readonly></th>
                    <th><input value="<%= rs1.getString("quarter") %>" name="quarter" size="10" readonly></th>
                    <th><input value="<%= rs1.getString("course_id") %>" name="course_id" size="10" readonly></th>

                    <th><input value="<%= rs1.getString("units") %>" name="units" size="10" readonly></th>
                    <th><input value="<%= rs1.getString("grade") %>" name="grade" size="10" readonly></th>  
                </tr>
            <%
                    }
            %>
                </table>

                <table border="1">
                    <tr>
                        <th>QUARTER</th>
                        <th>GPA</th>
                    </tr>

            <%
                    // Iterate over the ResultSet2
                while (rs2.next()) {
        
            %>


                <tr>
                    <th><input value="<%= rs2.getString("quarter") %>" name="quarter" size="10" readonly></th>
                    <th><input value="<%= rs2.getString("gpa") %>" name="GPA" size="10" readonly></th>
                </tr>


            <%
                }
            %>

                </table>


                <table border="1">
                    <tr>
                        <th>CUMULATIVE_GPA</th>
                    </tr>
            <%
                    // Iterate over the ResultSet2
                while (rs3.next()) {
        
            %>



                <tr>
                    <th><input value="<%= rs3.getString("GPA") %>" name="GPA" size="10" readonly></th>
                </tr>


            <%
                }
            %>

            </table>




            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs1.close();
                    rs2.close();
                    rs3.close();
    
                    // Close the Statement
                    statement1.close();
                    statement2.close();
                    statement3.close();
                    
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
            </td>
        </tr>
    </table>
</body>

</html>