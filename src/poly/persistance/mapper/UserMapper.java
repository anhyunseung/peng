package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.UserDTO;
 
@Mapper("UserMapper")
public interface UserMapper {
   public void userJoin(UserDTO uDto) throws Exception;
   
   String userLogin(UserDTO uDto) throws Exception;
   
   String userIdsearch(UserDTO uDto) throws Exception;

   String userPwsearch(UserDTO uDto) throws Exception;
   
   void updatePw(UserDTO uDto) throws Exception;
   
   void updateId(UserDTO uDto) throws Exception;
   
   void updateemail(UserDTO uDto) throws Exception;

   List<UserDTO> getUserList() throws Exception;
   
   void updateUserInfo(UserDTO pDTO) throws Exception;

   public UserDTO getUserInfo(UserDTO pDTO) throws Exception;

   public void deleteUserInfo(UserDTO pDTO) throws Exception;

   String getidover(UserDTO uDto) throws Exception;

   String getemailover(UserDTO uDto) throws Exception;
   
   String getUserid(String uDto) throws Exception;
}