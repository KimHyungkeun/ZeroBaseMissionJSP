<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>와이파이 정보 구하기</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>
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

<p>
    LAT : <input type="text" id="lat" name="lat" value=0.0>
    LNT : <input type="text" id="lnt" name="lnt" value=0.0>
    <input type="button" value="내 위치 정보 가져오기" onclick="getPos()">
    <input type="button" value="근처 WiFi 정보 보기" onclick="getNearWifi()">
</p>

<table id="main_table">
    <tr id = "col">
        <th>거리(Km)</th>
        <th>관리번호</th>
        <th>자치구</th>
        <th>와이파이명</th>
        <th>도로명주소</th>
        <th>상세주소</th>
        <th>설치위치(층)</th>
        <th>설치유형</th>
        <th>설치기관</th>
        <th>서비스구분</th>
        <th>망종류</th>
        <th>설치년도</th>
        <th>실내외구분</th>
        <th>WiFi 접속환경</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>작업일자</th>
    </tr>
    <tr id = "foot">
        <td colspan="100%">위치 정보를 입력한 후에 조회해 주세요.</td>
    </tr>
</table>

<script>
    
    function getNearWifi() {
        $.ajax({
            type: "GET", // 또는 "GET" 등 원하는 HTTP 메소드를 사용할 수 있습니다.
            url: "./JavaExecute/selectMainHomeDB.jsp", // Java 코드를 실행할 JSP 파일의 경로
            data: { lat: document.getElementById("lat").value, lnt:document.getElementById("lnt").value },
            success: function(response) {
                const table = document.getElementById('main_table');
                table.deleteRow(1);

                // Java 코드 실행 결과를 처리
                const objArr = JSON.parse(response);
                for(var element of objArr) {
                    const newRow = table.insertRow();

                    // 테이블 각각 열 정의
                    const distance = newRow.insertCell(0);
                    const xSwifiMgrNo = newRow.insertCell(1);
                    const xSwifiWrdofc = newRow.insertCell(2);
                    const xSwifiMainNm = newRow.insertCell(3);
                    const xSwifiAdres1 = newRow.insertCell(4);
                    const xSwifiAdres2 = newRow.insertCell(5);
                    const xSwifiInstlFloor = newRow.insertCell(6);
                    const xSwifiInstlTy = newRow.insertCell(7);
                    const xSwifiInstlMby = newRow.insertCell(8);
                    const xSwifiSvcSe = newRow.insertCell(9);
                    const xSwifiCmcwr = newRow.insertCell(10);
                    const xSwifiCnstcYear = newRow.insertCell(11);
                    const xSwifiInoutDoor = newRow.insertCell(12);
                    const xSwifiRemars3 = newRow.insertCell(13);
                    const lat = newRow.insertCell(14);
                    const lnt = newRow.insertCell(15);
                    const workDttm = newRow.insertCell(16);

                    distance.innerText = element.distance;
                    xSwifiMgrNo.innerText = element.xSwifiMgrNo;
                    xSwifiWrdofc.innerText = element.xSwifiWrdofc;

                    xSwifiMainNm.innerText = element.xSwifiMainNm;
                    xSwifiMainNm.style = "cursor:pointer;color:blue;text-decoration: underline;";
                    xSwifiMainNm.addEventListener("click", function() {

                        const form = document.createElement('form');
                        form.setAttribute('method', 'post'); // 전송 방식 결정 (get or post)
                        form.setAttribute('action', "./detail.jsp?mgrNo=" + xSwifiMgrNo.innerText); // 전송할 url 지정

                        const data1 = document.createElement('input'); // input 태그 생성
                        data1.setAttribute('type', 'hidden'); // type = hidden
                        data1.setAttribute('name', 'lat'); // 데이터의 key
                        data1.setAttribute('value', document.getElementById("lat").value ); // 데이터의 value (여기서는 data)
                        form.appendChild(data1);

                        const data2 = document.createElement('input'); // input 태그 생성
                        data2.setAttribute('type', 'hidden'); // type = hidden
                        data2.setAttribute('name', 'lnt'); // 데이터의 key
                        data2.setAttribute('value', document.getElementById("lnt").value ); // 데이터의 value (여기서는 data)
                        form.appendChild(data2);

                        document.body.appendChild(form);
                        form.submit();

                    });

                    xSwifiAdres1.innerText = element.xSwifiAdres1;
                    xSwifiAdres2.innerText = element.xSwifiAdres2;
                    xSwifiInstlFloor.innerText = element.xSwifiInstlFloor;
                    xSwifiInstlTy.innerText = element.xSwifiInstlTy;
                    xSwifiInstlMby.innerText = element.xSwifiInstlMby;
                    xSwifiSvcSe.innerText = element.xSwifiSvcSe;
                    xSwifiCmcwr.innerText = element.xSwifiCmcwr;
                    xSwifiCnstcYear.innerText = element.xSwifiCnstcYear;
                    xSwifiInoutDoor.innerText = element.xSwifiInoutDoor;
                    xSwifiRemars3.innerText = element.xSwifiRemars3;
                    lat.innerText = element.lat;
                    lnt.innerText = element.lnt;
                    workDttm.innerText = element.workDttm;

                }
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