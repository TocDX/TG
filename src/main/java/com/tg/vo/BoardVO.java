package com.tg.vo;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component    //--------------Spring <bean>  JPA:@Entity
@Data         //--------------lombok
public class BoardVO {
	private int seq;            //PK sequence
	private String title;
	private String contents;
	
	private int userSeq;      	//FK
	private String regdate;     
	List<ReplyVO> replies;      //1:N
	List<FileVO> files;			//1:N
	UserVO userVO;				//1:1
	
	//--------- 페이징 프로퍼티 -----------
	int startSeq = 1;
	int endSeq = 1;
	int currentPage = 1;
}


