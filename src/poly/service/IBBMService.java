package poly.service;

import java.util.List;

import poly.dto.BBMDTO;
import poly.dto.Comment_bbmDTO;

public interface IBBMService {

	List<BBMDTO> getbbmList() throws Exception;
	
	List<BBMDTO> getbbmSearch(BBMDTO pDTO) throws Exception;

   void InsertbbmInfo(BBMDTO pDTO) throws Exception;

   BBMDTO getbbmInfo(BBMDTO pDTO) throws Exception;
   
   void updatebbmInfo(BBMDTO pDTO) throws Exception;

   void deletebbmInfo(BBMDTO pDTO) throws Exception;

   public BBMDTO insertComment(Comment_bbmDTO cdto)throws Exception;

   public BBMDTO deleteComment(Comment_bbmDTO cdto)throws Exception;
   
   public BBMDTO updateComment(Comment_bbmDTO cdto)throws Exception;

   void deleteCommentALL(String seq) throws Exception;
   
   String getCommentUserid(String bbm_seq) throws Exception;

   String getBBMUserid(String uDto) throws Exception;
}