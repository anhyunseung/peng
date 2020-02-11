package poly.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import poly.dto.Comment_noticeDTO;
import poly.dto.NoticeDTO;
import poly.persistance.mapper.NoticeMapper;
import poly.service.INoticeService;

@Service("NoticeService")
public class NoticeService implements INoticeService {

	@Resource(name = "NoticeMapper")
	private NoticeMapper noticeMapper;

	@Override
	public List<NoticeDTO> getNoticeList() throws Exception {
		return noticeMapper.getNoticeList();

	}
	
	@Override
	public List<NoticeDTO> getNoticeSearch(NoticeDTO pDTO) throws Exception {
		return noticeMapper.getNoticeSearch(pDTO);

	}

	@Override
	public void InsertNoticeInfo(NoticeDTO pDTO) throws Exception {
		noticeMapper.InsertNoticeInfo(pDTO);
		;

	}

	@Override
	public NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception {
		NoticeDTO rdto = noticeMapper.getNoticeInfo(pDTO);
		
		List<Comment_noticeDTO> clist = noticeMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;

	}

	@Override
	public void updateNoticeInfo(NoticeDTO pDTO) throws Exception {
		noticeMapper.updateNoticeInfo(pDTO);

	}

	@Override
	public void deleteNoticeInfo(NoticeDTO pDTO) throws Exception {
		noticeMapper.deleteNoticeInfo(pDTO);

	}

	@Override
	public NoticeDTO insertComment(Comment_noticeDTO cdto) throws Exception {
		noticeMapper.insertComment(cdto);
		NoticeDTO rdto = new NoticeDTO();
		rdto.setnotice_seq(cdto.getnotice_seq());
		rdto = noticeMapper.getNoticeInfo(rdto);
		List<Comment_noticeDTO> clist = noticeMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;
	}
	
	@Override
	public NoticeDTO deleteComment(Comment_noticeDTO cdto) throws Exception {
		noticeMapper.deleteComment(cdto);
		NoticeDTO rdto = new NoticeDTO();
		rdto.setnotice_seq(cdto.getnotice_seq());
		rdto = noticeMapper.getNoticeInfo(rdto);
		List<Comment_noticeDTO> clist = noticeMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;
	}
	
	@Override
	public NoticeDTO updateComment(Comment_noticeDTO cdto) throws Exception {
		noticeMapper.updateComment(cdto);
		NoticeDTO rdto = new NoticeDTO();
		rdto.setnotice_seq(cdto.getnotice_seq());
		rdto = noticeMapper.getNoticeInfo(rdto);
		List<Comment_noticeDTO> clist = noticeMapper.getComment(rdto);
		rdto.setClist(clist);
		return rdto;
	}
	
	@Override
	public void deleteCommentALL(String seq) throws Exception {
		noticeMapper.deleteCommentALL(seq);

	}
	
	@Override
	public String getCommentUserid(String uDto) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.getCommentUserid(uDto);
	}
	
	@Override
	public String getNoticeUserid(String uDto) throws Exception {
		// TODO Auto-generated method stub
		return noticeMapper.getNoticeUserid(uDto);
	}
}