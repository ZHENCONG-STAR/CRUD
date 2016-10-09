package cn.mldn.dao;

import java.util.Set;

import cn.mldn.util.dao.IDAO;
import cn.mldn.vo.Goods;

public interface IGoodsDAO extends IDAO<Integer, Goods> {
	public boolean doCreateGoodsAndTag(Goods vo) throws Exception;;
	public Integer getId()throws Exception;
	public Set<Integer> findAllTagByGoods(Integer id)throws Exception;
	public boolean doRemoveTagByGoods(Integer id)throws Exception;
}
