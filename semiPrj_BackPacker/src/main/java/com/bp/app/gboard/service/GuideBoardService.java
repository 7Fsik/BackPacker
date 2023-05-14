package com.bp.app.gboard.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.bp.app.common.db.JDBCTemplate;
import com.bp.app.common.page.PageVo;
import com.bp.app.gboard.dao.GuideBoardDao;
import com.bp.app.gboard.vo.GuideBoardVo;
import com.bp.app.member.dao.MemberDao;
import com.bp.app.member.vo.MemberVo;

public class GuideBoardService {
	private final GuideBoardDao dao;
	public GuideBoardService() {
		dao= new GuideBoardDao();
	}
	

	public int accomWrite(GuideBoardVo vo, MemberVo loginMember) throws Exception {
		//conn
		Connection conn = JDBCTemplate.getConnection();
		
		//sql
		int result1 =dao.insertScheduler(conn,vo,loginMember);
		int result2= dao.insertGuideBoard(conn,vo,loginMember);
		int result3 = dao.insertGuideIMG(conn,vo);
		
		
		//tx
		int result =0;
		if(result1==1&&result2==1&&result3==1) {//셋다 1이면커밋 
			JDBCTemplate.commit(conn);
			result=1;
		}else {
			JDBCTemplate.rollback(conn);
		}
		//close
		JDBCTemplate.close(conn);
		
		return result;
	}


	public List<GuideBoardVo> getAccomList(PageVo pvo) throws Exception {
		//conn
		Connection conn = JDBCTemplate.getConnection();
		//sql
		String sql ="SELECT * FROM ( SELECT ROWNUM RNUM, T.* FROM( SELECT GB.GUIDE_BOARD_NO,GB.TITLE, M.ID, M.NICK, M.AGE, M.PROFILE_IMAGE, M.GENDER, L.CHANGE_NAME, TO_CHAR(S.START_DATE,'YYYY-MM-DD')AS START_DATE ,TO_CHAR(S.END_DATE,'YYYY-MM-DD')AS END_DATE FROM GUIDE_BOARD GB JOIN MEMBER M ON (GB.WRITER_NO = M.MEMBER_NO) JOIN GUIDE_BOARD_IMG_LIST L ON (L.GUIDE_BOARD_NO= GB.GUIDE_BOARD_NO) JOIN SCHEDULER S ON(S.SCHEDULER_NO=GB.SCHEDULER_NO) WHERE DELETE_YN = 'N' AND MATCHING_STATE = 'N' ORDER BY GUIDE_BOARD_NO DESC ) T ) WHERE RNUM BETWEEN ? AND ? ";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pvo.getBeginRow());
		pstmt.setInt(2, pvo.getLastRow() );
		ResultSet rs = pstmt.executeQuery();
		
		//rs
		List<GuideBoardVo> bvoList = new ArrayList<>(); 
		while(rs.next()) {
			String guideBoardNo = rs.getString("GUIDE_BOARD_NO");
			String title = rs.getString("TITLE");
			String id = rs.getString("ID");
			String nick = rs.getString("NICK");
			String age = rs.getString("AGE");
			String profileImage = rs.getString("PROFILE_IMAGE");
			String gender = rs.getString("GENDER");
			if(gender=="M") {
				gender="남성";
			}else {
				gender="여성"; 
			}
			
			String changeName = rs.getString("CHANGE_NAME");
			String startDate_ = rs.getString("START_DATE");
			String endDate_ = rs.getString("END_DATE");
			
			GuideBoardVo bvo = new GuideBoardVo();
			bvo.setGuideBoardNo(guideBoardNo);
			bvo.setTitle(title);
			bvo.setId(id);
			bvo.setNick(nick);
			bvo.setAge(age);
			bvo.setProfileImage(profileImage);
			
			
			bvo.setGender(gender);
			bvo.setChangeName(changeName);
			
			//5월11일 이런식으로 데이터를 가공
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = formatter.parse(startDate_);
			Date endDate =formatter.parse(endDate_);
			SimpleDateFormat format = new SimpleDateFormat("MM월 dd일");
			String startDateStr = format.format(startDate);
			String endDateStr = format.format(endDate);
			
			
			bvo.setStartDate(startDateStr);
			bvo.setEndDate(endDateStr);
			
			
			
			bvoList.add(bvo);
			
		}
		
		//close
		JDBCTemplate.close(rs);
		JDBCTemplate.close(pstmt);
		JDBCTemplate.commit(conn);
		
		return bvoList; 
	}


	public int countCnt() throws Exception {
		//conn
		Connection conn = JDBCTemplate.getConnection();
		//sql
		String sql = "SELECT COUNT(*) as CNT FROM GUIDE_BOARD WHERE DELETE_YN ='N' and MATCHING_STATE = 'N'";
		PreparedStatement pstmt =conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		//rs
		int cnt = 0;
		if(rs.next()) {
			cnt = rs.getInt("CNT");
		}
		//close
		JDBCTemplate.close(rs);
		JDBCTemplate.close(pstmt);
		JDBCTemplate.close(conn);
		
		return cnt;
	}

}
