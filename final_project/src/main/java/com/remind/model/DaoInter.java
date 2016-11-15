package com.remind.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.remind.controller.AnniversaryBean;
import com.remind.controller.BoardBean;
import com.remind.controller.FollowBean;
import com.remind.controller.LikeBean;
import com.remind.controller.MemberBean;
import com.remind.controller.ReplyBean;
import com.remind.controller.ScrollBean;
import com.remind.controller.WishlistBean;

public interface DaoInter {
	//sns board
	List<BoardDto> showBoard(String m_no) throws DataAccessException;
	List<BoardDto> scrollBoard(ScrollBean bean) throws DataAccessException;
	BoardDto showBoardDetail(String b_no1) throws DataAccessException;
	boolean eraseBoard(String b_no1) throws DataAccessException;
	boolean write(BoardBean bean) throws DataAccessException;
	boolean updateBoard(BoardBean bean) throws DataAccessException;
	
	//member
	List<BoardDto> showMyMain(String b_mno);
	MemberDto showMemberDetail(String m_no) throws DataAccessException;
	MemberDto memberDetail(String m_name) throws DataAccessException;
	boolean joinMember(MemberBean bean) throws DataAccessException;
	boolean outMember(String m_no) throws DataAccessException;
	boolean updateMember(MemberBean bean) throws DataAccessException;
	MemberDto login(MemberBean bean);
	
	//follow
	List<FollowDto> showMyFollower(String m_no) throws DataAccessException;
	List<FollowDto> showIFollow(String m_no) throws DataAccessException;
	boolean follow(FollowBean bean) throws DataAccessException;
	boolean followCancel(FollowBean bean) throws DataAccessException;
	FollowDto selectFollower(FollowBean bean) throws DataAccessException;
	boolean followUpdate(String f_no,String bb) throws DataAccessException;
	
	//reply
	List<ReplyDto> showReply(String b_no1) throws DataAccessException;
	List<ReplyDto> showReplyMore(String b_no) throws DataAccessException;
	List<ReplyDto> showReplyall(String m_no) throws DataAccessException;
	ReplyDto showReplyDetail(String r_no) throws DataAccessException;
	boolean writeReply(ReplyBean bean) throws DataAccessException;
	boolean deleteReply(String r_no) throws DataAccessException;
	boolean updateReply(ReplyBean bean) throws DataAccessException;
	int countReply(String b_no) throws DataAccessException;
	
	//wishlist
	List<WishlistDto> showWishList(String w_mno) throws DataAccessException;
	List<WishlistDto> showInsertedList(String w_no) throws DataAccessException;
	boolean writeWishlist(WishlistBean bean) throws DataAccessException;
	boolean deleteWishlist(String w_pname) throws DataAccessException;
	boolean updateWishlist(WishlistBean bean) throws DataAccessException;
	boolean updateLockStatus(WishlistBean bean) throws DataAccessException;
	

	//Wishlist Group
	List<WishlistDto> showEachWishList(String g_num) throws DataAccessException;
	List<WishlistDto> showWishGroup(String wg_mno) throws DataAccessException;	
	boolean insertWishGroup(WishlistBean bean) throws DataAccessException;
	boolean deleteWishGroup(String wg_no) throws DataAccessException;
	boolean updateWishGroup(WishlistBean bean) throws DataAccessException;
	WishlistDto showWishAGroup(String wg_no) throws DataAccessException;

	
	//like
	List<LikeDto> showLike(String m_no) throws DataAccessException;
	int likeYN(LikeBean bean) throws DataAccessException;
	LikeDto countLike(String b_no) throws DataAccessException;
	boolean like(LikeBean bean) throws DataAccessException;
	boolean likeCancel(LikeBean bean) throws DataAccessException;
	
	//Anniversary
	List<AnniversaryDto> showAnniversary(String m_no) throws DataAccessException;
	List<AnniversaryDto> showAnniversaryPart(String m_no) throws DataAccessException;
	boolean insertAnniversary(AnniversaryBean bean) throws DataAccessException;
	boolean deleteAnniversary(AnniversaryBean bean) throws DataAccessException;
	boolean updateAnniversary(AnniversaryBean bean) throws DataAccessException;


}
