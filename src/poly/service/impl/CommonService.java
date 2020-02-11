package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.CommonDTO;
import poly.persistance.mapper.CommonMapper;
import poly.service.ICommonService;

@Service("CommonService")
public class CommonService implements ICommonService {
   @Resource(name="CommonMapper")
   private CommonMapper commonMapper;
   
   @Override
	public List<CommonDTO> getNoticeList() throws Exception {
		return commonMapper.getNoticeList();

	}
   
   @Override
	public List<CommonDTO> getBBMList() throws Exception {
		return commonMapper.getBBMList();

	}
}