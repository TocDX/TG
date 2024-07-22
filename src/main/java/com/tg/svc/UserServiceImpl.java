package com.tg.svc;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.tg.mappers.UserMapper;
import com.tg.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    @Override
    public int svcUserInsert(UserVO uvo) {
        return userMapper.userInsert(uvo);
    }

    @Override
    public ArrayList<UserVO> svcUserSelectAll() {
        return userMapper.allUser();
    }

    
    @Override
    public int svcUserUpdate(UserVO uvo) {
        return userMapper.userUpdate(uvo);
    }

    @Override
    public int svcUserDelete(int userSeq) {
        return userMapper.userDelete(userSeq);
    }

	@Override
	public UserVO svcUserSelectOne(int userSeq) {
		return userMapper.userSelectOne(userSeq);
	}

	@Override
	public UserVO svcUserLogin(UserVO uvo) {
		return userMapper.userLogin(uvo);
	}
}

