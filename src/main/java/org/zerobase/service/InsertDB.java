package org.zerobase.service;


import org.zerobase.dto.MainHome;

import java.sql.SQLException;
import java.util.List;


public class InsertDB extends MariaDBConnector{

    public InsertDB() {
        super();
    }

    public int insertMainHomeData() {
        WifiAPI wifiAPI = new WifiAPI();
        SelectDB selectDB = new SelectDB();
        List<MainHome> dataList = wifiAPI.getTotalWifiList();
        int insertCnt = dataList.size();

        try {
            for (MainHome val : dataList) {
                // Insert 쿼리문
                String insertSQL = String.format(" INSERT INTO %s " +
                                "(`x_swifi_mgr_no`," +
                                "`x_swifi_wrdofc`," +
                                "`x_swifi_main_nm`," +
                                "`x_swifi_adres1`," +
                                "`x_swifi_adres2`," +
                                "`x_swifi_instl_floor`," +
                                "`x_swifi_instl_ty`," +
                                "`x_swifi_instl_mby`," +
                                "`x_swifi_svc_se`," +
                                "`x_swifi_cmcwr`," +
                                "`x_swifi_cnstc_year`," +
                                "`x_swifi_inout_door`," +
                                "`x_swifi_remars3`," +
                                "`lat`," +
                                "`lnt`," +
                                "`work_dttm`) " +
                                "VALUES (" +
                                "'%s'," +
                                "'%s'," +
                                "'%s'," +
                                "'%s'," +
                                "'%s'," +
                                "'%s'," +
                                "'%s'," +
                                "'%s'," +
                                "'%s'," +
                                "'%s'," +
                                "'%s'," +
                                "'%s'," +
                                "'%s'," +
                                "%f," +
                                "%f," +
                                "'%s')", MAINHOME_TB,
                        val.getXSwifiMgrNo(),
                        val.getXSwifiWrdofc(),
                        val.getXSwifiMainNm(),
                        val.getXSwifiAdres1(),
                        val.getXSwifiAdres2(),
                        val.getXSwifiInstlFloor(),
                        val.getXSwifiInstlTy(),
                        val.getXSwifiInstlMby(),
                        val.getXSwifiSvcSe(),
                        val.getXSwifiCmcwr(),
                        val.getXSwifiCnstcYear(),
                        val.getXSwifiInoutDoor(),
                        val.getXSwifiRemars3(),
                        val.getLat(),
                        val.getLnt(),
                        val.getWorkDttm());

                String updateSQL = String.format("UPDATE %s " +
                                "SET " +
                                "`x_swifi_mgr_no` = '%s'," +
                                "`x_swifi_wrdofc` = '%s'," +
                                "`x_swifi_main_nm` = '%s'," +
                                "`x_swifi_adres1` = '%s'," +
                                "`x_swifi_adres2` = '%s'," +
                                "`x_swifi_instl_floor` = '%s'," +
                                "`x_swifi_instl_ty` = '%s'," +
                                "`x_swifi_instl_mby` = '%s'," +
                                "`x_swifi_svc_se` = '%s'," +
                                "`x_swifi_cmcwr` = '%s'," +
                                "`x_swifi_cnstc_year` = '%s'," +
                                "`x_swifi_inout_door` = '%s'," +
                                "`x_swifi_remars3` = '%s'," +
                                "`lat` = %f," +
                                "`lnt` = %f," +
                                "`work_dttm` = '%s' " +
                                "WHERE `x_swifi_mgr_no` = '%s' AND `x_swifi_main_nm` = '%s'",
                        MAINHOME_TB,
                        val.getXSwifiMgrNo(),
                        val.getXSwifiWrdofc(),
                        val.getXSwifiMainNm(),
                        val.getXSwifiAdres1(),
                        val.getXSwifiAdres2(),
                        val.getXSwifiInstlFloor(),
                        val.getXSwifiInstlTy(),
                        val.getXSwifiInstlMby(),
                        val.getXSwifiSvcSe(),
                        val.getXSwifiCmcwr(),
                        val.getXSwifiCnstcYear(),
                        val.getXSwifiInoutDoor(),
                        val.getXSwifiRemars3(),
                        val.getLat(),
                        val.getLnt(),
                        val.getWorkDttm(),val.getXSwifiMgrNo(),val.getXSwifiMainNm());


                // 객체 생성
                stmt = con.createStatement();

                // SQL실행
                if (!selectDB.selectIsMainHomeExist(val.getXSwifiMgrNo(), val.getXSwifiMainNm(), stmt)) {
                    stmt.executeQuery(insertSQL);
                } else {
                    stmt.executeQuery(updateSQL);
                }

            }
            System.out.println("New Add : " + insertCnt);

        } catch (SQLException e) {
        }

        return insertCnt;
    }

    public void insertHistorysData(String lat, String lnt) {

        double dblLat = Double.parseDouble(lat);
        double dblLnt = Double.parseDouble(lnt);

        String insertSQL = String.format("INSERT INTO %s (x_pos, y_pos, checkDate) VALUES (%f, %f, now())", HISTORYS_TB, dblLat, dblLnt);

        try {
            stmt = con.createStatement();
            // SQL실행
            rs = stmt.executeQuery(insertSQL);

        } catch (SQLException e) {

        }
    }

    public void insertBookMarkGroupData(String groupName, int orders) {
        ManageString manageString = new ManageString();
        String insertSQL = String.format("INSERT INTO %s (bookmark_group_name, orders, register_date) VALUES ('%s', %d, now())", BOOKMARKGROUP_TB, manageString.manageApostrophe(groupName), orders);

        try {
            stmt = con.createStatement();
            // SQL실행
            rs = stmt.executeQuery(insertSQL);

        } catch (SQLException e) {

        }
    }

    public void insertBookMarkData(int bookMarkGroupId, String bookMarkGroupName, String wifiMgrNo, String wifiName) {

        String insertSQL = String.format("INSERT INTO %s (bookmark_group_id, bookmark_group_name, wifi_manager_no, wifi_name, register_date) VALUES (%d, '%s', '%s', '%s', now())", BOOKMARK_TB, bookMarkGroupId, bookMarkGroupName, wifiMgrNo, wifiName);
        try {
            stmt = con.createStatement();
            // SQL실행
            rs = stmt.executeQuery(insertSQL);

        } catch (SQLException e) {

        }
    }

}
