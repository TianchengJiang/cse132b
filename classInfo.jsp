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

            <form action="classInfo.jsp" method="get">
                <select name="title">

            <%
                Statement statement = conn.createStatement();
                ResultSet rs = statement.executeQuery("Select distinct title from class");

                while(rs.next()) {


            %>
                <option value="<%= rs.getString("title") %>"><%= rs.getString("title") %></option>
            <%
                }
            %>


                </select>

                <th><input type="submit" value="Class Info"></th>
            </form>
            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement

                    if (request.getParameter("title") != null) {
                        PreparedStatement pstmt = conn.prepareStatement("Select id, title, course_id, quarter from  class  where title = ?"); 
                        //将本学期入学的学生信息建成一张表格

                        // Use the created statement to SELECT
                        // the student attributes FROM the Student table.
                        pstmt.setString(1, request.getParameter("title"));
                        rs = pstmt.executeQuery();
                    

            %>

            <!-- Add an HTML table header row to format the results -->

                <table border="1">
                    <tr>
                        <th>TITLE</th>
                        <th>CLASS_ID</th>
                        <th>COURSE_ID</th>
                        <th>QUARTER</th>            
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while (rs.next()) {
        
            %>

                    <tr>
                        <form action="classReport.jsp" method="get">
                            <th><input value="<%= rs.getString("TITLE") %>" name="TITLE" size="10" readonly></th>
                            <th><input value="<%= rs.getString("ID") %>" name="CLASS_ID" size="10" readonly></th>
                            <th><input value="<%= rs.getString("COURSE_ID") %>" name="COURSE_ID" size="10" readonly></th>
                            <th><input value="<%= rs.getString("QUARTER") %>" name="QUARTER" size="10" readonly></th>
                            
                            
                            
                            <%-- Button --%>
                            <td><input type="submit" value="Students"></td>
                        </form>
                    </tr>
            <%
                    }
                    pstmt.close();
                }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
    
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