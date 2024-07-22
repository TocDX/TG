package com.tg.vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component    //--------------Spring <bean>  JPA:@Entity
@Data         //--------------lombok
public class ReplyVO {
	private int rseq;        	//PK
	private String reply;
	private int userSeq;    	//FK - users
	private String regdate;  	
	private int seq ;        	//FK - board
	
	private UserVO userVO;		//1:1
}
