package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import poly.dto.UserDTO;
import poly.persistance.mapper.UserMapper;
import poly.service.IUserService;

@Service("UserService")
public class UserService implements IUserService {
	@Resource(name = "UserMapper")
	private UserMapper userMapper;

	@Override
	public List<UserDTO> getUserList() throws Exception {
		return userMapper.getUserList();

	}

	@Override
	public UserDTO getUserInfo(UserDTO pDTO) throws Exception {
		return userMapper.getUserInfo(pDTO);

	}

	@Override
	public void updateUserInfo(UserDTO pDTO) throws Exception {
		userMapper.updateUserInfo(pDTO);

	}

	@Override
	public void deleteUserInfo(UserDTO pDTO) throws Exception {
		userMapper.deleteUserInfo(pDTO);

	}

	@Override
	public void userJoin(UserDTO uDto) throws Exception {

		userMapper.userJoin(uDto);
	}

	@Override
	public String userLogin(UserDTO uDto) throws Exception {
			return userMapper.userLogin(uDto);
	}

	@Override
	public String userIdsearch(UserDTO uDto) throws Exception {
		return userMapper.userIdsearch(uDto);
	}

	@Override
	public String userPwsearch(UserDTO uDto) throws Exception {
		// TODO Auto-generated method stub
			return userMapper.userPwsearch(uDto);
	}

	@Override
	public void updatePw(UserDTO uDto) throws Exception {
		// TODO Auto-generated method stub
		userMapper.updatePw(uDto);

	}
	
	@Override
	public void updateId(UserDTO uDto) throws Exception {
		// TODO Auto-generated method stub
		userMapper.updateId(uDto);

	}
	
	@Override
	public void updateemail(UserDTO uDto) throws Exception {
		// TODO Auto-generated method stub
		userMapper.updateemail(uDto);

	}

	@Override
	public String getidover(UserDTO uDto) throws Exception {
		return userMapper.getidover(uDto);

	}
	
	@Override
	public String getemailover(UserDTO uDto) throws Exception {
		return userMapper.getemailover(uDto);

	}
	
	@Override
	public String getUserid(String uDto) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getUserid(uDto);
	}
}