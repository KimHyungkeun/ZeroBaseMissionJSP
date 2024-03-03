package org.zerobase.service;

import java.sql.SQLException;

public class UpdateDB extends MariaDBConnector{

    public UpdateDB() {
        super();
    }

    public void updateBookMarkGroupData(int id, String groupName, int orders) {

        String updateSQL = String.format("UPDATE bookmarkgroup SET bookmark_group_name = '%s', orders = %d, update_date = now() WHERE id = %d", groupName, orders, id);

        try {
            stmt = con.createStatement();
            // SQL실행
            rs = stmt.executeQuery(updateSQL);

        } catch (SQLException e) {

        }
    }


}
