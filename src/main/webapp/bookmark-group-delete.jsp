<%@ page import="org.zerobase.service.SelectDB" %>
<%@ page import="org.zerobase.dto.BookMarkGroup" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>북마크 그룹 삭제</title>
    <link rel="stylesheet" href="css/styleEditTable.css" type="text/css">
</head>
<body>
<h1>북마크 그룹 삭제</h1>
<p>
    <a href="./">홈</a>
    |
    <a href="./historys.jsp">위치 히스토리 목록</a>
    |
    <a href="./load-wifi.jsp">OpenAPI 와이파이 정보 가져오기</a>
    |
    <a href="./bookmark-list.jsp">북마크 보기</a>
    |
    <a href="./bookmark-group.jsp">북마크 그룹 관리</a>
</p>
<p>북마크 그룹 이름을 삭제하시겠습니까?</p>
<table>
    <tr>
        <th>북마크 그룹 이름</th>
        <td><input type="text" id="groupName" value=""></td>
    </tr>
    <tr>
        <th>순서</th>
        <td><input type="text" id="orders" value=""></td>
    </tr>
    <tr>
        <td colspan="100" style="text-align: center"><a href='#' onClick=history.back()>돌아가기</a> | <input type="button" value="삭제" onclick="deleteBookMarkGroup()"></td>
    </tr>
</table>
<%
    String query = request.getQueryString();
    int id = Integer.parseInt(query.split("=")[1]);

    SelectDB selectDB = new SelectDB();
    selectDB.connect();
    BookMarkGroup bookMarkGroup = selectDB.selectOneBookMarkGroupData(id);
    selectDB.disconnect();
    out.write(String.format("<script>" +
            "document.getElementById('groupName').value = '%s';" +
            "\n" +
            "document.getElementById('orders').value = '%d';" +
            "</script>", bookMarkGroup.getBookmarkGroupName(), bookMarkGroup.getOrders()));
%>
<script>
    function deleteBookMarkGroup() {
        const queryString = window.location.search;
        const id = queryString.split("=")[1]
        $.ajax({
            type: "POST", // 또는 "GET" 등 원하는 HTTP 메소드를 사용할 수 있습니다.
            url: "./JavaExecute/deleteBookMarkGroupDB.jsp", // Java 코드를 실행할 JSP 파일의 경로
            data: { id:id},
            success: function() {
                location.href='./bookmark-group-delete-submit.jsp';
            },
            error: function(xhr, status, error) {
                // 오류 처리
                alert("오류 발생: " + error);
            }
        });


    }
</script>

</body>
</html>
