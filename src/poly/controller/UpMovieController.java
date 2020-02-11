package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import poly.service.ICommonService;


@Controller
public class UpMovieController {
   private Logger log = Logger.getLogger(this.getClass());
    
   @Resource(name="CommonService")
   private ICommonService commonService;
   
   @RequestMapping(value="/upmovie/upmovieList", method=RequestMethod.GET)
   public String upmovieList(HttpServletRequest request, HttpServletResponse response, 
         ModelMap model) throws Exception {
	   
	   log.info("upmovieList");
	   
	   String count=request.getParameter("count");
		
		if(count==null) {
			count="0";
		}
		
		
		System.out.println(Integer.parseInt(count));
		
		int count2 = Integer.parseInt(count);
		
		System.out.println(count2);
		
		request.setAttribute("count", count2);

      return "/upmovie/upmovieList";
   }
   
   @RequestMapping(value="/upmovie/upmovieDate", method=RequestMethod.POST)
   public String upmovieDate(HttpServletRequest request,HttpSession session, HttpServletResponse response, 
         ModelMap model) throws Exception {
	   
	   log.info("upmovieDate");
	   
	   String year=request.getParameter("year");
		
	   String month=request.getParameter("month");
		
		int count2 = 0;
		
		request.setAttribute("count", count2);
		session.setAttribute("upmyear", year);
		session.setAttribute("upmmonth", month);

      return "/upmovie/upmovieList";
   }
}