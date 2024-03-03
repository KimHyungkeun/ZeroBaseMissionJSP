<%@ page import="org.zerobase.service.SelectDB" %>
<%@ page import="org.zerobase.dto.MainHome" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>와이파이 정보 구하기</title>
</head>
<style>
    table, th, td {
        border: 1px solid;
    }
    table {
        width: 50%;
    }
</style>
    <body>
        <h1>와이파이 정보 구하기</h1>
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
            request.setCharacterEncoding("utf-8");
            String mgrNo = URLDecoder.decode(request.getQueryString().split("=")[1], "UTF-8");
            String distance = request.getParameter("distance");

            SelectDB selectDB = new SelectDB();
            selectDB.connect();

            out.write("<select name=\"bookMarkGroup\" id=\"bookMarkGroup\">");
            out.write("<option value=\"\">북마크 그룹 이름 선택</option>");

            Map<Integer, String> groupNameList = selectDB.selectBookMarkGroupNameList();
            MainHome mainHome = selectDB.selectOneWiFiInfo(mgrNo);
            for (Map.Entry<Integer, String> map : groupNameList.entrySet()) {
                out.write(String.format("<option id=%d value=\"%s\">%s</option>", map.getKey(), map.getValue(), map.getValue()));
            };
            selectDB.disconnect();

            out.write("</select>");
            out.write(String.format("<input type=\"button\" onClick=\"insertBookMark('%s', '%s')\" value=\"북마크 추가하기\">", mainHome.getXSwifiMgrNo(), mainHome.getXSwifiMainNm()));

            out.write(String.format("<table>\n" +
                    "            <thead>\n" +
                    "            <tr><th>거리(Km)</th><th>%s</th></tr>\n" +
                    "            <tr><th>관리번호</th><th>%s</th></tr>\n" +
                    "            <tr><th>자치구</th><th>%s</th></tr>\n" +
                    "            <tr><th>와이파이명</th><th>%s</th></tr>\n" +
                    "            <tr><th>도로명주소</th><th>%s</th></tr>\n" +
                    "            <tr><th>상세주소</th><th>%s</th></tr>\n" +
                    "            <tr><th>설치위치(층)</th><th>%s</th></tr>\n" +
                    "            <tr><th>설치유형</th><th>%s</th></tr>\n" +
                    "            <tr><th>설치기관</th><th>%s</th></tr>\n" +
                    "            <tr><th>서비스구분</th><th>%s</th></tr>\n" +
                    "            <tr><th>망종류</th><th>%s</th></tr>\n" +
                    "            <tr><th>설치년도</th><th>%s</th></tr>\n" +
                    "            <tr><th>실내외구분</th><th>%s</th></tr>\n" +
                    "            <tr><th>WiFi 접속환경</th>%s<th></th></tr>\n" +
                    "            <tr><th>X좌표</th><th>%f</th></tr>\n" +
                    "            <tr><th>Y좌표</th><th>%f</th></tr>\n" +
                    "            <tr><th>작업일자</th><th>%s</th></tr>\n" +
                    "            </thead>\n" +
                    "        </table>", distance,
                    mainHome.getXSwifiMgrNo(),
                    mainHome.getXSwifiWrdofc(),
                    mainHome.getXSwifiMainNm(),
                    mainHome.getXSwifiAdres1(),
                    mainHome.getXSwifiAdres2(),
                    mainHome.getXSwifiInstlFloor(),
                    mainHome.getXSwifiInstlTy(),
                    mainHome.getXSwifiInstlMby(),
                    mainHome.getXSwifiSvcSe(),
                    mainHome.getXSwifiCmcwr(),
                    mainHome.getXSwifiCnstcYear(),
                    mainHome.getXSwifiInoutDoor(),
                    mainHome.getXSwifiRemars3(),
                    mainHome.getLat(),
                    mainHome.getLnt(),
                    mainHome.getWorkDttm()));
        %>
    <script>
        function insertBookMark(wifiMgrNo, wifiName){
            const bookmarkGroup  = document.getElementById("bookMarkGroup");
            const bookmarkGroupId  = bookmarkGroup.options[bookmarkGroup.selectedIndex].id;
            const bookmarkGroupName = bookmarkGroup.value;

            $.ajax({
                type: "POST", // 또는 "GET" 등 원하는 HTTP 메소드를 사용할 수 있습니다.
                url: "./JavaExecute/insertBookMarkDB.jsp", // Java 코드를 실행할 JSP 파일의 경로
                data: {bookmarkGroupId: bookmarkGroupId,
                bookmarkGroupName: bookmarkGroupName,
                wifiMgrNo:wifiMgrNo,
                wifiName:wifiName},
                success: function(response) {
                    location.href='./bookmark-add-submit.jsp';
                },
                error: function(xhr, status, error) {
                    // 오류 처리
                    alert("오류 발생: " + error);
                }
            })
        }
    </script>

    </body>
</html>
