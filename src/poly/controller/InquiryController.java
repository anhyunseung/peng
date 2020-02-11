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

import poly.dto.Comment_inqDTO;
import poly.dto.InquiryDTO;
import poly.service.IInquiryService;
import poly.util.CmmUtil;

@Controller
public class InquiryController {
private Logger log = Logger.getLogger(this.getClass());
   
   @Resource(name="InquiryService")
   private IInquiryService InquiryService;
   
   @RequestMapping(value="inquiry/inquiryList", method=RequestMethod.GET)
   public String Inquiry(HttpServletRequest request, HttpServletResponse response, 
         ModelMap model) throws Exception {
      
            log.info(this.getClass().getName() + ".inquiryList start!");
            
            List<InquiryDTO> rList = InquiryService.getinquiryList();
            
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
            
            if (rList==null){
               rList = new ArrayList<InquiryDTO>();
               
            }
            request.setAttribute("count", count2);
            model.addAttribute("rList", rList);
            
            rList = null;
            
            log.info(this.getClass().getName() + ".inquiryList end!");
            
      
      return "/inquiry/inquiryList";
   }
   
   @RequestMapping(value = "inquiry/inquiryInfo", method = RequestMethod.GET)
	public String inquiryInfo(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {

		System.out.println("inquiryIn");

		String seq = request.getParameter("inq_seq");
		if(seq==null) {
			seq= CmmUtil.nvl((String) session.getAttribute("com_inq_seq"));
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
			seq = CmmUtil.nvl((String) session.getAttribute("inq_seq"));
			session.setAttribute("inq_seq", "");
		}
		
		String a=InquiryService.getInqUserid(seq);
		if(a==null) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/inquiry/inquiryList.do");
			return "/MsgToList";
		}
		
		session.setAttribute("com_inq_seq", seq);

		System.out.println(seq);

		InquiryDTO rDTO = new InquiryDTO();

		rDTO.setinq_seq(seq);
		
		rDTO = InquiryService.getinquiryInfo(rDTO);

		model.addAttribute("rDTO", rDTO);
		request.setAttribute("count2", count2);
		session.setAttribute("count3", count2);
		rDTO = null;

		return "/inquiry/inquiryInfo";
	}

	@RequestMapping(value = "inquiry/inquiryInfo2", method = RequestMethod.GET)
	public String inquiryInfo2(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {

		System.out.println("inquiryIn2");

		String seq = CmmUtil.nvl((String) session.getAttribute("com_inq_seq"));
		String com_seq = request.getParameter("com_seq");
		int count2= (int) session.getAttribute("count3");
		System.out.println(count2);

		session.setAttribute("com_seq", com_seq);

		System.out.println(seq);
		System.out.println(com_seq);
		
		String a=InquiryService.getInqUserid(seq);
		if(a==null) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/inquiry/inquiryList.do");
			return "/MsgToList";
		}

		InquiryDTO rDTO = new InquiryDTO();

		rDTO.setinq_seq(seq);

		rDTO = InquiryService.getinquiryInfo(rDTO);

		model.addAttribute("rDTO", rDTO);
		request.setAttribute("count3", count2);
		rDTO = null;

		return "/inquiry/inquiryInfo2";
	}
	
	@SuppressWarnings("unused")
	@RequestMapping(value = "inquiry/commentreg", method = RequestMethod.POST)
	public String commentreg(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {

		log.info("inquiry/commentreg");

		String user_id = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String user_no = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		String seq = request.getParameter("inq_seq");
		String contents = request.getParameter("comment");
		
		if (contents.length() > 3000) {
			request.setAttribute("msg", "최대 3000자까지 입력 가능합니다.");
			request.setAttribute("url", "/inquiry/inquiryInfo.do?inq_seq="+seq);
			return "/MsgToList";
		}
		
		if (user_no == "") {
			session.setAttribute("inq_seq", seq);
			request.setAttribute("msg", "로그인 회원만 댓글을 작성할 수 있습니다.");
			request.setAttribute("url", "/inquiry/inquiryInfo.do?inq_seq="+seq);
			return "/MsgToList";
		}

		Comment_inqDTO cDTO = new Comment_inqDTO();

		cDTO.setUser_id(user_id);
		cDTO.setReg_user_no(user_no);
		cDTO.setinq_seq(seq);
		cDTO.setContents(contents);

		System.out.println(user_id);
		System.out.println(user_no);
		System.out.println(seq);
		System.out.println(contents);

		InquiryService.insertComment(cDTO);

		if (cDTO == null) {
			request.setAttribute("msg", "댓글입력에 실패하였습니다.");
			request.setAttribute("url", "/inquiry/inquiryInfo.do?inq_seq="+seq);
		} else {
			request.setAttribute("msg", "댓글을 작성하였습니다.");
			request.setAttribute("url", "/inquiry/inquiryInfo.do?inq_seq="+seq);
			session.setAttribute("inq_seq", seq);
		}
		cDTO=null;
		return "/MsgToList";
	}

	@SuppressWarnings("unused")
	@RequestMapping(value = "inquiry/commentdelete", method = RequestMethod.GET)
	public String commentdelete(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {

		log.info("inquiry/commentdelete");

		String inq_seq = CmmUtil.nvl((String) session.getAttribute("com_inq_seq"));
		session.setAttribute("com_inq_seq", "");
		String com_seq = request.getParameter("com_seq");
		String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		
		Comment_inqDTO cDTO = new Comment_inqDTO();
		
		cDTO.setinq_seq(inq_seq);
		cDTO.setcom_seq(com_seq);

		System.out.println(com_seq);
		System.out.println(inq_seq);
		String a=InquiryService.getCommentUserid(com_seq);
		System.out.println(a);
		if(a.equals(SESSION_USER_ID) || SESSION_USER_ID.equals("admin")) {
			InquiryService.deleteComment(cDTO);

			cDTO = null;

			request.setAttribute("msg", "댓글을 삭제하였습니다.");
			
		}else {
			cDTO = null;

			request.setAttribute("msg", "잘못된 접근입니다.");
			
		}
		request.setAttribute("url", "/inquiry/inquiryInfo.do?inq_seq="+inq_seq);
		session.setAttribute("inq_seq", inq_seq);

		return "/MsgToList";
	}

	@SuppressWarnings("unused")
	@RequestMapping(value = "inquiry/commentupdate", method = RequestMethod.POST)
	public String commentupdate(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {

		log.info("inquiry/commentupdate");
		
		String ss_user_id = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String user_id = request.getParameter("user_id");
		String user_no = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		String seq = request.getParameter("inq_seq");
		String com_seq = request.getParameter("com_seq");
		String contents = request.getParameter("comment2");
		
		if(user_id.equals(ss_user_id)) {
		}else {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/inquiry/inquiryList.do");
			return "/MsgToList";
		}
		
		if (contents.length() > 3000) {
			request.setAttribute("msg", "최대 3000자까지 입력 가능합니다.");
			request.setAttribute("url", "/inquiry/inquiryInfo.do?inq_seq="+seq);
			return "/MsgToList";
		}

		Comment_inqDTO cDTO = new Comment_inqDTO();

		cDTO.setChg_user_no(user_no);
		cDTO.setcom_seq(com_seq);
		cDTO.setinq_seq(seq);
		cDTO.setContents(contents);

		System.out.println(user_no);
		System.out.println(seq);
		System.out.println(com_seq);
		System.out.println(contents);

		InquiryService.updateComment(cDTO);
		
		System.out.println("?1");
		
		request.setAttribute("msg", "댓글을 수정하였습니다.");
		request.setAttribute("url", "/inquiry/inquiryInfo.do?inq_seq="+seq);
		session.setAttribute("inq_seq", seq);

		cDTO = null;

		return "/MsgToList";
	}
	
	@RequestMapping(value = "inquiry/inquiryDelete", method = RequestMethod.GET)
	public String InquiryDelete(HttpServletRequest request,HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("inqDel");
		
		String seq= request.getParameter("inq_seq");
		System.out.println(seq);
		
		InquiryDTO rDTO = new InquiryDTO();
		
		rDTO.setinq_seq(seq);
		
		String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String a=InquiryService.getInqUserid(seq);
		System.out.println(a);
		
		if(a.equals(SESSION_USER_ID)) {
			InquiryService.deleteCommentALL(seq);
			InquiryService.deleteinquiryInfo(rDTO);

			rDTO = null;

			request.setAttribute("msg", "문의내역을 삭제하였습니다.");
		}else {
			rDTO = null;

			request.setAttribute("msg", "잘못된 접근입니다.");
		}
		request.setAttribute("url", "/inquiry/inquiryList.do");
		
		return "/MsgToList";
	}
	
	@RequestMapping(value = "inquiry/inquiryReg", method = RequestMethod.GET)
	public String InquiryReg(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("inqReg");
		
		return "/inquiry/inquiryReg";
	}
	
	@RequestMapping(value = "inquiry/inquiryInsert", method = RequestMethod.POST)
	public String InquiryInsert(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("inqInsert");
		
		String title= request.getParameter("title");
		
		String contents= request.getParameter("contents");
		String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		String SESSION_USER_ID = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		
		if(SESSION_USER_ID.isEmpty()||SESSION_USER_ID.equals("admin")||SESSION_USER_ID=="admin") {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/inquiry/inquiryList.do");
			
			return "/MsgToList";
		}
		
		if (title.length() > 45) {
			request.setAttribute("msg", "제목은 최대 45자까지 입력 가능합니다.");
			request.setAttribute("url", "/inquiry/inquiryReg.do");
			return "/MsgToList";
		}
		
		if (contents.length() > 20000) {
			request.setAttribute("msg", "게시글은 최대 20000자까지 입력 가능합니다.");
			request.setAttribute("url", "/inquiry/inquiryReg.do");
			return "/MsgToList";
		}
		
		System.out.println(title);
		System.out.println(contents);
		System.out.println(SESSION_USER_NO);
		System.out.println(SESSION_USER_ID);
		
		InquiryDTO rDTO = new InquiryDTO();
		
		rDTO.setTitle(title);
		rDTO.setReg_user_no(SESSION_USER_NO);
		rDTO.setUser_id(SESSION_USER_ID);
		rDTO.setContents(contents);
		
		InquiryService.InsertinquiryInfo(rDTO);
		
		request.setAttribute("msg", "글 작성이 완료되었습니다.");
		request.setAttribute("url", "/inquiry/inquiryList.do");
		
		rDTO=null;
		
		return "/MsgToList";
	}
	
	@RequestMapping(value = "inquiry/inquiryEditInfo", method = RequestMethod.GET)
	public String InquiryEditInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("inqEdIn");
		
		String seq= request.getParameter("inq_seq");
		
		System.out.println(seq);
		
		String a=InquiryService.getInqUserid(seq);
		if(a==null) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/inquiry/inquiryList.do");
			return "/MsgToList";
		}
		
		InquiryDTO rDTO = new InquiryDTO();
		
		rDTO.setinq_seq(seq);
		
		rDTO=InquiryService.getinquiryInfo(rDTO);
		model.addAttribute("rDTO", rDTO);
		
		rDTO=null;
		
		return "/inquiry/inquiryEditInfo";
	}
	
	@RequestMapping(value = "inquiry/inquiryUpdate", method = RequestMethod.POST)
	public String InquiryUpdate(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {
		
		System.out.println("inqUp");
		
		String ss_user_id = CmmUtil.nvl((String) session.getAttribute("USER_ID"));
		String user_id = request.getParameter("user_id");
		String title= request.getParameter("title");
		String contents= request.getParameter("contents");
		String SESSION_USER_NO = CmmUtil.nvl((String) session.getAttribute("USER_NO"));
		String seq = request.getParameter("inq_seq");
		
		if(user_id.equals(ss_user_id)) {
		}else {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "/inquiry/inquiryList.do");
			
			return "/MsgToList";
		}
		
		if (title.length() > 45) {
			request.setAttribute("msg", "제목은 최대 45자까지 입력 가능합니다.");
			request.setAttribute("url", "/inquiry/inquiryReg.do");
			return "/MsgToList";
		}
		
		if (contents.length() > 20000) {
			request.setAttribute("msg", "게시글은 최대 20000자까지 입력 가능합니다.");
			request.setAttribute("url", "/inquiry/inquiryReg.do");
			return "/MsgToList";
		}
		
		System.out.println(title);
		System.out.println(contents);
		System.out.println(SESSION_USER_NO);
		System.out.println(seq);
		
		InquiryDTO rDTO = new InquiryDTO();
		
		rDTO.setTitle(title);
		rDTO.setChg_user_no(SESSION_USER_NO);
		rDTO.setContents(contents);
		rDTO.setinq_seq(seq);
		
		InquiryService.updateinquiryInfo(rDTO);
		
		request.setAttribute("msg", "글 수정이 완료되었습니다.");
		request.setAttribute("url", "/inquiry/inquiryInfo.do?inq_seq="+seq);
		session.setAttribute("inq_seq", seq);
		
		rDTO=null;
		
		return "/MsgToList";
	}
   
   
}