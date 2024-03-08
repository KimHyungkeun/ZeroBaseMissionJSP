package org.zerobase.service;

import org.zerobase.dto.BookMark;
import org.zerobase.dto.BookMarkGroup;
import org.zerobase.dto.Historys;
import org.zerobase.dto.MainHome;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class SelectDB extends MariaDBConnector{

    private static int TOTAL_ROW = 20;

    public SelectDB() {
        super();
    }

    public boolean selectIsMainHomeExist (String id, String name, Statement stmt) {
        String selectSQL = String.format("SELECT count(1) FROM %s WHERE x_swifi_mgr_no = '%s' AND x_swifi_main_nm = '%s'", MAINHOME_TB, id, name);
        ResultSet rs;
        try {
            // SQL실행
            rs = stmt.executeQuery(selectSQL);
            // 결과값 출력

            rs.next();
            if (rs.getInt(1) >= 1) {
                return true;
            }

        } catch (SQLException e) {

        }

        return false;
    }

    public List<Historys> selectHistorysData() {
        String selectSQL = String.format("SELECT * FROM %s ORDER BY id DESC", HISTORYS_TB);
        List<Historys> historysList = new ArrayList<>();
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(selectSQL);

            while (rs.next()) {
                Historys historys = new Historys();
                historys.setId(rs.getInt("id"));
                historys.setXPos(rs.getDouble("x_pos"));
                historys.setYPos(rs.getDouble("y_pos"));
                historys.setCheckDate(rs.getTimestamp("check_date"));
                historysList.add(historys);
            }

        } catch (SQLException e) {

        }

        return historysList;
    }

    public List<MainHome> selectMainHomeData(String lat, String lnt) {
        List<MainHome> mainHomeList = new ArrayList<>();
        List<MainHome> finalList = new ArrayList<>();
        double dblLat = Double.parseDouble(lat);
        double dblLnt = Double.parseDouble(lnt);
        String selectSQL = "SELECT * FROM mainhome";

        try {
            // 객체 생성
            stmt = con.createStatement();
            rs = stmt.executeQuery(selectSQL);

            while (rs.next()) {
                MainHome mainHome = new MainHome();

                double xDist =  Math.abs(dblLat - Double.parseDouble(rs.getString("LAT")));
                double yDist = Math.abs(dblLnt - Double.parseDouble(rs.getString("LNT")));
                double dist = Math.sqrt(Math.pow(xDist,2) + Math.pow(yDist,2));
                mainHome.setDistance(String.format("%.4f", dist));

                mainHome.setXSwifiMgrNo(rs.getString("X_SWIFI_MGR_NO"));
                mainHome.setXSwifiWrdofc(rs.getString("X_SWIFI_WRDOFC"));
                mainHome.setXSwifiMainNm(rs.getString("X_SWIFI_MAIN_NM"));
                mainHome.setXSwifiAdres1(rs.getString("X_SWIFI_ADRES1"));
                mainHome.setXSwifiAdres2(rs.getString("X_SWIFI_ADRES2"));

                mainHome.setXSwifiInstlFloor(rs.getString("X_SWIFI_INSTL_FLOOR"));
                mainHome.setXSwifiInstlTy(rs.getString("X_SWIFI_INSTL_TY"));
                mainHome.setXSwifiInstlMby(rs.getString("X_SWIFI_INSTL_MBY"));
                mainHome.setXSwifiSvcSe(rs.getString("X_SWIFI_SVC_SE"));
                mainHome.setXSwifiCmcwr(rs.getString("X_SWIFI_CMCWR"));

                mainHome.setXSwifiCnstcYear(rs.getString("X_SWIFI_CNSTC_YEAR"));
                mainHome.setXSwifiInoutDoor(rs.getString("X_SWIFI_INOUT_DOOR"));
                mainHome.setXSwifiRemars3(rs.getString("X_SWIFI_REMARS3"));
                mainHome.setLat(rs.getDouble("LAT"));
                mainHome.setLnt(rs.getDouble("LNT"));
                mainHome.setWorkDttm(rs.getString("WORK_DTTM"));

                mainHomeList.add(mainHome);
            }

            Collections.sort(mainHomeList, (x, y) -> {
                int result = -1;
                if (Double.parseDouble(x.getDistance()) > Double.parseDouble(y.getDistance())) {
                    result = 1;
                } else if (Double.parseDouble(x.getDistance()) == Double.parseDouble(y.getDistance())) {
                    result = 0;
                } else ;
                return result;
            });

            for (int i = 0 ; i < TOTAL_ROW ; i++) {
                finalList.add(mainHomeList.get(i));
            }

        } catch (SQLException e) {

        }

        return finalList;
    }

    public List<BookMarkGroup> selectBookMarkGroupData() {
        List<BookMarkGroup> bookMarkGroupList = new ArrayList<>();
        String selectSQL = String.format("SELECT * FROM %s ORDER BY orders", BOOKMARKGROUP_TB);

        try {
            // 객체 생성
            stmt = con.createStatement();
            rs = stmt.executeQuery(selectSQL);

            while (rs.next()) {
                BookMarkGroup bookMarkGroup = new BookMarkGroup();

                bookMarkGroup.setId(rs.getInt("id"));
                bookMarkGroup.setBookmarkGroupName(rs.getString("bookmark_group_name"));
                bookMarkGroup.setOrders(rs.getInt("orders"));
                bookMarkGroup.setRegisterDate(rs.getTimestamp("register_date"));
                bookMarkGroup.setUpdateDate(rs.getTimestamp("update_date"));

                bookMarkGroupList.add(bookMarkGroup);
            }

        } catch (SQLException e) {


        }

        return bookMarkGroupList;
    }

    public BookMarkGroup selectOneBookMarkGroupData(int id) {
        BookMarkGroup bookMarkGroup = new BookMarkGroup();
        String selectSQL = String.format("SELECT * FROM %s WHERE id=%d", BOOKMARKGROUP_TB, id);

        try {
            // 객체 생성
            stmt = con.createStatement();
            rs = stmt.executeQuery(selectSQL);

            while (rs.next()) {
                bookMarkGroup.setId(rs.getInt("id"));
                bookMarkGroup.setBookmarkGroupName(rs.getString("bookmark_group_name"));
                bookMarkGroup.setOrders(rs.getInt("orders"));
                bookMarkGroup.setRegisterDate(rs.getTimestamp("register_date"));
                bookMarkGroup.setUpdateDate(rs.getTimestamp("update_date"));

            }

        } catch (SQLException e) {


        }

        return bookMarkGroup;
    }

    public List<BookMark> selectBookMarkListData() {

        List<BookMark> bookMarkList = new ArrayList<>();
        String selectSQL = String.format("SELECT * FROM %s", BOOKMARK_TB);

        try {
            // 객체 생성
            stmt = con.createStatement();
            rs = stmt.executeQuery(selectSQL);

            while (rs.next()) {
                BookMark bookMark = new BookMark();

                bookMark.setId(rs.getInt("id"));
                bookMark.setBookmarkGroupId(rs.getInt("bookmark_group_id"));
                bookMark.setBookmarkGroupName(rs.getString("bookmark_group_name"));
                bookMark.setWifiManagerNo(rs.getString("wifi_manager_no"));
                bookMark.setWifiName(rs.getString("wifi_name"));
                bookMark.setRegisterDate(rs.getTimestamp("register_date"));

                bookMarkList.add(bookMark);
            }

        } catch (SQLException e) {

        }

        return bookMarkList;
    }

    public BookMark selectOneBookMarkListInfo(int id) {

        BookMark bookMark = new BookMark();
        String selectSQL = String.format("SELECT * FROM %s WHERE id = %d", BOOKMARK_TB, id);

        try {
            // 객체 생성
            stmt = con.createStatement();
            rs = stmt.executeQuery(selectSQL);

            while (rs.next()) {

                bookMark.setId(rs.getInt("id"));
                bookMark.setBookmarkGroupId(rs.getInt("bookmark_group_id"));
                bookMark.setBookmarkGroupName(rs.getString("bookmark_group_name"));
                bookMark.setWifiManagerNo(rs.getString("wifi_manager_no"));
                bookMark.setWifiName(rs.getString("wifi_name"));
                bookMark.setRegisterDate(rs.getTimestamp("register_date"));

            }

        } catch (SQLException e) {

        }

        return bookMark;
    }

    public MainHome selectOneWiFiInfo(String mgrNo, String lat, String lnt) {

        MainHome mainHome = new MainHome();
        double dblLat = Double.parseDouble(lat);
        double dblLnt = Double.parseDouble(lnt);


        try {
            String selectSQL = String.format("SELECT * FROM %s WHERE x_swifi_mgr_no = '%s'", MAINHOME_TB,mgrNo);
            // 객체 생성
            stmt = con.createStatement();
            rs = stmt.executeQuery(selectSQL);

            while (rs.next()) {

                double xDist =  Math.abs(dblLat - Double.parseDouble(rs.getString("LAT")));
                double yDist = Math.abs(dblLnt - Double.parseDouble(rs.getString("LNT")));
                double dist = Math.sqrt(Math.pow(xDist,2) + Math.pow(yDist,2));
                mainHome.setDistance(String.format("%.4f", dist));

                mainHome.setXSwifiMgrNo(rs.getString("x_swifi_mgr_no"));
                mainHome.setXSwifiWrdofc(rs.getString("x_swifi_wrdofc"));
                mainHome.setXSwifiMainNm(rs.getString("X_swifi_main_nm"));
                mainHome.setXSwifiAdres1(rs.getString("X_swifi_adres1"));
                mainHome.setXSwifiAdres2(rs.getString("X_swifi_adres2"));

                mainHome.setXSwifiInstlFloor(rs.getString("x_swifi_instl_floor"));
                mainHome.setXSwifiInstlTy(rs.getString("x_swifi_instl_ty"));
                mainHome.setXSwifiInstlMby(rs.getString("x_swifi_instl_mby"));
                mainHome.setXSwifiSvcSe(rs.getString("x_swifi_svc_se"));
                mainHome.setXSwifiCmcwr(rs.getString("X_swifi_cmcwr"));

                mainHome.setXSwifiCnstcYear(rs.getString("x_swifi_cnstc_year"));
                mainHome.setXSwifiInoutDoor(rs.getString("X_swifi_inout_door"));
                mainHome.setXSwifiRemars3(rs.getString("X_swifi_remars3"));
                mainHome.setLat(rs.getDouble("lat"));
                mainHome.setLnt(rs.getDouble("lnt"));
                mainHome.setWorkDttm(rs.getString("work_dttm"));

            }

        } catch (SQLException e) {

        }
        return mainHome;
    }

    public Map<Integer, String> selectBookMarkGroupNameList() {

        Map<Integer, String> map = new HashMap<>();
        String selectSQL = String.format("SELECT id, bookmark_group_name FROM %s", BOOKMARKGROUP_TB);

        try {
            // 객체 생성
            stmt = con.createStatement();
            rs = stmt.executeQuery(selectSQL);

            while (rs.next()) {
                map.put(rs.getInt("id"), rs.getString("bookmark_group_name"));
            }

        } catch (SQLException e) {

        }

        return map;
    }

}
