package com.bp.app.accompany.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bp.app.gboard.service.GuideBoardService;
import com.bp.app.gboard.vo.GuideBoardVo;

@WebServlet ("/accompany/list")
public class AccompanyListController extends HttpServlet{
	//디비에서 셀렉트해서 가져온걸 보여주는 화면으로 가야함
	//BoardVo생성하고 Vo를 저장한 리스트를 화면측에 넘겨야함
	//어느Board인지 구분가능하게 작명하여 vo를 작성 GuideBoardVo
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		//데뭉
		try {

			//서비스
			//가이드vo형식의 리스트를 담아서 모든 정보를 가지고 와서 session에 담아 전달...? session에 담아야할까?
			
			GuideBoardService gbs = new GuideBoardService();
			List<GuideBoardVo> bvoList = gbs.getBoardList();
			
			
			//화면
			req.setAttribute("gbvoList", bvoList);
			req.getRequestDispatcher("/WEB-INF/views/accompanyBoard/accompanyBoardList.jsp").forward(req, resp);
		} catch (Exception e) {
			System.out.println("동행게시판 리스트 보여주는 메소드에서 발생");
			e.printStackTrace();
			
			req.getRequestDispatcher("/WEB-INF/views/common/error-page.jsp").forward(req, resp);
			
		}
	}
}