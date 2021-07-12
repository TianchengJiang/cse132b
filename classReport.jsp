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
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
        
                    ResultSet rs = statement.executeQuery("With list as (select * from student INNER JOIN learning ON student.SSN = learning.student_SSN) Select * from list where exists (select s.id, s.class from section s where s.id = list.section_id and s.class = " + request.getParameter("CLASS_ID") + ")");



                    conn.commit();
                    conn.setAutoCommit(true);




            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th>ID</th>
                        <th>FIRSTNAME</th>
                        <th>MIDDLENAME</th>
                        <th>LASTNAME</th>
                        <th>ORIGIN</th>
                        <th>ENROLLED</th>
                        <th>ISPROBATION</th>
                        <th>ISGRADUATE</th>
                        <th>HASPREVIOUSDEGREE</th>


                        <th>UNITS</th>
                        <th>GRADING_OPTION</th>
                    </tr>
                  

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
            
                    while (rs.next()) {


        
            %>

                <tr>
                    <th><input value="<%= rs.getInt("SSN") %>" name="SSN" size="10" readonly></th>
                    <th><input value="<%= rs.getInt("ID") %>" name="ID" size="10" readonly></th>
                    <th><input value="<%= rs.getString("FIRSTNAME") %>" name="FIRSTNAME" size="10" readonly></th>
                    <th><input value="<%= rs.getString("MIDDLENAME") %>" name="MIDDLENAME" size="10" readonly></th>

                    <th><input value="<%= rs.getString("LASTNAME") %>" name="LASTNAME" size="10" readonly></th>
                    <th><input value="<%= rs.getString("ORIGIN") %>" name="ORIGIN" size="10" readonly></th>
                    <th><input value="<%= rs.getString("ENROLLED") %>" name="time_period" size="10" readonly></th> 
                    <th><input value="<%= rs.getString("ISPROBATION") %>" name="ISPROBATION" size="10" readonly></th>
                    <th><input value="<%= rs.getString("ISGRADUATE") %>" name="ISGRADUATE" size="10" readonly></th> 

                    <th><input value="<%= rs.getString("HASPREVIOUSDEGREE") %>" name="HASPREVIOUSDEGREE" size="10" readonly></th>
                    <th><input value="<%= rs.getString("UNITS") %>" name="UNITS" size="10" readonly></th>  
                    <th><input value="<%= rs.getString("GRADING_OPTION") %>" name="GRADING_OPTION" size="10" readonly></th>
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