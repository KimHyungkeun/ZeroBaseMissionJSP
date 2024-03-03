<%@ page import="org.zerobase.dto.MainHome" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="org.zerobase.service.SelectDB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    String lat = request.getParameter("lat");
    String lnt = request.getParameter("lnt");

    // Java 코드 실행
    SelectDB selectDB = new SelectDB();
    selectDB.connect();
    List<MainHome> mainHome = selectDB.selectMainHomeData(lat, lnt);
    selectDB.disconnect();

    Gson gson = new Gson();
    // 결과를 클라이언트로 보냄
    out.write(gson.toJson(mainHome));

%>