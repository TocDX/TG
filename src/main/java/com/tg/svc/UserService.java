package com.tg.svc;

import java.util.ArrayList;
import com.tg.vo.UserVO;

public interface UserService {
    int svcUserInsert(UserVO uvo);

    ArrayList<UserVO> svcUserSelectAll();
    UserVO svcUserSelectOne(int userSeq);
    UserVO svcUserLogin(UserVO uvo);
    
    int svcUserUpdate(UserVO uvo);
    int svcUserDelete(int userSeq);
}
