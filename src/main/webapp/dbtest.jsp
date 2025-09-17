<%@ page import="java.sql.Connection" %>
<%@ page import="com.db.DBConnect" %>
<%
Connection conn = DBConnect.getConn();
if (conn != null) {
    out.println("✅ Database connected successfully!");
} else {
    out.println("❌ Database connection failed!");
}
%>
