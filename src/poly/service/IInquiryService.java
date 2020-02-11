package poly.service;

import java.util.List;

import poly.dto.Comment_inqDTO;
import poly.dto.InquiryDTO;

public interface IInquiryService {
   
   List<InquiryDTO> getinquiryList() throws Exception;
   
   void InsertinquiryInfo(InquiryDTO pDTO) throws Exception;

   InquiryDTO getinquiryInfo(InquiryDTO pDTO) throws Exception;
   
   void updateinquiryInfo(InquiryDTO pDTO) throws Exception;
   
   void deleteinquiryInfo(InquiryDTO pDTO) throws Exception;
   
   public InquiryDTO insertComment(Comment_inqDTO cdto)throws Exception;

   public InquiryDTO deleteComment(Comment_inqDTO cdto)throws Exception;
   
   public InquiryDTO updateComment(Comment_inqDTO cdto)throws Exception;

   void deleteCommentALL(String seq) throws Exception;
   
   String getCommentUserid(String inq_seq) throws Exception;

   String getInqUserid(String seq) throws Exception;
}