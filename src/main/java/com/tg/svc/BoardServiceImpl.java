package com.tg.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tg.mappers.BoardMapper;
import com.tg.vo.BoardVO;
import com.tg.vo.DetailCommonVO;
import com.tg.vo.FileVO;
import com.tg.vo.ReplyVO;

@Service
public class BoardServiceImpl implements BoardService {
	
    @Autowired
    private BoardMapper boardMapper;
    
    @Override
    public DetailCommonVO.Item svcSearchImgByKakao(DetailCommonVO.Item item) {
    	System.out.println(item.getMapx() + "," + item.getMapy() + "-------");
    	item = boardMapper.searchImgByKakao(item);
    	System.out.println(item.getFirstimage());
    	
    	return item; 
    			
    }
    
    
    @Override
    public int svcBoardCount() {
        return boardMapper.boardCount();
    }

    @Override
    public BoardVO svcBoardReplySelect(int seq) {
        return boardMapper.boardReplySelect(seq);
    }

    @Override
    public List<BoardVO> svcBoardSelect(BoardVO boardVO) {
        return boardMapper.boardSelect(boardVO);
    }

    @Override
    public int svcBoardInsert(BoardVO bvo, List<FileVO> fvoList) {
        // 게시물 저장
        boardMapper.boardInsert(bvo);
        int boardSeq = bvo.getSeq(); // 저장된 게시물의 시퀀스 값
        
        // 첨부파일 저장
        if (fvoList != null && !fvoList.isEmpty()) {
            for (FileVO fvo : fvoList) {
                fvo.setSeq(boardSeq);
                boardMapper.boardFileInsert(fvo);
            }
        }
        
        return boardSeq; // 저장된 게시물의 시퀀스 값을 반환 (또는 성공 시 1 반환)
    }

    @Override
    public BoardVO svcBoardSelectOne(int seq) {
        return boardMapper.boardFileSelectOne(seq); // 게시물 + 첨부파일 조회
    }

    @Override
    public List<ReplyVO> svcReplySelect(int seq) {
        return boardMapper.replySelect(seq);
    }

    @Override
    public int svcReplyInsert(ReplyVO rvo) {
        return boardMapper.replyInsert(rvo);
    }

    @Override
    public int svcBoardUpdate(BoardVO bvo) {
        return boardMapper.boardUpdate(bvo);
    }

    @Override
    public int svcBoardDelete(int seq) {
        return boardMapper.boardDelete(seq);
    }

    @Override
    public int svcReplyDelete(int rseq) {
        return boardMapper.replyDelete(rseq);
    }
}
