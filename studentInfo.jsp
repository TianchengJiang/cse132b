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

            <form action="studentInfo.jsp" method="get">
                <select name="SSN">

            <%

                Statement statement = conn.createStatement();
                ResultSet rs = statement.executeQuery("Select ssn from student where enrolled = 'YES'");

                while(rs.next()) {


            %>


                <option value="<%= rs.getInt("SSN") %>"><%= rs.getInt("SSN") %></option>





            <%
                }



            %>


                </select>

                <th><input type="submit" value="Student Info"></th>
            </form>
            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement

                    if (request.getParameter("SSN") != null) {
                        PreparedStatement pstmt = conn.prepareStatement("Select SSN, FIRSTNAME, MIDDLENAME, LASTNAME from  student  where SSN = ?"); 
                        //将本学期入学的学生信息建成一张表格

                        // Use the created statement to SELECT
                        // the student attributes FROM the Student table.
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                        rs = pstmt.executeQuery();
                    

            %>

            <!-- Add an HTML table header row to format the results -->

                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th>FIRSTNAME</th>
                        <th>MIDDLENAME</th>
                        <th>LASTNAME</th>            
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while (rs.next()) {
        
            %>

                    <tr>
                        <form action="report.jsp" method="get">
                            <th><input value="<%= rs.getInt("SSN") %>" name="SSN" size="10" readonly></th>
                            <th><input value="<%= rs.getString("FIRSTNAME") %>" name="FIRSTNAME" size="10" readonly></th>
                            <th><input value="<%= rs.getString("MIDDLENAME") %>" name="MIDDLENAME" size="10" readonly></th>
                            <th><input value="<%= rs.getString("LASTNAME") %>" name="LASTNAME" size="10" readonly></th>
                            
                            
                            <%-- Button --%>
                            <td><input type="submit" value="Classes"></td>
                            <td><input type="submit" formaction="GradeReport.jsp" value="Grades" ></td>
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