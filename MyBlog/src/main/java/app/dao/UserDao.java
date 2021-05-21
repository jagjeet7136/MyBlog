package app.dao;

import java.sql.*;
import app.entities.User;

public class UserDao {

	private Connection con;

	public UserDao(Connection con) {
		this.con = con;
	}

	public int saveUser(User user) throws Exception {
		int insert = 0;
		try {
			String query = "insert into user (name, email, password, gender, about) values(?, ?, ?, ?, ?);";
			PreparedStatement stmt = con.prepareStatement(query);
			stmt.setString(1, user.getName());
			stmt.setString(2, user.getEmail());
			stmt.setString(3, user.getPassword());
			stmt.setString(4, user.getGender());
			stmt.setString(5, user.getAbout());

			insert = stmt.executeUpdate();
		} catch (Exception e) { throw  new Exception(); }

		return insert;

	}

	public User getUser(String email, String password) {
		User user = null;
		try {
			String query = "select * from user where email=? and password=?";
			PreparedStatement stmt = con.prepareStatement(query);
			stmt.setString(1, email);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();

			if(rs.next()) {
				user = new User();

				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setDateTime(rs.getTimestamp("rdate"));
				user.setProfile(rs.getString("profile"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	public boolean updateUser(User user) {
		int i = 0;
		try {
			String query = "update user set name=?, email=?, password=?, gender=?, about=?, profile=? where id=?";
			PreparedStatement stmt = con.prepareStatement(query);
			stmt.setString(1, user.getName());
			stmt.setString(2, user.getEmail());
			stmt.setString(3, user.getPassword());
			stmt.setString(4, user.getGender());
			stmt.setString(5, user.getAbout());
			stmt.setString(6, user.getProfile());
			stmt.setInt(7, user.getId());
			i = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return i==0 ? false : true;
	}
	
	public User getUserByPostId(int uid) {
		User user = null;
		String query = "select * from user where id=?";
		try {
			PreparedStatement s = con.prepareStatement(query);
			s.setInt(1, uid);
			ResultSet rs = s.executeQuery();
			if(rs.next()) {
				user = new User();

				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setDateTime(rs.getTimestamp("rdate"));
				user.setProfile(rs.getString("profile"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return user;
	}
}
