<%@ page import="org.zerobase.service.SelectDB" %>
<%@ page import="java.util.List" %>
<%@ page import="org.zerobase.dto.BookMarkList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>북마크 목록</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>
<body>
<h1>북마크 목록</h1>
<p>
    <a href="./">홈</a>
    |
    <a href="historys.jsp">위치 히스토리 목록</a>
    |
    <a href="./load-wifi.jsp">OpenAPI 와이파이 정보 가져오기</a>
    |
    <a href="./bookmark-list.jsp">북마크 보기</a>
    |
    <a href="./bookmark-group.jsp">북마크 그룹 관리</a>
</p>
<p><input type="button" value="북마크 그룹 이름 추가" onclick="location.href='./bookmark-group-add.jsp'"></p>
<%
    request.setCharacterEncoding("utf-8");

    // Java 코드 실행
    SelectDB selectDB = new SelectDB();
    selectDB.connect();
    List<BookMarkList> bookMarkList = selectDB.selectBookMarkListData();
    selectDB.disconnect();

    out.write("<table>");
    out.write("<tr>");
    out.write("<th>ID</th>");
    out.write("<th>북마크 이름</th>");
    out.write("<th>와이파이명</th>");
    out.write("<th>등록일자</th>");
    out.write("<th>비고</th>");
    out.write("</tr>");
    out.write("<tbody>");
    for (BookMarkList ele : bookMarkList) {
        out.write("<tr" + "id="+ele.getId() + ">");
        out.write("<td>" + ele.getId() + "</td>");
        out.write("<td>" + ele.getBookmarkGroupName() + "</td>");
        out.write("<td>" + ele.getWifiName() + "</td>");
        out.write("<td>" + ele.getRegisterDate() + "</td>");
        out.write(String.format("<td style=\"text-align:center;\"><a href=\"./bookmark-delete.jsp?id=%d\">삭제</a></td>", ele.getId(), ele.getId()));
        out.write("</tr>");
    }
    out.write("</table>");
%>
<script>

</script>
</body>
</html>
