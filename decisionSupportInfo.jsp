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

            <form action="decisionSupportReport.jsp" method="get">
                <select name="quarter">
                    <option value = "Any">Any</option>

            <%

                Statement statement1 = conn.createStatement();
                ResultSet rs1 = statement1.executeQuery("Select quarter from class");



                while(rs1.next()) {


            %>
                <option value="<%= rs1.getString("quarter") %>"><%= rs1.getString("quarter") %></option>
            <%
                }
            %>
                </select>


                <select name="course_id">

            <%

                Statement statement2 = conn.createStatement();
                ResultSet rs2 = statement2.executeQuery("Select course_id from class");




                while(rs2.next()) {


            %>
                <option value="<%= rs2.getString("course_id") %>"><%= rs2.getString("course_id") %></option>
            <%
                }
            %>
                </select>

                <select name="faculty">
                    <option value = "Any">Any</option>


            <%
                Statement statement3 = conn.createStatement();
                ResultSet rs3 = statement3.executeQuery("Select name from faculty");  //没有加where name = “professor”因为前面定义：The word "professor" refers to any faculty member and not just those with TITLE equal to 'PROFESSOR'.


                while(rs3.next()) {
            %>

                <option value="<%= rs3.getString("name") %>"><%= rs3.getString("name") %></option>
            <%
                }
            %>
                </select>



                <th><input type="submit" value="decision support"></th>
            </form>
            <%-- -------- SELECT Statement Code -------- --%>

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
                </table>
            </td>
        </tr>
    </table>
</body>

</html>