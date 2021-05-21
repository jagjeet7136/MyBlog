package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LikeDao {

	Connection con;
	public LikeDao(Connection con) {
		this.con = con;
	}

	public int insertLike(int pid, int uid) {
		int i = 0;
		try {
			String query = "insert into liketable(pid,uid) values(?,?)";
			PreparedStatement p = con.prepareStatement(query);
			p.setInt(1, pid);
			p.setInt(2, uid);
			i = p.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return i;
	}

	public int countLike(int pid) {
		int count = 0;
		String query = "select count(*) from liketable where pid=?";
		try {
			PreparedStatement p = con.prepareStatement(query);
			p.setInt(1, pid);
			ResultSet rs = p.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return count;
	}

	public boolean isLikedByUser(int pid, int uid) {
		boolean bool = false;

		try {
			PreparedStatement s = con.prepareStatement("select * from liketable where uid=? and pid=?");
			s.setInt(1, uid);
			s.setInt(2, pid);
			ResultSet rs = s.executeQuery();
			if(rs.next()) {
				bool = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bool;
	}
	
	public int deleteLike(int pid, int uid) {
		int i = 0;

		try {
			PreparedStatement s = con.prepareStatement("delete from liketable where uid=? and pid=?");
			s.setInt(1, uid);
			s.setInt(2, pid);
			i = s.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}
}
