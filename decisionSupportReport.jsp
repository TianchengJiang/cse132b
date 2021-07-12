
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
                Statement statement_avg = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.

                ResultSet rs = null;
                ResultSet rs_avg = null;
                if (!request.getParameter("quarter").equals("Any")) {
                    rs = statement.executeQuery("Select count(*), tmp.grade as grade from (learning INNER JOIN section on learning.section_id = section.id) as tmp where exists(select * from class c where tmp.class = c.id and c.course_id = " + request.getParameter("course_id") + " and c.quarter = '" + request.getParameter("quarter") + "') and tmp.faculty = '" + request.getParameter("faculty") + "' Group by tmp.grade");
                }


                if (request.getParameter("quarter").equals("Any") && !request.getParameter("faculty").equals("Any")) {
                    rs = statement.executeQuery("Select count(*), tmp.grade as grade from (learning INNER JOIN section on learning.section_id = section.id) as tmp where exists(select * from class c where tmp.class = c.id and c.course_id = " + request.getParameter("course_id") + ") and tmp.faculty = '" + request.getParameter("faculty") + "' Group by tmp.grade");
 
                    rs_avg = statement_avg.executeQuery("Select avg(tmp.gpa) as avg from (learning INNER JOIN section on learning.section_id = section.id) as tmp where exists(select * from class c where tmp.class = c.id and c.course_id = " + request.getParameter("course_id") + ") and tmp.faculty = '" +request.getParameter("faculty") + "'");
                }
                    

                
                if (request.getParameter("quarter").equals("Any") && request.getParameter("faculty").equals("Any")) {
                    rs = statement.executeQuery("Select count(*), tmp.grade as grade from (learning INNER JOIN section on learning.section_id = section.id) as tmp where exists(select * from class c where tmp.class = c.id and c.course_id = " + request.getParameter("course_id") +  ") Group by tmp.grade");
                }



                    


                conn.commit();
                conn.setAutoCommit(true);


            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>COUNT</th>
                        <th>GRADE</th>
                    </tr>
                  

            <%

                while (rs.next()) {

            %>


                    <tr>
                        <th><input value="<%= rs.getString("count") %>" name="count" size="10" readonly></th>
                        <th><input value="<%= rs.getString("grade") %>" name="grade" size="10" readonly></th>
                    </tr>

            <%
               } 

               if (request.getParameter("quarter").equals("Any") && !request.getParameter("faculty").equals("Any")) {
            %>
        
                <tr>
                    <th>AVG_GPA</th>
                </tr>
                

            <%
                while (rs_avg.next()) {
            %>
                <tr>
                    <th><input value="<%= rs_avg.getString("avg") %>" name="avg" size="10" readonly></th>    
                </tr>
            <%
                }
                    rs_avg.close();
                    statement_avg.close();
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