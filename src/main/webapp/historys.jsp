<%@ page import="org.zerobase.service.SelectDB" %>
<%@ page import="org.zerobase.dto.Historys" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>위치 히스토리 목록</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>
<body>
<h1>위치 히스토리 목록</h1>
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

<table id = "history_table">
        <tr>
            <th>ID</th>
            <th>X좌표</th>
            <th>Y좌표</th>
            <th>조회일자</th>
            <th>비고</th>
        </tr>

        <%
            SelectDB selectDB = new SelectDB();
            selectDB.connect();
            List<Historys> historysList = selectDB.selectHistorysData();
            if (historysList.isEmpty()) {
                out.write("<tr><td colspan=\"100%\">히스토리가 없습니다.</td></tr>");
            } else {
                for (Historys ele : historysList) {
                    out.write("<tr id=" + ele.getId() + ">");
                    out.write("<td>" + ele.getId() + "</td>");
                    out.write("<td>" + ele.getXPos() + "</td>");
                    out.write("<td>" + ele.getYPos() + "</td>");
                    out.write("<td>" + ele.getCheckDate() + "</td>");
                    out.write("<td style=\"text-align:center;\">" + "<button onclick=\"deleteHistory(this)\">삭제</button>" + "</td>");
                    out.write("</tr>");
                }
            }
            selectDB.disconnect();
        %>

</table>
<script>
    function deleteHistory(btn) {

        var row = btn.parentNode.parentNode; // 버튼이 속한 행 가져오기
        const rowId = row.id;
        row.parentNode.removeChild(row); // 행 삭제

        $.ajax({
            type: "POST", // 또는 "GET" 등 원하는 HTTP 메소드를 사용할 수 있습니다.
            url: "./JavaExecute/deleteHistorysDB.jsp", // Java 코드를 실행할 JSP 파일의 경로
            data: {id: rowId},
            success: function () {
                console.log("히스토리 삭제 완료 :" + rowId);
            },
            error: function (xhr, status, error) {
                // 오류 처리
                alert("오류 발생: " + error);
            }
        });

        if (document.getElementById("history_table").getElementsByTagName("tr").length === 1) {
            const row = document.getElementById("history_table").insertRow();
            const td = row.insertCell(0);
            td.colSpan = 100;
            td.innerText = "히스토리가 없습니다.";
            td.style.textAlign = "center";
        }

    }
</script>
</body>
</html>
