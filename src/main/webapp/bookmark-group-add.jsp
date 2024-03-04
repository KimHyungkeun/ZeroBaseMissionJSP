<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>북마크 그룹 추가</title>
    <link rel="stylesheet" href="css/styleEditTable.css" type="text/css">
</head>

<body>
    <h1>북마크 그룹 추가</h1>
    <p>
        <a href="CRUD_PAGE">홈</a>
        |
        <a href="historys.jsp">위치 히스토리 목록</a>
        |
        <a href="./load-wifi.jsp">OpenAPI 와이파이 정보 가져오기</a>
        |
        <a href="./bookmark-list.jsp">북마크 보기</a>
        |
        <a href="./bookmark-group.jsp">북마크 그룹 관리</a>
    </p>
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
            <th><input type="button" value="추가" onclick="addGroupName()"></th>
        </tr>
    </table>
    <script>
        function addGroupName() {
            $.ajax({
                type: "POST", // 또는 "GET" 등 원하는 HTTP 메소드를 사용할 수 있습니다.
                url: "./JavaExecute/insertBookMarkGroupDB.jsp", // Java 코드를 실행할 JSP 파일의 경로
                data: { groupName: document.getElementById("groupName").value, orders: document.getElementById("orders").value },
                success: function() {
                    location.href='./bookmark-group-add-submit.jsp';
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
