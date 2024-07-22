package com.tg.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.tg.vo.BoardVO;
import com.tg.vo.DetailCommonVO;
import com.tg.vo.FileVO;
import com.tg.vo.ReplyVO;

@Repository
@Mapper
public interface BoardMapper {
	
	
	public DetailCommonVO.Item searchImgByKakao(DetailCommonVO.Item item);
	
	
	
    // 게시물 상세보기 + 댓글 및 첨부파일
    public BoardVO boardReplySelect(int seq);

    // 게시물 목록 조회 (페이징 처리)
    public List<BoardVO> boardSelect(BoardVO boardVO); // int startSeq, int endSeq

    // 게시물 수 카운트
    public int boardCount(); // 총게시물수

    // 게시물 저장
    public int boardInsert(BoardVO bvo);

    // 첨부파일 저장
    public int boardFileInsert(FileVO fvo);

    // 게시물 상세보기 + 첨부파일
    public BoardVO boardFileSelectOne(int seq);

    // 게시물 상세보기
    public BoardVO boardSelectOne(int seq);

    // 댓글 목록 조회
    public List<ReplyVO> replySelect(int seq);

    // 댓글 저장
    public int replyInsert(ReplyVO rvo);

    // 게시물 수정
    public int boardUpdate(BoardVO bvo);

    // 게시물 삭제
    public int boardDelete(int seq);

    // 댓글 삭제
    public int replyDelete(int rseq);
}



//@Repository
//@Mapper
//public interface BoardMapper {
//	public BoardVO boardReplySelect(int seq);
//	public List<BoardVO> boardSelect(BoardVO boardVO); //int startSeq, int endSeq
//	public int boardCount(); //총게시물수
//	
//	//게시물저장
//	public int boardInsert(BoardVO bvo);
//	//첨부파일저장
//	public int boardFileInsert(FileVO fvo);
//	//게시물상세+첨부파일
//	public BoardVO boardFileSelectOne(int seq);
//	
//	public BoardVO boardSelectOne(int seq);
//	public List<ReplyVO> replySelect(int seq);
//	public int replyInsert(ReplyVO rvo);
//	public int boardUpdate(BoardVO bvo);
//	public int boardDelete(int seq);
//	public int replyDelete(int rseq);
//	
//}
