<%@ page import="org.zerobase.service.SelectDB" %>
<%@ page import="java.util.List" %>
<%@ page import="org.zerobase.dto.BookMark" %>
<%@ page import="org.zerobase.dto.BookMark" %>
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
    <a href="./historys.jsp">위치 히스토리 목록</a>
    |
    <a href="./load-wifi.jsp">OpenAPI 와이파이 정보 가져오기</a>
    |
    <a href="./bookmark-list.jsp">북마크 보기</a>
    |
    <a href="./bookmark-group.jsp">북마크 그룹 관리</a>
</p>

<%
    request.setCharacterEncoding("utf-8");

    // Java 코드 실행
    SelectDB selectDB = new SelectDB();
    selectDB.connect();
    List<BookMark> bookMarkList = selectDB.selectBookMarkListData();
    selectDB.disconnect();

    out.write("<table>");
    out.write("<tr>");
    out.write("<th>ID</th>");
    out.write("<th>북마크 이름</th>");
    out.write("<th>와이파이명</th>");
    out.write("<th>등록일자</th>");
    out.write("<th>비고</th>");
    out.write("</tr>");

    if (bookMarkList.isEmpty()) {
        out.write("<tr><td colspan=\"100\">등록된 북마크가 없습니다.</td></tr>");
    } else {
        for (BookMark ele : bookMarkList) {
            out.write("<tr" + "id="+ele.getId() + ">");
            out.write("<td>" + ele.getId() + "</td>");
            out.write("<td>" + ele.getBookmarkGroupName() + "</td>");
            out.write(String.format("<td><a href='#' onClick=goUrl('%s')>%s</a></td>", ele.getWifiManagerNo(), ele.getWifiName()));
            out.write("<td>" + ele.getRegisterDate() + "</td>");
            out.write(String.format("<td style=\"text-align:center;\"><a href=\"./bookmark-delete.jsp?id=%d\">삭제</a></td>", ele.getId(), ele.getId()));
            out.write("</tr>");
        }
    }

    out.write("</table>");
%>
<script>
    function goUrl(wifiManagerNo) {
        navigator.geolocation.getCurrentPosition(function(pos) {
                const lat = pos.coords.latitude.toString();
                const lnt = pos.coords.longitude.toString();

                const form = document.createElement('form');
                form.setAttribute('method', 'post'); // 전송 방식 결정 (get or post)
                form.setAttribute('action', "./detail.jsp?mgrNo=" + wifiManagerNo); // 전송할 url 지정

                const data1 = document.createElement('input'); // input 태그 생성
                data1.setAttribute('type', 'hidden'); // type = hidden
                data1.setAttribute('name', 'lat'); // 데이터의 key
                data1.setAttribute('value', lat ); // 데이터의 value (여기서는 data)
                form.appendChild(data1);

                const data2 = document.createElement('input'); // input 태그 생성
                data2.setAttribute('type', 'hidden'); // type = hidden
                data2.setAttribute('name', 'lnt'); // 데이터의 key
                data2.setAttribute('value', lnt ); // 데이터의 value (여기서는 data)
                form.appendChild(data2);

                document.body.appendChild(form);
                form.submit();
            }
        );
    }
</script>
</body>
</html>
