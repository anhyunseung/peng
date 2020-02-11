package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.Comment_noticeDTO;
import poly.dto.NoticeDTO;
import poly.service.INoticeService;
import poly.util.CmmUtil;

@Controller
public class NoticeController {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "NoticeService")
	private INoticeService NoticeService;

	@RequestMapping(value = "notice/NoticeList", method = RequestMethod.GET)
	public String Notice_List(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {

		log.info(this.getClass().getName() + ".NoticeList start!");
		List<NoticeDTO> rList = NoticeService.getNoticeList();
		
		String count=request.getParameter("count");
		
		if(count==null) {
			count="0";
		}
		
		
		System.out.println(Integer.parseInt(count));
		
		int count2 = Integer.parseInt(count);
		
		if(count2!=0) {
			count2=count2-1;
		}
		
		System.out.println(count2);
		
		if (rList == null) {
			rList = new ArrayList<NoticeDTO>();

		}
		
		request.setAttribute("count", count2);
		model.addAttribute("rList", rList);
		rList = null;

		log.info(this.getClass().getName() + ".NoticeList end!");

		return "/notice/NoticeList";
	}
	
	@RequestMapping(value = "notice/NoticeSearch", method = RequestMethod.GET)
	public String Notice_Search(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {

		log.info(this.getClass().getName() + ".NoticeSearch start!");
		String find=request.getParameter("find");
		
		find = "%"+find+"%";
		NoticeDTO rDTO = new NoticeDTO();
		
		rDTO.setSearch(find);
		List<NoticeDTO> rList = NoticeService.getNoticeSearch(rDTO);
		
		String count=request.getParameter("count");
		
		if(count==null) {
			count="0";
		}
		
		
		System.out.println(Integer.parseInt(count));
		
		int count2 = Integer.parseInt(count);
		
		if(count2!=0) {
			count2=count2-1;
		}
		
		System.out.println(count2);
		
		if (rList == null) {
			rList = new ArrayList<NoticeDTO>();

		}
		
		request.setAttribute("count", count2);
		model.addAttribute("rList", rList);
		request.setAttribute("find", find);
		rList = null;

		log.info(this.getClass().getName() + ".NoticeList end!");

		return "/notice/NoticeSearch";
	}
	
	@SuppressWarnings("unused")
	@RequestMapping(value = "notice/commentreg", method = RequestMethod.POST)
	public String commentreg(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {

		log.info("notice/commentreg");
		
		String user_id=CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String user_no=CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		String seq=request.getParameter("notice_seq");
		String contents=request.getParameter("comment");
		
		if (contents.length() > 3000) {
			request.setAttribute("msg", "최대 3000자까지 입력 가능합니다.");
			request.setAttribute("url", "/notice/NoticeInfo.do?notice_seq="+seq);
			return "/MsgToList";
		}
		
		if(user_no=="") {
			session.setAttribute("notice_seq",seq);
			request.setAttribute("msg", "로그인 회원만 댓글을 작성할 수 있습니다.");
			request.setAttribute("url", "/notice/NoticeInfo.do?notice_seq="+seq);
			return "/MsgToList";
		}
		
		Comment_noticeDTO cDTO = new Comment_noticeDTO();
		
		cDTO.setUser_id(user_id);
		cDTO.setReg_user_no(user_no);
		cDTO.setnotice_seq(seq);
		cDTO.setContents(contents);
		
		System.out.println(user_id);
		System.out.println(user_no);
		System.out.println(seq);
		System.out.println(contents);
		
		NoticeService.insertComment(cDTO);
		
		
		if(cDTO==null) {
			request.setAttribute("msg", "댓글입력에 실패하였습니다.");
			request.setAttribute("url", "/notice/NoticeInfo.do?notice_seq="+seq);
		}else {
		request.setAttribute("msg", "댓글을 작성하였습니다.");
		request.setAttribute("url", "/notice/NoticeInfo.do?notice_seq="+seq);
		session.setAttribute("notice_seq",seq);
		}
		
		cDTO=null;
		
		return "/MsgToList";
	}
	
	@SuppressWarnings("unused")
	@RequestMapping(value = "notice/commentdelete", method = RequestMethod.GET)
	public String commentdelete(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {

		log.info("notice/commentdelete");
		
		String notice_seq=CmmUtil.nvl((String) session.getAttribute("com_notice_seq"));
		String com_seq=request.getParameter("com_seq");
		
		session.setAttribute("com_notice_seq", "");
		
		Comment_noticeDTO cDTO = new Comment_noticeDTO();
		
		cDTO.setcom_seq(com_seq);
		cDTO.setnotice_seq(notice_seq);
		

		System.out.println(com_seq);
		System.out.println(notice_seq);

		String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String a=NoticeService.getCommentUserid(com_seq);
		System.out.println(a);
		if(a.equals(SESSION_USER_ID) || SESSION_USER_ID.equals("admin")) {
			NoticeService.deleteComment(cDTO);

			cDTO=null;

			request.setAttribute("msg", "댓글을 삭제하였습니다.");
		}else {
			cDTO=null;

			request.setAttribute("msg", "잘못된 접근입니다.");
		}
		request.setAttribute("url", "/notice/NoticeInfo.do?notice_seq="+notice_seq);
		session.setAttribute("notice_seq",notice_seq);
		
		return "/MsgToList";
	}
	
	@SuppressWarnings("unused")
	@RequestMapping(value = "notice/commentupdate", method = RequestMethod.POST)
	public String commentupdate(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {

		log.info("notice/commentupdate");
		
		String ss_user_id = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String user_id = request.getParameter("user_id");
		String user_no=CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		String seq=request.getParameter("notice_seq");
		String com_seq=request.getParameter("com_seq");
		String contents=request.getParameter("comment2");
		
		if(user_id.equals(ss_user_id)) {
		}else {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/notice/NoticeInfo.do?notice_seq="+seq);
			session.setAttribute("notice_seq",seq);
			return "/MsgToList";
		}
		
		if (contents.length() > 3000) {
			request.setAttribute("msg", "최대 3000자까지 입력 가능합니다.");
			request.setAttribute("url", "/notice/NoticeInfo.do?notice_seq="+seq);
			return "/MsgToList";
		}
		
		Comment_noticeDTO cDTO = new Comment_noticeDTO();
		
		cDTO.setChg_user_no(user_no);
		cDTO.setcom_seq(com_seq);
		cDTO.setnotice_seq(seq);
		cDTO.setContents(contents);
		
		System.out.println(user_no);
		System.out.println(seq);
		System.out.println(com_seq);
		System.out.println(contents);
		
		NoticeService.updateComment(cDTO);
		
		request.setAttribute("msg", "댓글을 수정하였습니다.");
		request.setAttribute("url", "/notice/NoticeInfo.do?notice_seq="+seq);
		session.setAttribute("notice_seq",seq);
		
		cDTO=null;
		
		return "/MsgToList";
	}
	
	@RequestMapping(value = "notice/NoticeInfo", method = RequestMethod.GET)
	public String NoticeInfo(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("NoIn");
		
		String seq= request.getParameter("notice_seq");
		if(seq==null) {
			seq= CmmUtil.nvl((String) session.getAttribute("com_notice_seq"));
		}
		String count=request.getParameter("count2");
		
		if(count==null) {
			count="0";
		}
		
		
		System.out.println(Integer.parseInt(count));
		
		int count2 = Integer.parseInt(count);
		
		if(count2!=0) {
			count2=count2-1;
		}
		
		System.out.println(count2);
		
		if(seq==null) {
			seq=CmmUtil.nvl((String) session.getAttribute("notice_seq"));
			session.setAttribute("notice_seq","");
		}
		
		session.setAttribute("com_notice_seq",seq);
		
		System.out.println(seq);
		
		String a=NoticeService.getNoticeUserid(seq);
		if(a==null) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/notice/NoticeList.do");
			return "/MsgToList";
		}
		
		NoticeDTO rDTO = new NoticeDTO();
		
		rDTO.setnotice_seq(seq);
		
		rDTO=NoticeService.getNoticeInfo(rDTO);
		
		model.addAttribute("rDTO", rDTO);
		request.setAttribute("count2", count2);
		session.setAttribute("count3", count2);
		rDTO=null;
		
		return "/notice/NoticeInfo";
	}
	
	@RequestMapping(value = "notice/NoticeInfo2", method = RequestMethod.GET)
	public String NoticeInfo2(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("NoIn2");
		
		String seq= CmmUtil.nvl((String) session.getAttribute("com_notice_seq"));
		String com_seq = request.getParameter("com_seq");
		int count2= (int) session.getAttribute("count3");
		System.out.println(count2);
		
		session.setAttribute("com_seq",com_seq);
		
		System.out.println(seq);
		System.out.println(com_seq);
		
		String a=NoticeService.getNoticeUserid(seq);
		if(a==null) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/notice/NoticeList.do");
			return "/MsgToList";
		}
		
		NoticeDTO rDTO = new NoticeDTO();
		
		rDTO.setnotice_seq(seq);
		
		rDTO=NoticeService.getNoticeInfo(rDTO);
		
		model.addAttribute("rDTO", rDTO);
		request.setAttribute("count3", count2);
		rDTO=null;
		
		return "/notice/NoticeInfo2";
	}
	
	@RequestMapping(value = "notice/NoticeDelete", method = RequestMethod.GET)
	public String NoticeDelete(HttpServletRequest request,HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("NoDel");
		
		
		String seq= request.getParameter("notice_seq");
		System.out.println(seq);
		
		NoticeDTO rDTO = new NoticeDTO();
		
		rDTO.setnotice_seq(seq);
		
		String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		
		if(SESSION_USER_ID.equals("admin")) {
			NoticeService.deleteCommentALL(seq);
			NoticeService.deleteNoticeInfo(rDTO);

			rDTO = null;

			request.setAttribute("msg", "게시글을 삭제하였습니다.");
		}else {
			rDTO = null;

			request.setAttribute("msg", "잘못된 접근입니다.");
		}
		request.setAttribute("url", "/notice/NoticeList.do");
		
		return "/MsgToList";
	}
	
	@RequestMapping(value = "notice/NoticeReg", method = RequestMethod.GET)
	public String NoticeReg(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("NoReg");
		
		return "/notice/NoticeReg";
	}
	
	@RequestMapping(value = "notice/NoticeInsert", method = RequestMethod.POST)
	public String NoticeInsert(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("NoInsert");
		
		String title= request.getParameter("title");
		String contents= request.getParameter("contents");
		String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		
		if(SESSION_USER_ID.equals("admin")||SESSION_USER_ID=="admin") {
		}else {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/notice/NoticeList.do");
			
			return "/MsgToList";
		}
		
		if (title.length() > 45) {
			request.setAttribute("msg", "제목은 최대 45자까지 입력 가능합니다.");
			request.setAttribute("url", "/notice/NoticeReg.do");
			return "/MsgToList";
		}
		
		if (contents.length() > 20000) {
			request.setAttribute("msg", "게시글은 최대 20000자까지 입력 가능합니다.");
			request.setAttribute("url", "/notice/NoticeReg.do");
			return "/MsgToList";
		}
		
		System.out.println(title);
		System.out.println(contents);
		System.out.println(SESSION_USER_ID);
		System.out.println(SESSION_USER_NO);
		
		NoticeDTO rDTO = new NoticeDTO();
		
		rDTO.setTitle(title);
		rDTO.setReg_user_no(SESSION_USER_NO);
		rDTO.setUser_id(SESSION_USER_ID);
		rDTO.setContents(contents);
		
		
		NoticeService.InsertNoticeInfo(rDTO);
		
		request.setAttribute("msg", "글 작성이 완료되었습니다.");
		request.setAttribute("url", "/notice/NoticeList.do");
		
		rDTO=null;
		
		return "/MsgToList";
	}
	
	@RequestMapping(value = "notice/NoticeEditInfo", method = RequestMethod.GET)
	public String NoticeEditInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("NoEdIn");
		
		String seq= request.getParameter("notice_seq");
		
		System.out.println(seq);
		
		String a=NoticeService.getNoticeUserid(seq);
		if(a==null) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/notice/NoticeList.do");
			return "/MsgToList";
		}
		
		NoticeDTO rDTO = new NoticeDTO();
		
		rDTO.setnotice_seq(seq);
		
		rDTO=NoticeService.getNoticeInfo(rDTO);
		model.addAttribute("rDTO", rDTO);
		
		rDTO=null;
		
		return "/notice/NoticeEditInfo";
	}
	
	@RequestMapping(value = "notice/NoticeUpdate", method = RequestMethod.POST)
	public String NoticeUpdate(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("NoUp");
		
		String ss_user_id = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String user_id = request.getParameter("user_id");
		String title= request.getParameter("title");
		
		String contents= request.getParameter("contents");
		String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		String seq = request.getParameter("notice_seq");
		
		if(user_id.equals(ss_user_id)) {
		}else {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/notice/NoticeInfo.do?notice_seq="+seq);
			session.setAttribute("notice_seq", seq);
			
			return "/MsgToList";
		}
		
		if (title.length() > 45) {
			request.setAttribute("msg", "제목은 최대 45자까지 입력 가능합니다.");
			request.setAttribute("url", "/notice/NoticeReg.do");
			return "/MsgToList";
		}
		
		if (contents.length() > 20000) {
			request.setAttribute("msg", "게시글은 최대 20000자까지 입력 가능합니다.");
			request.setAttribute("url", "/notice/NoticeReg.do");
			return "/MsgToList";
		}
		
		System.out.println(title);
		System.out.println(contents);
		System.out.println(SESSION_USER_NO);
		System.out.println(seq);
		
		NoticeDTO rDTO = new NoticeDTO();
		
		rDTO.setTitle(title);
		rDTO.setChg_user_no(SESSION_USER_NO);
		rDTO.setContents(contents);
		rDTO.setnotice_seq(seq);
		
		NoticeService.updateNoticeInfo(rDTO);
		
		request.setAttribute("msg", "글 수정이 완료되었습니다.");
		request.setAttribute("url", "/notice/NoticeInfo.do?notice_seq="+seq);
		session.setAttribute("notice_seq", seq);
		
		rDTO=null;
		
		return "/MsgToList";
	}
}