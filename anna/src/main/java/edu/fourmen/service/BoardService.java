package edu.fourmen.service;

import java.util.List;




import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.PageMaker;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.SearchVO;

public interface BoardService {

	
	int writeBoard(BoardVO vo);
	
	
	List<BoardVO> selectboard(PageMaker pm);

	BoardVO viewBoard(int Bidx);
	
	int totalCount(PageMaker pm);

	
	int commentwrite(BoardVO rv);
	
	int getCTotal(BoardVO rv);
	
	List<BoardVO> getCList(int Bidx);
	

	
	int boardLikeUP(BoardVO vo);
	
	int boardLikeDown(BoardVO vo);
	
	int Likeyn(BoardVO vo);
	
	int HitUp(int Bidx);
	
	int boardDelete(int Bidx);
	
	int boardModify(BoardVO vo);

	int reportinsert(ReportVO vo);

	int replyDel(int reply_idx);
	
	int replyModify(BoardVO vo);
	
}
