<%@ page import="org.zerobase.service.SelectDB" %>
<%@ page import="org.zerobase.dto.BookMarkList" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>북마크 삭제</title>
</head>
<style>
    table, th, td {
        border: 1px solid;
    }
    table {
        width: 100%;
    }
</style>
<body>
<h1>북마크 삭제</h1>
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

<%
    String query = request.getQueryString();
    int id = Integer.parseInt(query.split("=")[1]);

    SelectDB selectDB = new SelectDB();
    selectDB.connect();
    BookMarkList bookMarkList = selectDB.selectOneBookMarkListInfo(id);
    selectDB.disconnect();
    out.write(String.format("<table>\n" +
            "    <tr>\n" +
            "        <td>북마크 이름</td>\n" +
            "        <td><p>%s</p></td>\n" +
            "    </tr>\n" +
            "    <tr>\n" +
            "        <td>와이파이명</td>\n" +
            "        <td><p>%s</p></td>\n" +
            "    </tr>\n" +
            "    <tr>\n" +
            "        <td>등록일자</td>\n" +
            "        <td><p>%s</p></td>\n" +
            "    </tr>\n" +
            "    <tr>\n" +
            "        <td><a href=\"./bookmark-list.jsp\">돌아가기</a> | <input style=\"text-align: center;\" type=\"button\" value=\"삭제\" onclick=\"deleteBookMark()\"></td>\n" +
            "    </tr>\n" +
            "</table>", bookMarkList.getBookmarkGroupName(), bookMarkList.getWifiName(), bookMarkList.getRegisterDate()));
%>
<script>
    function deleteBookMark() {
        const queryString = window.location.search;
        const id = queryString.split("=")[1]
        $.ajax({
            type: "POST", // 또는 "GET" 등 원하는 HTTP 메소드를 사용할 수 있습니다.
            url: "./JavaExecute/deleteBookMarkDB.jsp", // Java 코드를 실행할 JSP 파일의 경로
            data: { id:id},
            success: function(response) {
                location.href='./bookmark-delete-submit.jsp';
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
