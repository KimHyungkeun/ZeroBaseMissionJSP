<%@ page import="org.zerobase.service.SelectDB" %>
<%@ page import="org.zerobase.dto.BookMarkGroup" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>북마크 그룹</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>
<body>
    <h1>북마크 그룹</h1>
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
        List<BookMarkGroup> bookMarkGroupList = selectDB.selectBookMarkGroupData();
        selectDB.disconnect();

        out.write("<table>");
        out.write("<tr>");
        out.write("<th>ID</th>");
        out.write("<th>북마크 이름</th>");
        out.write("<th>순서</th>");
        out.write("<th>등록일자</th>");
        out.write("<th>수정일자</th>");
        out.write("<th>비고</th>");
        out.write("</tr>");
        if (bookMarkGroupList.isEmpty()) {
            out.write("<tr><td colspan=\"100\">등록된 북마크 그룹명이 없습니다.</td></tr>");
        } else {
            for (BookMarkGroup ele : bookMarkGroupList) {
                out.write("<tr" + "id="+ele.getId() + ">");
                out.write("<td>" + ele.getId() + "</td>");
                out.write("<td>" + ele.getBookmarkGroupName() + "</td>");
                out.write("<td>" + ele.getOrders() + "</td>");
                out.write("<td>" + ele.getRegisterDate() + "</td>");
                if (ele.getUpdateDate() != null) {
                    out.write("<td>" + ele.getUpdateDate() + "</td>");
                } else {
                    out.write("<td></td>");
                }
                out.write(String.format("<td style=\"text-align:center;\"><a href=\"./bookmark-group-edit.jsp?id=%d\">수정</a> <a href=\"./bookmark-group-delete.jsp?id=%d\">삭제</a></td>", ele.getId(), ele.getId()));
                out.write("</tr>");
            }
        }

        out.write("</table>");
    %>
    <script>

    </script>
</body>
</html>
