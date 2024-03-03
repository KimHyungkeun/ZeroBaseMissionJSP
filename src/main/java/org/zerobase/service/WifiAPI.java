package org.zerobase.service;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.json.JSONObject;
import org.zerobase.dto.MainHome;

import java.util.ArrayList;
import java.util.List;

public class WifiAPI {

    private static int ADD_ROW = 1000;
    public int getTotalWifiListNum () {
        JSONObject json = null;
        try {
            String firstURLforGetTotalSize = "http://openapi.seoul.go.kr:8088/sample/json/TbPublicWifiInfo/1/1/";
            OkHttpClient client = new OkHttpClient();
            Request request = new Request.Builder()
                    .url(firstURLforGetTotalSize)
                    .build(); //GET Request

            // 동기 처리시 execute함수 사용
            Response response = client.newCall(request).execute();

            String message = response.body().string();
            json = new JSONObject(message);


        } catch (Exception e){
            System.err.println(e.toString());
        }

        return json.getJSONObject("TbPublicWifiInfo").getInt("list_total_count");
    }

    public List<MainHome> getTotalWifiList () {
        List<MainHome> mainHomeList = new ArrayList<>();
        ManageString manageString = new ManageString();
        MainHome mainHome;
        try {
            OkHttpClient client = new OkHttpClient();
            JSONObject json = null;
            Request request = null;
            Response response = null;
            String requestURL = "";
            String message = "";

            int start = 1;
            int end = ADD_ROW ;

            int totalSize = getTotalWifiListNum();
            while (start <= totalSize) {
                requestURL = String.format("http://openapi.seoul.go.kr:8088/734a617a7968797531303750766d546d/json/TbPublicWifiInfo/%d/%d/",start, end);
                request = new Request.Builder()
                        .url(requestURL)
                        .build(); //GET Request

                // 동기 처리시 execute함수 사용
                response = client.newCall(request).execute();

                message = response.body().string();
                json = new JSONObject(message);

                for (Object jsonObject : json.getJSONObject("TbPublicWifiInfo").getJSONArray("row")) {

                    JSONObject jsonObj = (JSONObject) jsonObject;
                    mainHome = new MainHome();

                    mainHome.setXSwifiMgrNo(manageString.manageApostrophe(jsonObj.get("X_SWIFI_MGR_NO").toString()));
                    mainHome.setXSwifiWrdofc(manageString.manageApostrophe(jsonObj.get("X_SWIFI_WRDOFC").toString()));
                    mainHome.setXSwifiMainNm(manageString.manageApostrophe(jsonObj.get("X_SWIFI_MAIN_NM").toString()));
                    mainHome.setXSwifiAdres1(manageString.manageApostrophe(jsonObj.get("X_SWIFI_ADRES1").toString()));
                    mainHome.setXSwifiAdres2(manageString.manageApostrophe(jsonObj.get("X_SWIFI_ADRES2").toString()));

                    mainHome.setXSwifiInstlFloor(manageString.manageApostrophe(jsonObj.get("X_SWIFI_INSTL_FLOOR").toString()));
                    mainHome.setXSwifiInstlTy(manageString.manageApostrophe(jsonObj.get("X_SWIFI_INSTL_TY").toString()));
                    mainHome.setXSwifiInstlMby(manageString.manageApostrophe(jsonObj.get("X_SWIFI_INSTL_MBY").toString()));
                    mainHome.setXSwifiSvcSe(manageString.manageApostrophe(jsonObj.get("X_SWIFI_SVC_SE").toString()));
                    mainHome.setXSwifiCmcwr(manageString.manageApostrophe(jsonObj.get("X_SWIFI_CMCWR").toString()));

                    mainHome.setXSwifiCnstcYear(manageString.manageApostrophe(jsonObj.get("X_SWIFI_CNSTC_YEAR").toString()));
                    mainHome.setXSwifiInoutDoor(manageString.manageApostrophe(jsonObj.get("X_SWIFI_INOUT_DOOR").toString()));
                    mainHome.setXSwifiRemars3(manageString.manageApostrophe(jsonObj.get("X_SWIFI_REMARS3").toString()));
                    mainHome.setLat(Double.parseDouble(jsonObj.get("LAT").toString()));
                    mainHome.setLnt(Double.parseDouble(jsonObj.get("LNT").toString()));
                    mainHome.setWorkDttm(manageString.manageApostrophe(jsonObj.get("WORK_DTTM").toString()));

                    mainHomeList.add(mainHome);
                }

                start += ADD_ROW ;
                end += ADD_ROW ;

            }

        } catch (Exception e){
            System.err.println(e.toString());
        }

        return mainHomeList;
    }
}
