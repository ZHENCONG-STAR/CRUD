package cn.mldn.util.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Set;

import cn.mldn.util.dbc.DatabaseConnection;

public class AbstractDAO {
	protected Connection conn ;
	protected PreparedStatement pstmt ;
	public AbstractDAO() {
		this.conn = DatabaseConnection.get() ;
	}	
	protected Integer getCurrentValueHandle(String sequenceName) throws Exception{
		String sql="select " + sequenceName + ".currval from dual";
		this.pstmt=this.conn.prepareStatement(sql);
		ResultSet rs=this.pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt(1);
		}
		return 0;
	}
	protected Integer getAllCountHandle(String tableName)throws Exception{
		String sql="select count(*) from " + tableName;
		this.pstmt=this.conn.prepareStatement(sql);
		ResultSet rs=this.pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt(1);
		}
		return 0;
	}
	protected Integer getAllCountHandle(String tableName,String column,String keyWord)throws Exception{
		String sql="select count(*) from " + tableName + " where " + column + " like " + keyWord;
		this.pstmt=this.conn.prepareStatement(sql);
		this.pstmt.setString(1, "%" + keyWord + "%");
		ResultSet rs=this.pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt(1);
		}
		return 0;
	}
	protected boolean deRemoveBatchHandleByInt(Set<Integer> ids,String tableName,String column)throws Exception{
		StringBuffer buf=new StringBuffer();
		buf.append("delete from ").append(tableName).append(" where ").append(column).append(" in ( ");
		Iterator<Integer>iter=ids.iterator();
		while(iter.hasNext()){
			buf.append(iter.next()).append(",");
		}
		buf.delete(buf.length()-1, buf.length()).append(")");
		this.pstmt=this.conn.prepareStatement(buf.toString());
		return this.pstmt.executeUpdate()==ids.size();
	}
}
