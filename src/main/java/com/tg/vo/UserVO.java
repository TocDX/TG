package com.tg.vo;

import org.springframework.stereotype.Component;
import lombok.Data;

@Component    //--------------Spring <bean>  JPA:@Entity
@Data         //--------------lombok
public class UserVO {
	private int userSeq;
	private String userEmail;
	private String userPw;
	private String userName;
	private String userGubun;
	private String userPhone;
	private String regdate;
	private String profileImg;
}
