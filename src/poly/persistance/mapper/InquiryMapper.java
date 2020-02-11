package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.InquiryDTO;
import poly.dto.Comment_inqDTO;

@Mapper("InquiryMapper")
public interface InquiryMapper {

   List<InquiryDTO> getinquiryList() throws Exception;

   void InsertinquiryInfo(InquiryDTO pDTO) throws Exception;

   void updateinquiryInfo(InquiryDTO pDTO) throws Exception;

   InquiryDTO getinquiryInfo(InquiryDTO pDTO) throws Exception;

   void deleteinquiryInfo(InquiryDTO pDTO) throws Exception;
   
   public void insertComment(Comment_inqDTO cdto) throws Exception;
	
	public void deleteComment(Comment_inqDTO cdto) throws Exception;
	
	public void updateComment(Comment_inqDTO cdto) throws Exception;

	public List<Comment_inqDTO> getComment(InquiryDTO rdto) throws Exception;

	void deleteCommentALL(String seq) throws Exception;
	
	String getCommentUserid(String uDto) throws Exception;

   String getInqUserid(String uDto) throws Exception;

}