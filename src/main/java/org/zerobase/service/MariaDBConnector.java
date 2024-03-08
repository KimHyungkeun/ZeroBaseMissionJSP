package org.zerobase.service;

import java.sql.*;

public class MariaDBConnector {

    protected String mainhomeTB;
    protected String historysTB;
    protected String bookmarkTB;
    protected String bookmarkgroupTB;
    protected Connection con;
    protected Statement stmt;
    protected ResultSet rs;

    protected String server;
    protected String port;

    protected String database;
    protected String userName;
    protected String password;

    public MariaDBConnector () {
        this.con = null;
        this.stmt = null;
        this.rs = null;

        this.server = "localhost";
        this.port = "3306";
        this.database = "zerobase_mission1";
        this.userName = "root";
        this.password = "root";

        this.mainhomeTB = "mainhome";
        this.historysTB = "historys";
        this.bookmarkTB = "bookmark";
        this.bookmarkgroupTB = "bookmarkgroup";
    }

    public void connect() {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println(" 드라이버 로딩 오류 : " + e.getMessage());
            e.printStackTrace();
        }

        try {
            con = DriverManager.getConnection("jdbc:mariadb://" +
                    server + ":" + port + "/" +
                    database +
                    "?useSSL=false&useUnicode=true&characterEncoding=utf8", userName, password); // SSL 실행 확인
            System.out.println("[INFO] Connection Success");
        } catch(SQLException e) {
            System.err.println("[ERROR] Connection Error :" + e.getMessage());
            e.printStackTrace();
        }
    }

    public void disconnect() {
        try {
            if(con != null)
                con.close();
                System.out.println("[INFO] Connection Close");
        } catch (SQLException e) {}
    }

}
