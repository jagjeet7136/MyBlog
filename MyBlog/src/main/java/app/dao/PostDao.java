package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import app.entities.Category;
import app.entities.Post;

public class PostDao {

	Connection con;

	public PostDao(Connection con) {
		this.con = con;
	}

	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> list = new ArrayList<Category>();

		try {
			String query = "select * from categories order by name";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				int cid = rs.getInt("cid");
				String name = rs.getString("name");
				String description = rs.getString("description");
				Category c = new Category(cid, name, description);
				list.add(c);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}

		return list;
	}

	public int savePost(Post p) {
		int i = 0;
		try {
			String query = "insert into post(ptitle, pcontent,ppic, cid, userid) values(?,?,?,?,?)";
			PreparedStatement st = con.prepareStatement(query);
			st.setString(1, p.getPtitle());
			st.setString(2, p.getPcontent());
			st.setString(3, p.getPpic());
			st.setInt(4, p.getCid());
			st.setInt(5, p.getUserid());

			i = st.executeUpdate();

		} catch (Exception e) {

		}
		return i;
	}

	public ArrayList<Post> getAllPost() {
		ArrayList<Post> list = new ArrayList<Post>();

		try {
			String query = "select * from post order by pid desc";
			PreparedStatement p = con.prepareStatement(query);
			ResultSet rs = p.executeQuery();

			while(rs.next()) {
				int pid = rs.getInt("pid");
				String ptitle = rs.getString("ptitle");
				String pcontent = rs.getString("pcontent");
				String ppic = rs.getString("ppic");
				Timestamp date = rs.getTimestamp("pdate");
				int cid = rs.getInt("cid");
				int uid = rs.getInt("userid");
				Post post = new Post(pid, ptitle, pcontent,ppic, date, cid, uid);
				list.add(post);

			}
		} catch (Exception e) {
		}

		return list;
	}

	public ArrayList<Post> getPostByCatId(int cid) {
		ArrayList<Post> list = new ArrayList<Post>();
		
		try {
			String query = "select * from post where cid=?";
			PreparedStatement p = con.prepareStatement(query);
			p.setInt(1, cid);
			ResultSet rs = p.executeQuery();

			while(rs.next()) {
				int pid = rs.getInt("pid");
				String ptitle = rs.getString("ptitle");
				String pcontent = rs.getString("pcontent");
				String ppic = rs.getString("ppic");
				Timestamp date = rs.getTimestamp("pdate");
				int uid = rs.getInt("userid");
				Post post = new Post(pid, ptitle, pcontent, ppic, date, cid, uid);
				list.add(post);

			}
		} catch (Exception e) {
		}


		return list;
	}
	
	public Post getPostByPostId(int pid) {
		Post post = null;
		String query = "select * from post where pid=?";
		try {
			PreparedStatement p = con.prepareStatement(query);
			p.setInt(1, pid);
			ResultSet rs = p.executeQuery();
			if(rs.next()) {
				pid = rs.getInt("pid");
				String ptitle = rs.getString("ptitle");
				String pcontent = rs.getString("pcontent");
				String ppic = rs.getString("ppic");
				Timestamp date = rs.getTimestamp("pdate");
				int cid = rs.getInt("cid");
				int uid = rs.getInt("userid");
				post = new Post(pid, ptitle, pcontent, ppic, date, cid, uid);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return post;
	}

}
