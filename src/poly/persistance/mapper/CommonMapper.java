package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.CommonDTO;

@Mapper("CommonMapper")
public interface CommonMapper {
	List<CommonDTO> getNoticeList() throws Exception;
	
	List<CommonDTO> getBBMList() throws Exception;

}