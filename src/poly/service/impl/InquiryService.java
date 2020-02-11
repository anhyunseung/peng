package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.InquiryDTO;
import poly.dto.Comment_inqDTO;
import poly.persistance.mapper.InquiryMapper;
import poly.service.IInquiryService;

@Service("InquiryService")
public class InquiryService implements IInquiryService{
   
   @Resource(name="InquiryMapper")
   private InquiryMapper inquiryMapper;

   @Override
   public List<InquiryDTO> getinquiryList() throws Exception {
      // TODO Auto-generated method stub
      return inquiryMapper.getinquiryList();
   }

   @Override
   public void InsertinquiryInfo(InquiryDTO pDTO) throws Exception {
      // TODO Auto-generated method stub
      inquiryMapper.InsertinquiryInfo(pDTO);;
   }

   @Override
   public InquiryDTO getinquiryInfo(InquiryDTO pDTO) throws Exception {
      // TODO Auto-generated method stub
	   InquiryDTO rdto = inquiryMapper.getinquiryInfo(pDTO);
		
		List<Comment_inqDTO> clist = inquiryMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;
   }

   @Override
   public void updateinquiryInfo(InquiryDTO pDTO) throws Exception {
      // TODO Auto-generated method stub
      inquiryMapper.updateinquiryInfo(pDTO);
   }

   @Override
   public void deleteinquiryInfo(InquiryDTO pDTO) throws Exception {
      // TODO Auto-generated method stub
      inquiryMapper.deleteinquiryInfo(pDTO);
   }
   
   @Override
	public InquiryDTO insertComment(Comment_inqDTO cdto) throws Exception {
		inquiryMapper.insertComment(cdto);
		InquiryDTO rdto = new InquiryDTO();
		rdto.setinq_seq(cdto.getinq_seq());
		rdto = inquiryMapper.getinquiryInfo(rdto);
		List<Comment_inqDTO> clist = inquiryMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;
	}
	
	public InquiryDTO deleteComment(Comment_inqDTO cdto) throws Exception {
		inquiryMapper.deleteComment(cdto);
		InquiryDTO rdto = new InquiryDTO();
		rdto.setinq_seq(cdto.getinq_seq());
		rdto = inquiryMapper.getinquiryInfo(rdto);
		List<Comment_inqDTO> clist = inquiryMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;
	}
	
	public InquiryDTO updateComment(Comment_inqDTO cdto) throws Exception {
		inquiryMapper.updateComment(cdto);
		InquiryDTO rdto = new InquiryDTO();
		rdto.setinq_seq(cdto.getinq_seq());
		rdto = inquiryMapper.getinquiryInfo(rdto);
		List<Comment_inqDTO> clist = inquiryMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;
	}
	
	@Override
	public void deleteCommentALL(String seq) throws Exception {
		inquiryMapper.deleteCommentALL(seq);

	}

	@Override
	public String getCommentUserid(String uDto) throws Exception {
		// TODO Auto-generated method stub
		return inquiryMapper.getCommentUserid(uDto);
	}
   
   @Override
	public String getInqUserid(String uDto) throws Exception {
		// TODO Auto-generated method stub
		return inquiryMapper.getInqUserid(uDto);
	}
}