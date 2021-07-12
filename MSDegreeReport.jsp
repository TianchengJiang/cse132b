
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

                    ResultSet rs1 = statement1.executeQuery("with taken as (Select c.id, c.course_id, le.units from class c, learning le where le.student_SSN = " + request.getParameter("SSN") + " and exists(select s.id, s.class from section s where le.section_id = s.id and s.class = c.id)) Select m.concentration_name from MS_Degree m where exists(select * from degree where id = m.degree_id and name = '" + request.getParameter("degree_name") + "' ) and not exists(select * from MS_concentration c where c.concentration_name = m.concentration_name and not exists(select * from taken where course_id = c.course_id))");



                    Statement statement2 = conn.createStatement();
                    ResultSet rs2 = statement2.executeQuery("with taken as (Select c.id, c.course_id, le.units from class c, learning le where le.student_SSN = " + request.getParameter("SSN") + " and exists(select s.id, s.class from section s where le.section_id = s.id and s.class = c.id)) Select co.id, c.concentration_name from course co, MS_concentration c where c.course_id = co.id and exists (select * from MS_degree m INNER JOIN degree d on m.degree_id = d.id  where m.concentration_name = c.concentration_name and d.name = '" + request.getParameter("degree_name") + "')  and not exists(select * from taken t where t.course_id = c.course_id) order by concentration_name;");
                    

                

                    Statement statement3 = conn.createStatement();
                    ResultSet rs3 = statement3.executeQuery("with taken as (Select c.id, c.course_id, le.units, le.gpa from class c, learning le where le.student_SSN = " + request.getParameter("SSN") + " and exists(select s.id, s.class from section s where le.section_id = s.id and s.class = c.id)), concentration_Y as (Select m.concentration_name from MS_Degree m where exists(select * from degree where id = m.degree_id and name = '" + request.getParameter("degree_name") + "')) Select sum(t.units) as total_units, sum(t.gpa * t.units) / sum(t.units) as gpa, c.concentration_name from taken t, concentration_Y c where exists(select * from MS_concentration where concentration_name = c.concentration_name and course_id = t.id) Group by  c.concentration_name;");
                    


                    conn.commit();
                    conn.setAutoCommit(true);


            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>CONCENTRATION_NAME</th>
                    </tr>
                  

            <%

                while (rs1.next()) {

            %>


                    <tr>
                        <th><input value="<%= rs1.getString("concentration_name") %>" name="concentration_name" size="10" readonly></th>
                    </tr>

            <%
               } 
            %>
        
                <tr>
                    <th>COURSE_ID</th>
                    <th>CONCENTRATION_NAME</th>
                </tr>
                

            <%
                while (rs2.next()) {
            %>


                <tr>
                    <th><input value="<%= rs2.getString("id") %>" name="id" size="10" readonly></th>
                    <th><input value="<%= rs2.getString("concentration_name") %>" name="concentration_name" size="10" readonly></th>
                </tr>


            <%
                }
            %>

                <tr>
                    <th>CONCENTRATION_NAME</th>
                    <th>TOTAL_UNITS</th>
                    <th>GPA</th>
                </tr>

            <%
                while (rs3.next()) {
            %>

                <tr>
                    <th><input value="<%= rs3.getString("concentration_name") %>" name="concentration_name" size="10" readonly></th>
                    <th><input value="<%= rs3.getString("total_units") %>" name="total_units" size="10" readonly></th>
                    <th><input value="<%= rs3.getString("gpa") %>" name="gpa" size="10" readonly></th>
                </tr>

            <%
                }
            %>
                </table>

            <%-- -------- Close Connection Code -------- --%>
            <%


                    rs1.close();
                    rs2.close();
                    rs3.close();

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