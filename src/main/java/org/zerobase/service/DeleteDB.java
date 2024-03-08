package org.zerobase.service;

import java.sql.SQLException;

public class DeleteDB extends MariaDBConnector{

    public DeleteDB() {
        super();
    }

    public void deleteHistorysData(int id) {

        String deleteSQL = String.format("DELETE FROM %s WHERE id = %d", HISTORYS_TB, id);

        try {
            stmt = con.createStatement();

            // SQL실행
            rs = stmt.executeQuery(deleteSQL);

        } catch (SQLException e) {

        }
    }

    public void deleteBookMarkGroupData(int id) {

        String deleteSQL = String.format("DELETE FROM %s WHERE id = %d", BOOKMARKGROUP_TB,id);

        try {
            stmt = con.createStatement();
            // SQL실행
            rs = stmt.executeQuery(deleteSQL);

        } catch (SQLException e) {

        }
    }

    public void deleteBookMarkData(int id) {
        String deleteSQL = String.format("DELETE FROM %s WHERE id = %d", BOOKMARK_TB, id);

        try {
            stmt = con.createStatement();
            // SQL실행
            rs = stmt.executeQuery(deleteSQL);

        } catch (SQLException e) {

        }
    }
}
