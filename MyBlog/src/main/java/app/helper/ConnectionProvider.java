package app.helper;

import java.sql.*;

public class ConnectionProvider {

	public static Connection con = null;
	public static Connection getConnection() {
		if(con==null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");

				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/advanceProject","root","root");
			} catch(Exception e) {
				e.printStackTrace();
			}
		}


		return con;
	}

//	public static void main(String[] args) {
//		// TODO Auto-generated method stub
//		System.out.println(getConnection());
//	}

}
