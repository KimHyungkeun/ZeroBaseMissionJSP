<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.zerobase.service.InsertDB" %>
<html>
<head>
    <title>OpenAPI 와이파이 정보</title>
</head>
<body>
<p>
    <%
        InsertDB insertDB = new InsertDB();
        insertDB.connect();
        out.write("<h1 style=\"text-align:center; font-size:200%;\">" + insertDB.insertMainHomeData() + "개의 WiFi 정보를 정상적으로 저장하였습니다." + "</h1>");
        insertDB.disconnect();
    %>
</p>
<p style = text-align:center>
    <a href="./" >홈 으로 가기</a>
</p>
</body>
</html>