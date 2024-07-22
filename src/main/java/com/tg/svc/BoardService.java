package com.tg.svc;

import java.util.List;

import com.tg.vo.BoardVO;
import com.tg.vo.DetailCommonVO;
import com.tg.vo.FileVO;
import com.tg.vo.ReplyVO;

public interface BoardService {
	
	public DetailCommonVO.Item svcSearchImgByKakao(DetailCommonVO.Item item);
	
	
	
    // 게시물 수 카운트
    int svcBoardCount();

    // 게시물 상세보기 + 댓글
    BoardVO svcBoardReplySelect(int seq);

    // 게시물 목록 조회 (페이징 처리)
    List<BoardVO> svcBoardSelect(BoardVO boardVO); // int startSeq, int endSeq

    // 게시물 저장 및 첨부파일 저장
    int svcBoardInsert(BoardVO bvo, List<FileVO> fvoList);

    // 게시물 상세보기 + 첨부파일
    BoardVO svcBoardSelectOne(int seq);

    // 댓글 목록 조회
    List<ReplyVO> svcReplySelect(int seq);

    // 댓글 저장
    int svcReplyInsert(ReplyVO rvo);

    // 게시물 수정
    int svcBoardUpdate(BoardVO bvo);

    // 게시물 삭제
    int svcBoardDelete(int seq);

    // 댓글 삭제
    int svcReplyDelete(int rseq);
}
