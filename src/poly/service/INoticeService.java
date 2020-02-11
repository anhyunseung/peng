 package poly.service;

import java.util.List;

import poly.dto.Comment_noticeDTO;
import poly.dto.NoticeDTO;

public interface INoticeService {

	List<NoticeDTO> getNoticeList() throws Exception;
	
	List<NoticeDTO> getNoticeSearch(NoticeDTO pDTO) throws Exception;
   
   void InsertNoticeInfo(NoticeDTO pDTO) throws Exception;

   NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception;
   
   void updateNoticeInfo(NoticeDTO pDTO) throws Exception;
   
   void deleteNoticeInfo(NoticeDTO pDTO) throws Exception;
   
   public NoticeDTO insertComment(Comment_noticeDTO cdto)throws Exception;
   
   public NoticeDTO deleteComment(Comment_noticeDTO cdto)throws Exception;
   
   public NoticeDTO updateComment(Comment_noticeDTO cdto)throws Exception;

   void deleteCommentALL(String seq) throws Exception;

   String getCommentUserid(String com_seq) throws Exception;
   
   String getNoticeUserid(String seq) throws Exception;

}