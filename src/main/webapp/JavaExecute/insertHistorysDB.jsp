<%@ page import="org.zerobase.service.InsertDB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    String lat = request.getParameter("lat");
    String lnt = request.getParameter("lnt");

    InsertDB insertDB = new InsertDB();
    insertDB.connect();
    insertDB.insertHistorysData(lat, lnt);
    insertDB.disconnect();

%>
