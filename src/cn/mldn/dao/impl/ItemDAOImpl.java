package cn.mldn.dao.impl;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import cn.mldn.dao.IItemDAO;
import cn.mldn.util.dao.AbstractDAO;
import cn.mldn.vo.Item;

public class ItemDAOImpl extends AbstractDAO implements IItemDAO {

	@Override
	public boolean doCreate(Item vo) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean doUpdate(Item vo) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean doRemoveBatch(Set<Integer> ids) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Item findById(Integer id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Item> findAll() throws Exception {
		List<Item> all=new ArrayList<Item>();
		Item vo=null;
		String sql="select iid,title from item";
		super.pstmt=super.conn.prepareStatement(sql);
		ResultSet rs=super.pstmt.executeQuery();
		while(rs.next()){
			vo=new Item();
			vo.setIid(rs.getInt(1));
			vo.setTitle(rs.getString(2));
			all.add(vo);
		}
		return all;
	}

	@Override
	public List<Item> findAllSplit(Integer currentPage, Integer lineSize) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Item> findAllSplit(String column, String keyWord, Integer currentPage, Integer lineSize)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer getAllCount() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer getAllCount(String column, String keyWord) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
