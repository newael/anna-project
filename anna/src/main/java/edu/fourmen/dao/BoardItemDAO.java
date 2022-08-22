package edu.fourmen.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.ChatMessageVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.SearchVO;
import edu.fourmen.vo.UserVO;

@Repository
public class BoardItemDAO {
	
	/* 맵퍼에서 파라미터를 Map으로 쓰는법 해당 함수 안에 밑에꺼 작성
	 * Map<String,Object> newMap = new HashMap<String,Object>();
	 * 
	 * newMap.put("udix",vo.getUidx());
	 *  newMap.put("pageNum",pm.getPerPageNum());
	 */ 
	@Autowired(required=true)
	SqlSession sqlSession;
	
	private static final String efdb = "edu.fourmen.mapper.boardItemMapper";
	
	public List<BoardItemVO> selectAll(PageMaker pm) {
		
		
		
		HashMap<String,Object> del = new HashMap<String,Object>();
		String[] key = null;
		
		if(pm.getInterested() != null) {
			key  = pm.getInterested().split(",");
		}
		del.put("pagemaker", pm);
		del.put("interested", key);
		
		return sqlSession.selectList(efdb+".selectAll",del);
		
	}
	public List<BoardItemVO> selectAllbyuser(BoardItemVO vo, SearchVO svo) {
		return sqlSession.selectList(efdb+".selectAllbyuser",vo);
		
	}
		
	public int boarditemswrite(BoardItemVO vo) {
		return sqlSession.insert(efdb+".boarditemswrite",vo);
	}
	
	public BoardItemVO selectitem(int item_idx) {
		return sqlSession.selectOne(efdb+".selectitem",item_idx);
	}
	

	public int totalCount(PageMaker pm) {
		int result = sqlSession.selectOne(efdb+".totalCount",pm);
		return result;
	}
	
	public int itemmodify(BoardItemVO vo) {
		int result = sqlSession.update(efdb+".itemmodify",vo);
		return result;
	}
	public int itemdelete(BoardItemVO vo) {
	
		return sqlSession.update(efdb+".itemdelete",vo);
	}

	public List<BoardItemVO> MinPrice(PageMaker pm) {
		return sqlSession.selectList(efdb+".MinPrice",pm);
	}

	public int insertChat(ChatMessageVO cvo) {
		return sqlSession.insert(efdb+".insertChat",cvo);
	}
	
	public List<ChatMessageVO> selectChat(ChatMessageVO cvo) {
		return sqlSession.selectList(efdb+".selectChat",cvo);
	}
	
	public List<ChatMessageVO> mychatlist(ChatMessageVO cvo){
		return sqlSession.selectList(efdb+".mychatlist",cvo);
	}
	public List<ChatMessageVO> mychat(ChatMessageVO cvo){
		return sqlSession.selectList(efdb+".mychat",cvo);
	}
	
	public int addNeighbor(BoardItemVO vo) {
		return sqlSession.insert(efdb+".addNeighbor",vo);
	}

	public int neighbor_check(BoardItemVO bvo) {
		return sqlSession.selectOne(efdb+".neighbor_check",bvo);
	}
	
	public List<BoardItemVO> neighbor_list(BoardItemVO nvo){
		return sqlSession.selectList(efdb+".neighbor_list",nvo);
	}
	 
	//다른 곳에서 파라미터 순서 다르게 넣으면 타입이 같아서 값이 순서에 맞지 않게 들어감.!! 꼭 순서에 유의할것!!
	public int delneighbor(int neigbor_idx,int uidx) {
		
		HashMap<String,Integer> del = new HashMap<String,Integer>();
		
		del.put("uidx", uidx);
		del.put("neighbor_idx", neigbor_idx);
		
		return sqlSession.delete(efdb+".delneighbor",del);
		
	}
	
	
	public int addwist(BoardItemVO vo){
		return sqlSession.insert(efdb+".addWish",vo);
	}
	
	public int checkWish(BoardItemVO wvo) {
		return sqlSession.selectOne(efdb+".checkWish",wvo);
	}
		
	public int delWish(BoardItemVO wvo) {
		return sqlSession.delete(efdb+".delWish",wvo);
	}
	
	public int WishCount(int item_idx) {
		return sqlSession.selectOne(efdb+".WishCount",item_idx);
	}

	public List<BoardItemVO> mywish(BoardItemVO vo){
		return sqlSession.selectList(efdb+".mywish",vo);
	}
	
	
	
	public int report_target(ReportVO rvo) {
		return sqlSession.insert(efdb+".report_target",rvo);
	}
	
	public int addviewCount(int item_idx) {
		return sqlSession.update(efdb+".addviewCount",item_idx);
	}
	
	public int viewCount(BoardItemVO vo) {
		return sqlSession.selectOne(efdb+".viewCount",vo);
	}
	
	public List<BoardItemVO> myblackList(BoardItemVO vo) {
		return sqlSession.selectList(efdb+".myblackList",vo);
	}
	
	public int addblackList(BoardItemVO vo) {
		return sqlSession.insert(efdb+".addblackList",vo);
	}
	
	public int delmyblackList(BoardItemVO vo) {
		return sqlSession.delete(efdb+".delmyblackList",vo);
	}
	
	public int update_state(int state, int item_idx) {
		
		HashMap<String,Integer> del = new HashMap<String,Integer>();
		
			del.put("state", state);
			del.put("item_idx", item_idx);
		
		return sqlSession.update(efdb+".udate_state",del);
	}
	
	public int update_wdate(int item_idx) {
		return sqlSession.update(efdb+".update_wdate",item_idx);
	}
}
