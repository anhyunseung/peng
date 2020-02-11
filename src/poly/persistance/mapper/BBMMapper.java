package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.BBMDTO;
import poly.dto.Comment_bbmDTO;

@Mapper("BBMMapper")
public interface BBMMapper {

	List<BBMDTO> getbbmList() throws Exception;
	
	List<BBMDTO> getbbmSearch(BBMDTO pDTO) throws Exception;

	void InsertbbmInfo(BBMDTO pDTO) throws Exception;

	BBMDTO getbbmInfo(BBMDTO pDTO) throws Exception;

	void updatebbmInfo(BBMDTO pDTO) throws Exception;

	void deletebbmInfo(BBMDTO pDTO) throws Exception;

	public void insertComment(Comment_bbmDTO cdto) throws Exception;
	
	public void deleteComment(Comment_bbmDTO cdto) throws Exception;
	
	public void updateComment(Comment_bbmDTO cdto) throws Exception;

	public List<Comment_bbmDTO> getComment(BBMDTO rdto) throws Exception;

	void deleteCommentALL(String seq) throws Exception;
	
	String getCommentUserid(String uDto) throws Exception;

	String getBBMUserid(String uDto) throws Exception;

}