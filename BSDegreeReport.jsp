
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
            <%@ page language="java" import="java.sql.*, java.lang.Math" %>
    
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
                    ResultSet rs = statement.executeQuery("with taken as (Select c.id, c.course_id, le.units, co.LD_UD, co.Elective from class c, learning le, course co where le.student_SSN = " + request.getParameter("SSN") + " and co.id = c.course_id and exists(select s.id, s.class from section s where le.section_id = s.id and s.class = c.id)) Select sum(units) from taken");

                    int taken_units = 0;    //If no classes taken, taken units would be 0;
                    while (rs.next()) {
                        taken_units = rs.getInt("sum");
                    }



                    rs.close();
                    statement.close();



                    statement = conn.createStatement();

                    rs = statement.executeQuery("Select total_units from degree where name = '" + request.getParameter("degree_name")+"'");


                    int total_units = 0;   
                    while (rs.next()) {
                        total_units = rs.getInt("total_units");
                    }

                    rs.close();
                    statement.close();




                    statement = conn.createStatement();
                    rs = statement.executeQuery("with taken as (Select c.id, c.course_id, le.units, co.LD_UD, co.Elective from class c, learning le, course co where le.student_SSN = " + request.getParameter("SSN") + " and co.id = c.course_id and exists(select s.id, s.class from section s where le.section_id = s.id and s.class = c.id)) Select sum(units) from taken where LD_UD = 'LD'");
                    
                     
                    int taken_LDunits = 0;
                    while (rs.next()) {
                        taken_LDunits = rs.getInt("sum");
                    }

                    rs.close();
                    statement.close();



                    statement = conn.createStatement();
                    rs = statement.executeQuery("Select ld_units from degree where name = '" + request.getParameter("degree_name")+"'");
                    

                    int total_LDunits = 0;
                    while (rs.next()) {
                        total_LDunits = rs.getInt("ld_units");
                    }

                    rs.close();
                    statement.close();


                    statement = conn.createStatement();
                    rs = statement.executeQuery("with taken as (Select c.id, c.course_id, le.units, co.LD_UD, co.Elective from class c, learning le, course co where le.student_SSN = " + request.getParameter("SSN") + " and co.id = c.course_id and exists(select s.id, s.class from section s where le.section_id = s.id and s.class = c.id)) Select sum(units) from taken where LD_UD = 'UD'");
                    

                    int taken_UDunits = 0;
                    while (rs.next()) {
                        taken_UDunits = rs.getInt("sum");
                    }

                    rs.close();
                    statement.close();



                    statement = conn.createStatement();
                    rs = statement.executeQuery("Select ud_units from degree where name = '" + request.getParameter("degree_name")+"'");
                    

                    int total_UDunits = 0;
                    while (rs.next()) {
                        total_UDunits = rs.getInt("ud_units");
                    }

                    rs.close();
                    statement.close();



                    statement = conn.createStatement();
                    rs = statement.executeQuery("with taken as (Select c.id, c.course_id, le.units, co.LD_UD, co.Elective from class c, learning le, course co where le.student_SSN = " + request.getParameter("SSN") + " and co.id = c.course_id and exists(select s.id, s.class from section s where le.section_id = s.id and s.class = c.id)) Select sum(units) from taken where Elective = 'YES'");
                    

                    int taken_electiveunits = 0;  
                    while (rs.next()) {
                        taken_electiveunits = rs.getInt("sum");
                    }

                    rs.close();
                    statement.close();


                    statement = conn.createStatement();
                    rs = statement.executeQuery("Select ud_units from degree where name = '" + request.getParameter("degree_name")+"'");
                    

                    int total_electiveunits = 0;
                    while (rs.next()) {
                        total_electiveunits = rs.getInt("ud_units");
                    }

                    rs.close();
                    statement.close();

                    //statement = conn.createStatement();
                    //statement.executeQuery("drop table taken");

                    statement.close();
  


                    conn.commit();
                    conn.setAutoCommit(true);


                    int res_units = Math.max(0, total_units - taken_units);
                    int res_LDunits = Math.max(0, total_LDunits - taken_LDunits);
                    int res_UDunits = Math.max(0, total_UDunits - taken_UDunits);
                    int res_electiveunits = Math.max(0, total_electiveunits - taken_electiveunits);



            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>RES_UNITS</th>
                        <th>RES_LD_UNITS</th>
                        <th>RES_UD_UNITS</th>
                        <th>RES_ELECTIVE_UNITS</th>
                    </tr>
                  

                    <tr>
                        <th><input value="<%= res_units %>" name="res_units" size="10" readonly></th>
                        <th><input value="<%= res_LDunits %>" name="res_LDunits" size="10" readonly></th>
                        <th><input value="<%= res_UDunits %>" name="res_UDunits" size="10" readonly></th>
                        <th><input value="<%= res_electiveunits %>" name="res_electiveunits" size="10" readonly></th>
                    </tr>
        
                </table>





            <%-- -------- Close Connection Code -------- --%>
            <%
                    
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