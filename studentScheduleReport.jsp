
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

                    //statement.executeQuery("Create table taken as Select c.id, c.course_id, le.units, co.LD_UD, co.Elective from class c, learning le, course co where le.student_SSN = 1 and co.id = c.course_id and exists(select s.id, s.class from section s where le.section_id = s.id and s.class = c.id)");

                    statement = conn.createStatement();
                    ResultSet rs = statement.executeQuery("With taken_m as( Select m.weekday, m.begintime, m.endtime from learning l, meeting m where l.student_SSN = " + request.getParameter("SSN") + " and l.time_period = 'current' and l.section_id = m.section_id), taken_r as( Select r.date, r.begintime, r.endtime from learning l, review r where l.student_SSN = " + request.getParameter("SSN") + " and l.time_period = 'current' and l.section_id = r.section_id) Select * from class c where exists (select s.id from section s, meeting m, taken_m t_m where s.class = c.id and m.section_id = s.id and m.weekday =  t_m.weekday and m.begintime = t_m.begintime)");

                    conn.commit();
                    conn.setAutoCommit(true);
            %>

            <!-- Add an HTML table header row to format the results -->




            
                <table border="1">
                    <tr>
                        <th>CLASS_TITLE</th>
                        <th>CLASS_ID</th>
                        <th>COURSE_ID</th>
                        <th>QUARTER</th>
                    </tr>
                  


            <%
                while (rs.next()) {
            %>
                    <tr>
                        <th><input value="<%= rs.getString("title") %>" name="class_title" size="10" readonly></th>
                        <th><input value="<%= rs.getString("id") %>" name="class_id" size="10" readonly></th>
                        <th><input value="<%= rs.getString("course_id") %>" name="course_id" size="10" readonly></th>
                        <th><input value="<%= rs.getString("quarter") %>" name="quarter" size="10" readonly></th>
                    </tr>
        
               

            <%
                }
            %>

                </table>





            <%-- -------- Close Connection Code -------- --%>
            <%
                    
                    rs.close();
                    statement.close();

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