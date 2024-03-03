<%@ page import="org.zerobase.service.InsertDB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    int bookMarkGroupId = Integer.parseInt(request.getParameter("bookmarkGroupId"));
    String bookMarkGroupName = request.getParameter("bookmarkGroupName");
    String wifiMgrNo = request.getParameter("wifiMgrNo");
    String wifiName = request.getParameter("wifiName");


    InsertDB insertDB = new InsertDB();
    insertDB.connect();
    insertDB.insertBookMarkData(bookMarkGroupId, bookMarkGroupName, wifiMgrNo, wifiName);
    insertDB.disconnect();

%>