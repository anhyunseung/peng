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

import poly.dto.BBMDTO;
import poly.dto.Comment_bbmDTO;
import poly.service.IBBMService;
import poly.util.CmmUtil;

@Controller
public class BBMController {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "BBMService")
	private IBBMService bbmService;

	@RequestMapping(value = "bbm/bbmList", method = RequestMethod.GET)
	public String BBM_List(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		log.info(this.getClass().getName() + ".bbmList start!");

		List<BBMDTO> rList = bbmService.getbbmList();
		
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
			rList = new ArrayList<BBMDTO>();

		}
		request.setAttribute("count", count2);
		model.addAttribute("rList", rList);

		rList = null;

		return "bbm/bbmList";
	}
	
	@RequestMapping(value = "bbm/bbmSearch", method = RequestMethod.GET)
	public String BBM_Search(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		log.info(this.getClass().getName() + ".bbmSearch start!");
		String find=request.getParameter("find");
		
		System.out.println(find);
		
		String find2 = "%"+find+"%";
		BBMDTO rDTO = new BBMDTO();
		
		rDTO.setSearch(find2);
		List<BBMDTO> rList = bbmService.getbbmSearch(rDTO);
		
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
			rList = new ArrayList<BBMDTO>();

		}
		request.setAttribute("count", count2);
		model.addAttribute("rList", rList);
		request.setAttribute("find", find);
		rList = null;

		return "bbm/bbmSearch";
	}

	@RequestMapping(value = "bbm/bbmInfo", method = RequestMethod.GET)
	public String bbmInfo(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {

		System.out.println("bbmIn");

		String seq = request.getParameter("bbm_seq");
		if(seq==null) {
			seq= CmmUtil.nvl((String) session.getAttribute("com_bbm_seq"));
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
		
		if (seq == null) {
			seq = CmmUtil.nvl((String) session.getAttribute("bbm_seq"));
			session.setAttribute("bbm_seq", "");
		}
		
		session.setAttribute("com_bbm_seq", seq);

		System.out.println(seq);
		
		String a=bbmService.getBBMUserid(seq);
		if(a==null) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/bbm/bbmList.do");
			return "/MsgToList";
		}

		BBMDTO rDTO = new BBMDTO();

		rDTO.setbbm_seq(seq);

		rDTO = bbmService.getbbmInfo(rDTO);

		model.addAttribute("rDTO", rDTO);
		request.setAttribute("count2", count2);
		session.setAttribute("count3", count2);
		rDTO = null;

		return "/bbm/bbmInfo";
	}

	@RequestMapping(value = "bbm/bbmInfo2", method = RequestMethod.GET)
	public String bbmInfo2(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {

		System.out.println("bbmIn2");

		String seq = CmmUtil.nvl((String) session.getAttribute("com_bbm_seq"));
		String com_seq = request.getParameter("com_seq");
		int count2= (int) session.getAttribute("count3");
		System.out.println(count2);

		session.setAttribute("com_seq", com_seq);

		System.out.println(seq);
		System.out.println(com_seq);
		
		String a=bbmService.getBBMUserid(seq);
		if(a==null) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/bbm/bbmList.do");
			return "/MsgToList";
		}

		BBMDTO rDTO = new BBMDTO();

		rDTO.setbbm_seq(seq);

		rDTO = bbmService.getbbmInfo(rDTO);

		model.addAttribute("rDTO", rDTO);
		request.setAttribute("count3", count2);
		rDTO = null;

		return "/bbm/bbmInfo2";
	}

	@SuppressWarnings("unused")
	@RequestMapping(value = "bbm/commentreg", method = RequestMethod.POST)
	public String commentreg(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {

		log.info("bbm/commentreg");

		String user_id = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String user_no = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		String seq = request.getParameter("bbm_seq");
		String contents = request.getParameter("comment");
		
		if (contents.length() > 3000) {
			request.setAttribute("msg", "최대 3000자까지 입력 가능합니다.");
			request.setAttribute("url", "/bbm/bbmInfo.do?bbm_seq="+seq);
			return "/MsgToList";
		}
		
		if (user_no == "") {
			session.setAttribute("bbm_seq", seq);
			request.setAttribute("msg", "로그인 회원만 댓글을 작성할 수 있습니다.");
			request.setAttribute("url", "/bbm/bbmInfo.do?bbm_seq="+seq);
			return "/MsgToList";
		}

		Comment_bbmDTO cDTO = new Comment_bbmDTO();

		cDTO.setUser_id(user_id);
		cDTO.setReg_user_no(user_no);
		cDTO.setbbm_seq(seq);
		cDTO.setContents(contents);

		System.out.println(user_id);
		System.out.println(user_no);
		System.out.println(seq);
		System.out.println(contents);

		bbmService.insertComment(cDTO);

		if (cDTO == null) {
			request.setAttribute("msg", "댓글입력에 실패하였습니다.");
			request.setAttribute("url", "/bbm/bbmInfo.do?bbm_seq="+seq);
		} else {
			request.setAttribute("msg", "댓글을 작성하였습니다.");
			request.setAttribute("url", "/bbm/bbmInfo.do?bbm_seq="+seq);
			session.setAttribute("bbm_seq", seq);
		}
		
		cDTO=null;
		
		return "/MsgToList";
	}

	@SuppressWarnings("unused")
	@RequestMapping(value = "bbm/commentdelete", method = RequestMethod.GET)
	public String commentdelete(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {

		log.info("bbm/commentdelete");

		String bbm_seq = CmmUtil.nvl((String) session.getAttribute("com_bbm_seq"));
		session.setAttribute("com_bbm_seq", "");
		String com_seq = request.getParameter("com_seq");
		String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		
		Comment_bbmDTO cDTO = new Comment_bbmDTO();
		
		cDTO.setbbm_seq(bbm_seq);
		cDTO.setcom_seq(com_seq);

		System.out.println(com_seq);
		System.out.println(bbm_seq);
		String a=bbmService.getCommentUserid(com_seq);
		System.out.println(a);
		if(a.equals(SESSION_USER_ID) || SESSION_USER_ID.equals("admin")) {
			bbmService.deleteComment(cDTO);

			cDTO = null;

			request.setAttribute("msg", "댓글을 삭제하였습니다.");
			
		}else {
			cDTO = null;

			request.setAttribute("msg", "잘못된 접근입니다.");
			
		}
		request.setAttribute("url", "/bbm/bbmInfo.do?bbm_seq="+bbm_seq);
		session.setAttribute("bbm_seq", bbm_seq);

		return "/MsgToList";
	}

	@SuppressWarnings("unused")
	@RequestMapping(value = "bbm/commentupdate", method = RequestMethod.POST)
	public String commentupdate(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {

		log.info("bbm/commentupdate");

		String ss_user_id = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String user_id = request.getParameter("user_id");
		String user_no = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		String seq = request.getParameter("bbm_seq");
		String com_seq = request.getParameter("com_seq");
		String contents = request.getParameter("comment2");
		
		if(user_id.equals(ss_user_id)) {
		}else {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/bbm/bbmInfo.do?bbm_seq="+seq);
			session.setAttribute("bbm_seq", seq);
			return "/MsgToList";
		}
		
		if (contents.length() > 3000) {
			request.setAttribute("msg", "최대 3000자까지 입력 가능합니다.");
			request.setAttribute("url", "/bbm/bbmInfo.do?bbm_seq="+seq);
			return "/MsgToList";
		}

		Comment_bbmDTO cDTO = new Comment_bbmDTO();

		cDTO.setChg_user_no(user_no);
		cDTO.setcom_seq(com_seq);
		cDTO.setbbm_seq(seq);
		cDTO.setContents(contents);

		System.out.println(user_no);
		System.out.println(seq);
		System.out.println(com_seq);
		System.out.println(contents);

		bbmService.updateComment(cDTO);
		
		System.out.println("?1");
		
		request.setAttribute("msg", "댓글을 수정하였습니다.");
		request.setAttribute("url", "/bbm/bbmInfo.do?bbm_seq="+seq);
		session.setAttribute("bbm_seq", seq);

		cDTO = null;

		return "/MsgToList";
	}

	@RequestMapping(value = "bbm/bbmDelete", method = RequestMethod.GET)
	public String bbmDelete(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {

		System.out.println("bbmDel");

		String seq = request.getParameter("bbm_seq");
		System.out.println(seq);

		BBMDTO rDTO = new BBMDTO();

		rDTO.setbbm_seq(seq);
		
		String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String a=bbmService.getBBMUserid(seq);
		System.out.println(a);
		
		if(a.equals(SESSION_USER_ID) || SESSION_USER_ID.equals("admin")) {
			bbmService.deleteCommentALL(seq);
			bbmService.deletebbmInfo(rDTO);

			rDTO = null;

			request.setAttribute("msg", "게시글을 삭제하였습니다.");
		}else {
			rDTO = null;

			request.setAttribute("msg", "잘못된 접근입니다.");
		}
		request.setAttribute("url", "/bbm/bbmList.do");

		return "/MsgToList";
	}

	@RequestMapping(value = "bbm/bbmReg", method = RequestMethod.GET)
	public String bbmReg(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		System.out.println("bbmReg");

		return "/bbm/bbmReg";
	}

	@RequestMapping(value = "bbm/bbmInsert", method = RequestMethod.POST)
	public String bbmInsert(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {

		System.out.println("bbmInsert");

		String title = request.getParameter("title");

		String contents = request.getParameter("contents");
		String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		
		if(SESSION_USER_ID.isEmpty()) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/bbm/bbmList.do");
			
			return "/MsgToList";
		}
		
		if (title.length() > 45) {
			request.setAttribute("msg", "제목은 최대 45자까지 입력 가능합니다.");
			request.setAttribute("url", "/bbm/bbmReg.do");
			return "/MsgToList";
		}
		
		if (contents.length() > 20000) {
			request.setAttribute("msg", "게시글은 최대 20000자까지 입력 가능합니다.");
			request.setAttribute("url", "/bbm/bbmReg.do");
			return "/MsgToList";
		}

		System.out.println(title);
		System.out.println(contents);
		System.out.println(SESSION_USER_ID);
		System.out.println(SESSION_USER_NO);

		BBMDTO rDTO = new BBMDTO();

		rDTO.setTitle(title);
		rDTO.setReg_user_no(SESSION_USER_NO);
		rDTO.setUser_id(SESSION_USER_ID);
		rDTO.setContents(contents);

		bbmService.InsertbbmInfo(rDTO);

		request.setAttribute("msg", "글 작성이 완료되었습니다.");
		request.setAttribute("url", "/bbm/bbmList.do");

		rDTO = null;

		return "/MsgToList";
	}

	@RequestMapping(value = "bbm/bbmEditInfo", method = RequestMethod.GET)
	public String bbmEditInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {

		System.out.println("bbmEdIn");

		String seq = request.getParameter("bbm_seq");

		System.out.println(seq);
		
		String a=bbmService.getBBMUserid(seq);
		if(a==null) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/bbm/bbmList.do");
			return "/MsgToList";
		}

		BBMDTO rDTO = new BBMDTO();

		rDTO.setbbm_seq(seq);

		rDTO = bbmService.getbbmInfo(rDTO);
		model.addAttribute("rDTO", rDTO);

		rDTO = null;

		return "/bbm/bbmEditInfo";
	}

	@RequestMapping(value = "bbm/bbmUpdate", method = RequestMethod.POST)
	public String bbmUpdate(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {

		System.out.println("bbmUp");

		String ss_user_id = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String user_id = request.getParameter("user_id");
		String title = request.getParameter("title");

		String contents = request.getParameter("contents");
		String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		String seq = request.getParameter("bbm_seq");

		if(user_id.equals(ss_user_id)) {
		}else {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/bbm/bbmInfo.do?bbm_seq="+seq);
			session.setAttribute("bbm_seq", seq);
			
			return "/MsgToList";
		}
		
		if (title.length() > 45) {
			request.setAttribute("msg", "제목은 최대 45자까지 입력 가능합니다.");
			request.setAttribute("url", "/bbm/bbmReg.do");
			return "/MsgToList";
		}
		
		if (contents.length() > 20000) {
			request.setAttribute("msg", "게시글은 최대 20000자까지 입력 가능합니다.");
			request.setAttribute("url", "/bbm/bbmReg.do");
			return "/MsgToList";
		}

		System.out.println(title);
		System.out.println(contents);
		System.out.println(SESSION_USER_NO);
		System.out.println(seq);

		BBMDTO rDTO = new BBMDTO();

		rDTO.setTitle(title);
		rDTO.setChg_user_no(SESSION_USER_NO);
		rDTO.setContents(contents);
		rDTO.setbbm_seq(seq);

		bbmService.updatebbmInfo(rDTO);

		request.setAttribute("msg", "글 수정이 완료되었습니다.");
		request.setAttribute("url", "/bbm/bbmInfo.do?bbm_seq="+seq);
		session.setAttribute("bbm_seq", seq);

		rDTO = null;

		return "/MsgToList";
	}
}