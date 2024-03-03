<%@ page import="org.zerobase.service.DeleteDB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    int id = Integer.parseInt(request.getParameter("id"));

    DeleteDB deleteDB = new DeleteDB();
    deleteDB.connect();
    deleteDB.deleteBookMarkGroupData(id);
    deleteDB.disconnect();

%>