package cn.mldn.service.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import cn.mldn.dao.IGoodsDAO;
import cn.mldn.dao.IItemDAO;
import cn.mldn.dao.ITagDAO;
import cn.mldn.dao.impl.GoodsDAOImpl;
import cn.mldn.dao.impl.ItemDAOImpl;
import cn.mldn.dao.impl.TagDAOImpl;
import cn.mldn.service.IGoodsService;
import cn.mldn.util.factory.DAOFactory;
import cn.mldn.vo.Goods;

public class GoodsServiceImpl implements IGoodsService {

	@Override
	public Map<String, Object> addPre() throws Exception {
		IItemDAO itemDAO =DAOFactory.getInstance(ItemDAOImpl.class);
		ITagDAO tagDAO =DAOFactory.getInstance(TagDAOImpl.class);
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("allItems", itemDAO.findAll());
		map.put("allTags", tagDAO.findAll());
		return map;
	}

	@Override
	public boolean add(Goods vo) throws Exception {
		IGoodsDAO goodsDAO=DAOFactory.getInstance(GoodsDAOImpl.class);
		if(goodsDAO.doCreate(vo)){
			vo.setGid(goodsDAO.getId());
			return goodsDAO.doCreateGoodsAndTag(vo);				
		}
		return false;
	}

	@Override
	public Map<String, Object> list(String column, String keyWord, int currentPage, int lineSize) throws Exception {
		IGoodsDAO goodsDAO=DAOFactory.getInstance(GoodsDAOImpl.class);
		Map<String,Object> map=new HashMap<String,Object>();
		if(column==null || "".equals(column) || keyWord==null || "".equals(keyWord)){
			map.put("allGoods", goodsDAO.findAllSplit(currentPage, lineSize));
			map.put("goodsCount",goodsDAO.getAllCount());
		}else{
			map.put("allGoods", goodsDAO.findAllSplit(column, keyWord, currentPage, lineSize));
			map.put("goodsCount",goodsDAO.getAllCount(column, keyWord));
		}	
		IItemDAO itemDAO=DAOFactory.getInstance(ItemDAOImpl.class);
		map.put("allItems", itemDAO.findAll());
		return map;
	}

	@Override
	public Map<String, Object> editPre(int gid) throws Exception {
		IItemDAO itemDAO=DAOFactory.getInstance(ItemDAOImpl.class);
		ITagDAO tagDAO=DAOFactory.getInstance(TagDAOImpl.class);
		IGoodsDAO goodsDAO=DAOFactory.getInstance(GoodsDAOImpl.class);
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("allItems", itemDAO.findAll());
		map.put("allTags", tagDAO.findAll());
		Goods goods=goodsDAO.findById(gid);
		goods.setTids(goodsDAO.findAllTagByGoods(gid));
		map.put("goods", goods);
		return map;
	}

	@Override
	public boolean edit(Goods vo) throws Exception {
		IGoodsDAO goodsDAO=DAOFactory.getInstance(GoodsDAOImpl.class);		
		if(goodsDAO.doUpdate(vo)){//商品数据更新
			if(goodsDAO.doRemoveTagByGoods(vo.getGid())){//删除已有标签信息
				return goodsDAO.doCreateGoodsAndTag(vo);//重新保存新的标签信息
			}
		}
		return false;
	}

	@Override
	public boolean remove(Set<Integer> ids) throws Exception {
		if(ids==null || ids.size()==0){
			return false;
		}
		IGoodsDAO goodsDAO=DAOFactory.getInstance(GoodsDAOImpl.class);;
		return goodsDAO.doRemoveBatch(ids);
	}
		
}
