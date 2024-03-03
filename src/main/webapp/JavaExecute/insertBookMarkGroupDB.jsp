<%@ page import="org.zerobase.service.InsertDB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    String groupName = request.getParameter("groupName");
    int orders = Integer.parseInt(request.getParameter("orders"));

    InsertDB insertDB = new InsertDB();
    insertDB.connect();
    insertDB.insertBookMarkGroupData(groupName, orders);
    insertDB.disconnect();

%>