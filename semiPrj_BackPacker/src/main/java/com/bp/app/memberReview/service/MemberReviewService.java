package com.bp.app.memberReview.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.bp.app.chat.room.vo.ChattingRoomVo;
import com.bp.app.common.db.JDBCTemplate;
import com.bp.app.common.page.PageVo;
import com.bp.app.member.profile.service.GoProfileService;
import com.bp.app.member.vo.MemberVo;
import com.bp.app.memberReview.dao.MemberReviewDao;
import com.bp.app.memberReview.vo.MemberReviewVo;

public class MemberReviewService {
   MemberReviewDao dao = new MemberReviewDao();
   public ChattingRoomVo checkCanWriteReview(String loginMemberNo, String selectMemberNo) throws Exception {
      ChattingRoomVo vo = null;
      //conn
      Connection conn = JDBCTemplate.getConnection();
         //update
         System.out.println("service");
      vo = dao.checkCanWriteReview(conn , loginMemberNo,selectMemberNo );
         
      
      JDBCTemplate.close(conn);
      return vo;
   }
   public int writeReview(MemberReviewVo mrv) throws Exception {
      
      Connection conn = JDBCTemplate.getConnection();
      
      int result = dao.writeReview(conn , mrv);
      
      //tx || rs
      if(result == 1) {
         JDBCTemplate.commit(conn);
      }else {
         JDBCTemplate.rollback(conn);
      }
      
      //close
      JDBCTemplate.close(conn);
      
      return result;
   }
   public MemberVo selectMemberToProfile(String selectMemberNo) throws Exception {
      
      MemberVo vo = null;
      //conn
      Connection conn = JDBCTemplate.getConnection();
         //update
         
      vo = dao.selectMemberToProfile(conn , selectMemberNo);
         
      JDBCTemplate.close(conn);
      return vo;
      
      
   }
   public List<MemberReviewVo> selectMemberReviewDetail(String selectMemberNo, PageVo pv) throws Exception {
      List<MemberReviewVo> MemberReviewVolist = null;
      //conn
      Connection conn = JDBCTemplate.getConnection();
         //update
         
      MemberReviewVolist = dao.selectMemberReviewDetail(conn , selectMemberNo, pv);
         
      JDBCTemplate.close(conn);
      return MemberReviewVolist;
   }
   public int selectCnt(String selectMemberNo) throws Exception {
      
      //conn
      Connection conn = JDBCTemplate.getConnection();
      
      int cnt = dao.selectCnt(conn, selectMemberNo);
      
      JDBCTemplate.close(conn);
      
      return cnt;
   }

}