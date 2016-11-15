package com.remind.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.remind.controller.AnniversaryBean;
import com.remind.controller.BoardBean;
import com.remind.controller.FollowBean;
import com.remind.controller.LikeBean;
import com.remind.controller.MemberBean;
import com.remind.controller.ReplyBean;
import com.remind.controller.ScrollBean;
import com.remind.controller.WishlistBean;

@Repository
public class DataDao implements DaoInter {
	@Autowired
	private AnnoInter annoInter;

	@Override
	public List<BoardDto> showBoard(String m_no) throws DataAccessException {
		return annoInter.showBoard(m_no);
	}

	@Override
	public List<BoardDto> scrollBoard(ScrollBean bean) throws DataAccessException {
		// TODO Auto-generated method stub
		return annoInter.scrollingBoard(bean);
	}

	@Override
	public BoardDto showBoardDetail(String b_no1) throws DataAccessException {
		return annoInter.showBoardDetail(b_no1);
	}

	@Override
	public boolean eraseBoard(String b_no1) throws DataAccessException {
		try {
			annoInter.eraseBoard(b_no1);
			return true;
		} catch (Exception e) {
			System.out.println("eraseboard err");
			return false;
		}

	}

	@Override
	public boolean write(BoardBean bean) throws DataAccessException {
		try {
			String b_no = annoInter.selectMaxNo();
			bean.setB_no(b_no);
			annoInter.write(bean);
			return true;
		} catch (Exception e) {
			System.out.println("write err");
			return false;
		}
	}

	@Override
	public boolean updateBoard(BoardBean bean) throws DataAccessException {
		try {
			annoInter.updateBoard(bean);
			return true;
		} catch (Exception e) {
			System.out.println("updateboard err");
			return false;
		}
	}

	@Override
	public List<BoardDto> showMyMain(String b_mno) {
		return annoInter.showMyMain(b_mno);
	}

	@Override
	public MemberDto showMemberDetail(String m_no) throws DataAccessException {
		return annoInter.showMemberDetail(m_no);
	}

	@Override
	public MemberDto memberDetail(String m_name) throws DataAccessException {

		return annoInter.memberDetail(m_name);
	}

	@Override
	public boolean joinMember(MemberBean bean) throws DataAccessException {
		try {
			annoInter.joinMember(bean);
			return true;
		} catch (Exception e) {
			System.out.println("joinmember err" + e);
			return false;
		}
	}

	@Override
	public boolean outMember(String m_no) throws DataAccessException {
		try {
			annoInter.outMember(m_no);
			return true;
		} catch (Exception e) {
			System.out.println("eraseboard err");
			return false;
		}
	}

	@Override
	public boolean updateMember(MemberBean bean) throws DataAccessException {
		try {
			annoInter.updateMember(bean);
			return true;
		} catch (Exception e) {
			System.out.println("updatemember error" + e);
			return false;
		}
	}

	@Override
	public MemberDto login(MemberBean bean) {
		return annoInter.login(bean);
	}

	@Override
	public List<FollowDto> showMyFollower(String m_no) throws DataAccessException {
		return annoInter.showMyFollower(m_no);
	}

	@Override
	public List<FollowDto> showIFollow(String m_no) throws DataAccessException {
		return annoInter.showIFollow(m_no);
	}
	
	@Override //내가 팔로우하는 사람 확인하기 f_ms 수정용
	public FollowDto selectFollower(FollowBean bean) throws DataAccessException {
		FollowDto dto = annoInter.selectFollwer(bean);
				
		return annoInter.selectFollwer(bean);
	}
	
	@Override //f_ms 업데이트용
	public boolean followUpdate(String f_no,String bb) throws DataAccessException {
		boolean b = false;
		if(bb.equals("insert")){
			b = annoInter.followUpdate(f_no);			
		}else{
			b = annoInter.followUpdate2(f_no);
		}
		return b;
	}
	
	
	@Override
	public boolean follow(FollowBean bean) throws DataAccessException {
		try {
			annoInter.follow(bean);
			return true;
		} catch (Exception e) {
			System.out.println("follow err");
			return false;
		}
	}

	@Override
	public boolean followCancel(FollowBean bean) throws DataAccessException {
		try {
			annoInter.followCancel(bean);
			return true;
		} catch (Exception e) {
			System.out.println("followCancel err");
			return false;
		}
	}

	@Override
	public List<ReplyDto> showReply(String b_no1) throws DataAccessException {
		if (annoInter.countreply(b_no1) < 5) {
			return annoInter.showReply(b_no1, 0);
		} else {
			return annoInter.showReply(b_no1, annoInter.countreply(b_no1) - 5);
		}
	}

	@Override
	public int countReply(String b_no) throws DataAccessException {
		return annoInter.countreply(b_no);
	}

	@Override
	public List<ReplyDto> showReplyMore(String b_no) throws DataAccessException {
		// TODO Auto-generated method stub
		return annoInter.showReplyMore(b_no);
	}

	@Override
	public List<ReplyDto> showReplyall(String b_no) throws DataAccessException {
		return annoInter.showReplyall(b_no);
	}

	@Override
	public ReplyDto showReplyDetail(String r_no) throws DataAccessException {

		return annoInter.showReplyDetail(r_no);
	}

	@Override
	public boolean writeReply(ReplyBean bean) throws DataAccessException {
		try {
			annoInter.writeReply(bean);
			return true;
		} catch (Exception e) {
			System.out.println("writereply err" + e);
			return false;
		}
	}

	@Override
	public boolean deleteReply(String r_no) throws DataAccessException {
		try {
			annoInter.deleteReply(r_no);
			return true;
		} catch (Exception e) {
			System.out.println("deletereply err");
			return false;
		}
	}

	@Override
	public boolean updateReply(ReplyBean bean) throws DataAccessException {
		try {
			annoInter.updateReply(bean);
			return true;
		} catch (Exception e) {
			System.out.println("updatereply err");
			return false;
		}
	}
	@Override
	public List<WishlistDto> showEachWishList(String g_num) throws DataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * @Override public List<WishlistDto> showWishList(String w_mno) throws
	 * DataAccessException { return annoInter.showWishList(w_mno); }
	 * 
	 * 
	 * @Override public List<WishlistDto> showEachWishList(String g_num) throws
	 * DataAccessException { return annoInter.showEachWishList(g_num); }
	 * 
	 * @Override public boolean writeWishlist(WishlistBean bean) throws
	 * DataAccessException { try { annoInter.writeWishlist(bean); return true; }
	 * catch (Exception e) { System.out.println("writewishlist err"); return
	 * false; } }
	 * 
	 * @Override public boolean deleteWishlist(String w_no) throws
	 * DataAccessException { try { annoInter.deleteWishlist(w_no); return true;
	 * } catch (Exception e) { System.out.println("deletewishlist err"); return
	 * false; } }
	 * 
	 * @Override public boolean updateWishlist(WishlistBean bean) throws
	 * DataAccessException { try { annoInter.updateWishlist(bean); return true;
	 * } catch (Exception e) { System.out.println("Delete Wishlist err"); return
	 * false; } }
	 */ @Override
	public List<WishlistDto> showWishList(String w_mno) throws DataAccessException {
		// System.out.println(annoInter.showWishList(w_mno).get(2).getW_pname()+"!!!!");
		return annoInter.showWishList(w_mno);
	}

	@Override
	public List<WishlistDto> showInsertedList(String w_no) throws DataAccessException {
		return annoInter.showInsertedList(w_no);
	}

	@Override
	public boolean writeWishlist(WishlistBean bean) throws DataAccessException {
		try {
			annoInter.writeWishlist(bean);
			return true;
		} catch (Exception e) {
			System.out.println("writewishlist err" + e);
			return false;
		}
	}

	@Override
	public boolean deleteWishlist(String w_pname) throws DataAccessException {
		try {
			annoInter.deleteWishlist(w_pname);
			return true;
		} catch (Exception e) {
			System.out.println("deletewishlist err");
			return false;
		}
	}

	@Override
	public boolean updateWishlist(WishlistBean bean) throws DataAccessException {
		try {
			annoInter.updateWishlist(bean);
			return true;
		} catch (Exception e) {
			System.out.println("eraseboard err");
			return false;
		}
	}
	
	@Override
	public boolean updateLockStatus(WishlistBean bean) throws DataAccessException {
		System.out.println(bean.getW_lock() + " !!! " + bean.getW_no());
		try {
			annoInter.updateLock(bean);
			return true;
		} catch (Exception e) {
			System.out.println("eraseboard err");
			return false;
		}
	}

	// like
	@Override
	public List<LikeDto> showLike(String b_no) throws DataAccessException {
		return annoInter.showLike(b_no);
	}

	@Override
	public int likeYN(LikeBean bean) throws DataAccessException {
		if (annoInter.likeYN(bean) != null)
			return 1;
		else
			return 0;
	}

	@Override
	public LikeDto countLike(String b_no) throws DataAccessException {
		return annoInter.countLike(b_no);
	}

	@Override
	public boolean like(LikeBean bean) throws DataAccessException {
		try {
			annoInter.like(bean);
			return true;
		} catch (Exception e) {
			System.out.println("like err" + e);
			return false;
		}
	}

	@Override
	public boolean likeCancel(LikeBean bean) throws DataAccessException {
		try {
			annoInter.likeCancel(bean);
			return true;
		} catch (Exception e) {
			System.out.println("deletewishlist err");
			return false;
		}
	}

	// WISHGROUP LIST
	@Override
	public List<WishlistDto> showWishGroup(String wg_mno) throws DataAccessException {
		return annoInter.showWishGroup(wg_mno);
	}

	@Override
	public boolean insertWishGroup(WishlistBean bean) throws DataAccessException {
		try {
			annoInter.insertWishGroup(bean);
			return true;
		} catch (Exception e) {
			System.out.println("writewishlistgroup err");
			return false;
		}
	}

	@Override
	public boolean deleteWishGroup(String wg_no) throws DataAccessException {
		try {
			annoInter.deleteWishGroup(wg_no);
			return true;
		} catch (Exception e) {
			System.out.println("deletewishlistGroup err");
			return false;
		}
	}

	@Override
	public boolean updateWishGroup(WishlistBean bean) throws DataAccessException {
		try {
			annoInter.updateWishGroup(bean);
			return true;
		} catch (Exception e) {
			System.out.println("Delete WishListGroup err");
			return false;
		}

	}

	@Override
	public WishlistDto showWishAGroup(String wg_no) throws DataAccessException {
		// TODO Auto-generated method stub
		return annoInter.showWishAGroup(wg_no);
	}
	
	// anniversary
	@Override
	public List<AnniversaryDto> showAnniversary(String m_no) throws DataAccessException {
		return annoInter.showAnniversary(m_no);
	}
	@Override
	public List<AnniversaryDto> showAnniversaryPart(String m_no) throws DataAccessException {
		// TODO Auto-generated method stub
		return annoInter.showAnniversaryPart(m_no);
	}
	
	@Override
	public boolean deleteAnniversary(AnniversaryBean bean) throws DataAccessException {
		try {
			annoInter.deleteAnniversary(bean);
			return true;
		} catch (Exception e) {
			System.out.println("Delete anniversary err");
			return false;
		}
	}

	@Override
	public boolean insertAnniversary(AnniversaryBean bean) throws DataAccessException {
		try {
			annoInter.insertAnniversary(bean);
			return true;
		} catch (Exception e) {
			System.out.println("insert anniversary err");
			return false;
		}
	}

	@Override
	public boolean updateAnniversary(AnniversaryBean bean) throws DataAccessException {
		try {
			annoInter.updateAnniversary(bean);
			return true;
		} catch (Exception e) {
			System.out.println("update anniversary err");
			return false;
		}
	}
}
