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

            <form action="MSDegreeInfo.jsp" method="get">
                <select name="SSN">

            <%

                Statement statement1 = conn.createStatement();
                ResultSet rs1 = statement1.executeQuery("Select ssn from student where enrolled = 'YES' and isgraduate = 'YES'");



                while(rs1.next()) {


            %>


                <option value="<%= rs1.getInt("SSN") %>"><%= rs1.getInt("SSN") %></option>
            <%
                }
            %>
                </select>


                <select name="degree_name">

            <%

                Statement statement2 = conn.createStatement();
                ResultSet rs2 = statement2.executeQuery("Select name from degree where IS_MS = 'YES'");




                while(rs2.next()) {


            %>
                <option value="<%= rs2.getString("name") %>"><%= rs2.getString("name") %></option>
            <%
                }
            %>

                <th><input type="submit" value="Unfold"></th>
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
                        ResultSet rs = pstmt.executeQuery();


                    

            %>

            <!-- Add an HTML table header row to format the results -->

                <table border="1">
                    <tr>
                        <th>SSN</th>
                        <th>FIRSTNAME</th>
                        <th>MIDDLENAME</th>
                        <th>LASTNAME</th>
                        <th>DEGREENAME</th>

                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while (rs.next()) {
        
            %>

                    <tr>
                        <form action="MSDegreeReport.jsp" method="get">
                            <th><input value="<%= rs.getInt("SSN") %>" name="SSN" size="10" readonly></th>
                            <th><input value="<%= rs.getString("FIRSTNAME") %>" name="FIRSTNAME" size="10" readonly></th>
                            <th><input value="<%= rs.getString("MIDDLENAME") %>" name="MIDDLENAME" size="10" readonly></th>
                            <th><input value="<%= rs.getString("LASTNAME") %>" name="LASTNAME" size="10" readonly></th>
                            <th><input value="<%= request.getParameter("degree_name") %>" name="degree_name" size="10" readonly></th>
                            
                            
                            <%-- Button --%>
                            <td><input type="submit" value="Degree Report"></td>
                        </form>
                    </tr>
            <%
                    }
                    rs.close();
                    pstmt.close();
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