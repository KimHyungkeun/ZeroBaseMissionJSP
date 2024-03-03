<%@ page import="org.zerobase.service.UpdateDB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    int id = Integer.parseInt(request.getParameter("id"));
    String groupName = request.getParameter("groupName");
    int orders = Integer.parseInt(request.getParameter("orders"));

    UpdateDB updateDB = new UpdateDB();
    updateDB.connect();
    updateDB.updateBookMarkGroupData(id, groupName, orders);
    updateDB.disconnect();

%>