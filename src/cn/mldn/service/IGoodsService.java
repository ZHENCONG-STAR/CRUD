package cn.mldn.service;

import java.util.Map;
import java.util.Set;

import cn.mldn.vo.Goods;

public interface IGoodsService {
	public Map<String,Object>addPre() throws Exception;
	public boolean add(Goods vo)throws Exception;
	public Map<String,Object> list(String column,String keyWord,int currentPage,int lineSize)throws Exception;
	public Map<String,Object> editPre(int gid) throws Exception;
	public boolean edit(Goods vo)throws Exception;
	public boolean remove(Set<Integer> ids)throws Exception;
}
