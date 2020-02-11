package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import poly.service.ICommonService;


@Controller
public class NewMovieController {
   private Logger log = Logger.getLogger(this.getClass());
    
   @Resource(name="CommonService")
   private ICommonService commonService;
   
   @RequestMapping(value="/newmovie/newmovieList", method=RequestMethod.GET)
   public String Top4(HttpServletRequest request, HttpServletResponse response, 
         ModelMap model) throws Exception {
	   
	   log.info("newmovieList");

      return "/newmovie/newmovieList";
   }
}