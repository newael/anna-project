package edu.fourmen.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.Criteria;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.SearchVO2;

@Repository
public class BoardItemDAO {
	
	@Autowired(required=true)
	SqlSession sqlSession;
	
	private static final String efdb = "edu.fourmen.mapper.boardItemMapper";
	
	public List<BoardItemVO> selectAll(SearchVO2 searchVO, BoardItemVO vo, Criteria criteria) {
		return sqlSession.selectList(efdb+".selectAll",vo);
		
	}
		
	public int boarditemswrite(BoardItemVO vo, HttpServletRequest request) {
		return sqlSession.insert(efdb+".boarditemswrite",vo);
	}
	
	public BoardItemVO selectitem(int item_idx) {
		return sqlSession.selectOne(efdb+".selectitem",item_idx);
	}
	
	public int totalcount() {
		int result = sqlSession.selectOne(efdb+".totalcount");
		return result;
	}
}
