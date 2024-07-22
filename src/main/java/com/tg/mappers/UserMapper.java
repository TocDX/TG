package com.tg.mappers;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.tg.vo.UserVO;

@Repository
@Mapper
public interface UserMapper {

    int userInsert(UserVO uvo);
    
    ArrayList<UserVO> allUser();
    
    UserVO userSelectOne(int uesrSeq);
    UserVO userLogin(UserVO uvo);
    
    int userUpdate(UserVO uvo);
    
    int userDelete(int userSeq);
    
}
