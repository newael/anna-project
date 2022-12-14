package edu.fourmen.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.fourmen.vo.BoardItemVO;
import edu.fourmen.vo.BoardVO;
import edu.fourmen.vo.ChatMessageVO;
import edu.fourmen.vo.ReViewVO;
import edu.fourmen.vo.ReportVO;
import edu.fourmen.vo.UserVO;

@Repository
public class UserDAO {
	
	@Autowired
	SqlSession sqlSession;

	public int emailChk(String user_email) {

		int result = sqlSession.selectOne("edu.fourmen.mapper.userMapper.emailChk",user_email);
		
		return result;
	}

	
	public int join(UserVO vo) {

		int result = sqlSession.insert("edu.fourmen.mapper.userMapper.join",vo);
		
		return result;
		
		
	}
	
	public UserVO login(UserVO vo) {

		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.login",vo);
		
	}
	
	public void updateKakaoAuthKey(UserVO vo) {
		
		sqlSession.selectOne("edu.fourmen.mapper.userMapper.updateKakaoAuthKey",vo);
		
	}


	public UserVO getUserInfo(int uidx) {
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.getUserInfo",uidx);
		
	}


	public int userInfoMod(UserVO vo) {
		
		return sqlSession.update("edu.fourmen.mapper.userMapper.userInfoMod",vo);
		
	}


	public int updateInterested(UserVO vo) {
		
		return sqlSession.update("edu.fourmen.mapper.userMapper.updateInterested",vo);
		
	}


	public int updateLocation(UserVO vo) {

		return sqlSession.update("edu.fourmen.mapper.userMapper.updateLocation",vo);
		
	}


	public String getLocation(int uidx) {

		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.getLocation",uidx);
		
	}


	public List<BoardItemVO> getInterestedItem(List<String> keyWord,int uidx) {
		
		HashMap<String,Object> list = new HashMap<String,Object>();
		
		list.put("keyWord", keyWord);
		list.put("uidx", uidx);
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.getInterestedItem",list);
		
	}


	public List<UserVO> neighborList(int uidx) {
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.neighborList",uidx);
		
	}


	public List<BoardVO> myTownCommunityList(String location_auth) {
		
		String[] ArrayLocation = location_auth.split(",");
		
		List<String> locationList = new ArrayList<String>();
		
		for(int i = 0; i < ArrayLocation.length; i++) {
			locationList.add(ArrayLocation[i]);
			//System.out.println(ArrayLocation[i]);
		}
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.myTownCommunityList",locationList);
	}
	
	public UserVO keepLogin(int uidx) {
		
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.keepLogin",uidx);
	}


	public List<ChatMessageVO> getChatList(int uidx) {
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.getChatList",uidx);
	}


	public List<ChatMessageVO> getChatViewList(ChatMessageVO cmvo) {
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.getChatViewList",cmvo);
		
	}


	public void chatSetRead(List<Integer> listForSetRead) {

		sqlSession.update("edu.fourmen.mapper.userMapper.chatSetRead",listForSetRead);
		
	}


	public ChatMessageVO getMessageNoRead(ChatMessageVO cmvo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.getMessageNoRead",cmvo);
	}


	public List<BoardItemVO> myBoardItemList(int uidx) {
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.myBoardItemList",uidx);
		
	}


	public List<BoardItemVO> getWishList(int uidx) {
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.getWishList",uidx);
		
	}


	public List<BoardVO> getMyCommunity(int uidx) {
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.getMyCommunity",uidx);
		
	}


	public int updatePwd(UserVO vo) {
		
		return sqlSession.update("edu.fourmen.mapper.userMapper.updatePwd",vo);
		
	}


	public int updateRandomPwd(UserVO vo) {
		
		return sqlSession.update("edu.fourmen.mapper.userMapper.updateRandomPwd",vo);
	}


	public List<ChatMessageVO> getSellChatList(int uidx) {
		
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.getSellChatList",uidx);
	}


	public List<ChatMessageVO> getBuyChatList(int uidx) {

		return sqlSession.selectList("edu.fourmen.mapper.userMapper.getBuyChatList",uidx);
	}


	public void insertReView(ReViewVO vo) {

		sqlSession.insert("edu.fourmen.mapper.userMapper.insertReView",vo);
		
	}


	public ReViewVO getMyReview(ReViewVO vo) {
		
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.getMyReview",vo);
	}


	public ReViewVO getMyReviewForMe(ReViewVO vo) {
		
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.getMyReviewForMe",vo);
	}


	public void updateProfile(UserVO vo) {

		sqlSession.update("edu.fourmen.mapper.userMapper.updateProfile",vo);
		
	}


	public int chkAlarm(int uidx) {
		
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.chkAlarm",uidx);
	}
	
	public int chkSellNewMessage(int uidx) {
			
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.chkSellNewMessage",uidx);
	}
	
	public int chkBuyNewMessage(int uidx) {
		
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.chkBuyNewMessage",uidx);
	}


	public void updateReview(ReViewVO vo) {
		// TODO Auto-generated method stub
		sqlSession.update("edu.fourmen.mapper.userMapper.updateReview",vo);
	}


	public List<ChatMessageVO> getAlarm(int uidx) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("edu.fourmen.mapper.userMapper.getAlarm",uidx);
	}


	public void setAlarmRead(int uidx) {
		// TODO Auto-generated method stub
		sqlSession.update("edu.fourmen.mapper.userMapper.setAlarmRead",uidx);
	}


	public ReportVO BenCheck(int uidx) {
		
		return sqlSession.selectOne("edu.fourmen.mapper.userMapper.BenCheck",uidx);
	}
}






