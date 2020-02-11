package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.BBMDTO;
import poly.dto.Comment_bbmDTO;
import poly.persistance.mapper.BBMMapper;
import poly.service.IBBMService;

@Service("BBMService")
public class BBMService implements IBBMService {
	@Resource(name = "BBMMapper")
	private BBMMapper bbmMapper;

	@Override
	public List<BBMDTO> getbbmList() throws Exception {
		return bbmMapper.getbbmList();

	}
	
	@Override
	public List<BBMDTO> getbbmSearch(BBMDTO pDTO) throws Exception {
		return bbmMapper.getbbmSearch(pDTO);

	}

	@Override
	public void InsertbbmInfo(BBMDTO pDTO) throws Exception {
		bbmMapper.InsertbbmInfo(pDTO);
		;

	}

	@Override
	public BBMDTO getbbmInfo(BBMDTO pDTO) throws Exception {
		BBMDTO rdto = bbmMapper.getbbmInfo(pDTO);
		
		List<Comment_bbmDTO> clist = bbmMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;

	}

	@Override
	public void updatebbmInfo(BBMDTO pDTO) throws Exception {
		bbmMapper.updatebbmInfo(pDTO);

	}

	@Override
	public void deletebbmInfo(BBMDTO pDTO) throws Exception {
		bbmMapper.deletebbmInfo(pDTO);

	}

	@Override
	public BBMDTO insertComment(Comment_bbmDTO cdto) throws Exception {
		bbmMapper.insertComment(cdto);
		BBMDTO rdto = new BBMDTO();
		rdto.setbbm_seq(cdto.getbbm_seq());
		rdto = bbmMapper.getbbmInfo(rdto);
		List<Comment_bbmDTO> clist = bbmMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;
	}
	
	public BBMDTO deleteComment(Comment_bbmDTO cdto) throws Exception {
		bbmMapper.deleteComment(cdto);
		BBMDTO rdto = new BBMDTO();
		rdto.setbbm_seq(cdto.getbbm_seq());
		rdto = bbmMapper.getbbmInfo(rdto);
		List<Comment_bbmDTO> clist = bbmMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;
	}
	
	public BBMDTO updateComment(Comment_bbmDTO cdto) throws Exception {
		bbmMapper.updateComment(cdto);
		BBMDTO rdto = new BBMDTO();
		rdto.setbbm_seq(cdto.getbbm_seq());
		rdto = bbmMapper.getbbmInfo(rdto);
		List<Comment_bbmDTO> clist = bbmMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;
	}
	
	@Override
	public void deleteCommentALL(String seq) throws Exception {
		bbmMapper.deleteCommentALL(seq);

	}

	@Override
	public String getCommentUserid(String uDto) throws Exception {
		// TODO Auto-generated method stub
		return bbmMapper.getCommentUserid(uDto);
	}
	
	@Override
	public String getBBMUserid(String uDto) throws Exception {
		// TODO Auto-generated method stub
		return bbmMapper.getBBMUserid(uDto);
	}
	
}