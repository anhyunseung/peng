package poly.service;

import java.util.List;

import poly.dto.CommonDTO;

public interface ICommonService {
	
	List<CommonDTO> getNoticeList() throws Exception;
	
	List<CommonDTO> getBBMList() throws Exception;
}