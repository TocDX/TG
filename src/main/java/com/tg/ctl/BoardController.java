package com.tg.ctl;

import org.springframework.stereotype.Controller;              //@Controller
import org.springframework.ui.Model;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired; //@Autowired
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute; //@ModelAttribute	
import org.springframework.web.bind.annotation.RequestMapping; //@RequestMapping
import org.springframework.web.bind.annotation.RequestMethod;  //@RequestMapping
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tg.common.PagingUtil;
import com.tg.svc.BoardService;
import com.tg.vo.BoardVO;
import com.tg.vo.DetailCommonVO;
import com.tg.vo.ReplyVO;
import com.tg.vo.FileVO;

@Controller
public class BoardController  {
	
	@Autowired
	private BoardService boardService;
	
	
	
	//------------------------------------------------------------------------------
	//카카오맵에서 클릭한 위경도 좌표와 관련된 서브이미지 1개 가져오기 
	//------------------------------------------------------------------------------
	@RequestMapping(value = "/search_subimg_by_kakao" , method = RequestMethod.POST, produces = "application/json" )
	@ResponseBody 
	public ResponseEntity<DetailCommonVO.Item> ctlSearchImgByKakao(Model model
			, @RequestParam("lat") String latY
			, @RequestParam("lng") String lngX){
		
		System.out.println(latY + "," + lngX);
		
		DetailCommonVO.Item item = new DetailCommonVO.Item();
		item.setMapx(lngX);
		item.setMapy(latY);
		
//		item.setMapx("126.9776487818");
//		item.setMapy("37.5698760651");	
		
		
		item = boardService.svcSearchImgByKakao(item);
		//item.setFirstimage("https://media.istockphoto.com/id/1676101015/ko/%EC%82%AC%EC%A7%84/%EA%B2%BD%EB%B3%B5%EA%B6%81%EC%9D%80-%EC%84%9D%EC%96%91%EC%9D%B4-%EC%95%84%EB%A6%84%EB%8B%B5%EA%B3%A0-%EC%84%9C%EC%9A%B8-%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD.jpg?s=1024x1024&w=is&k=20&c=swWJjHRO5tNI8mVeh-YzC-4utgsYAsVoUOg_S8kn0po=");
	
		System.out.println(item.getFirstimage());
		return new ResponseEntity<DetailCommonVO.Item>(item, HttpStatus.OK);	
	}
	
	
	
	@RequestMapping(value = "/board_insert", method = RequestMethod.POST)
    public String ctlBoardInsert(@ModelAttribute BoardVO bvo,
                                 @RequestParam("ufiles") List<MultipartFile> files,
                                 @RequestParam("imageData") String imageData,
                                 HttpServletRequest request) {

        // 세션에서 꺼낸 회원번호를 댓글 저장시 같이 저장
        if (request.getSession() != null) {
        	Integer userSeq = (Integer) request.getSession().getAttribute("SESS_USER_SEQ");
            bvo.setUserSeq(userSeq);
        }

        // 사용자파일명, 크기, 확장자, 시스템파일명(유니크)
        FileVO fvo = null;
        ArrayList<FileVO> fvoList = new ArrayList<FileVO>();
        //String uploadFolder = "C:\\IT\\uploads";
        String uploadFolder = "src\\main\\webapp\\board\\imgs\\";

        

        // 파일 업로드 처리
        if (files != null) {
            for (MultipartFile file : files) {
            	//TODO
            
            	fvo = new FileVO();
                String fileRealName = file.getOriginalFilename();
                
                
                
                
               
                String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
                String uniqueName = UUID.randomUUID().toString().split("-")[0];

                String filePath = uploadFolder + uniqueName + fileExtension;
                
                String extractedFileName = fileRealName.substring(fileRealName.lastIndexOf("/") + 1);
                fvo.setOname(extractedFileName);
                fvo.setSname(uniqueName + fileExtension); // 45dfered.txt

                System.out.println(fvo.toString());

                // 로컬일 경우 파일카피
//                try {
//                    file.transferTo(new File(filePath));
//                    fvo.setFpath("/board/imgs/"+uniqueName + fileExtension);    // /board/imgs/45dfered.txt
//                    fvoList.add(fvo);
//                } catch (IllegalStateException | IOException e) {
//                    e.printStackTrace();
//                }
                
                // 원격(웹URL)을 사용한 파일카피
                try (InputStream in = new URL(fileRealName).openStream()) {
                	long size = in.available();
                    fvo.setFsize(size);
                	// 파일 다운로드 및 저장
                	Files.copy(in, Paths.get(uploadFolder+extractedFileName) , StandardCopyOption.REPLACE_EXISTING);
                	fvo.setFpath("/board/imgs/"+uniqueName + fileExtension);    // /board/imgs/45dfered.txt
                	fvoList.add(fvo);
                } catch (IOException e) {
                    e.printStackTrace();
                }
                
            }
        }

        // Base64 이미지 처리
        if (imageData != null && !imageData.isEmpty()) {
            fvo = new FileVO();
            String base64Image = imageData.split(",")[1];
            byte[] imageBytes = Base64.getDecoder().decode(base64Image);
            String imgName = "img_" + UUID.randomUUID().toString().split("-")[0] + ".png";
            String imgPath = uploadFolder + "\\" + imgName;

            try {
                FileUtils.writeByteArrayToFile(new File(imgPath), imageBytes);
                fvo.setFpath("/board/imgs/"+imgName);
                fvo.setFsize(imageBytes.length);
                fvo.setOname(imgName);
                fvo.setSname(imgName);
                fvoList.add(fvo);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        int insertRows = boardService.svcBoardInsert(bvo, fvoList);
        return "redirect:/board_list";
    }
	
	
	
	

	
//	@RequestMapping(value = "/board_insert", method = RequestMethod.POST)
//	public String ctlBoardInsert(@ModelAttribute BoardVO bvo,
//			@RequestParam("ufiles") List<MultipartFile> files,
//			HttpServletRequest request) {
//		
//		
//		//Base64 인코딩된 이미지를 처리하고 파일로 저장하는 부분을 추가
//		
//		
//		
//		
//		//----------------------------------------------------------------------------
//		//세션에서 꺼낸 회원번호를 댓글 저장시 같이 저장
//		if (request.getSession() != null) {
//			int userSeq 		= Integer.parseInt( (String)request.getSession().getAttribute("SESS_USER_SEQ") );
//			//String userEmail 	= (String)request.getSession().getAttribute("SESS_USER_EMAIL");
//			bvo.setUserSeq(userSeq);			
//		}
//		
//		//-----------------------------------------------------------------------------------------
//		String uploadFolder = "C:\\IT\\S3917_J11\\workspace_sts3\\uploads";
//		
//		//사용자파일명, 크기, 확장자, 시스템파일명(유니크)
//		FileVO fvo = null;
//		ArrayList<FileVO> fvoList = new  ArrayList<FileVO>();
//		if (files != null) {			
//			for(MultipartFile file : files) {
//						fvo = new FileVO();
//						String fileRealName 	= file.getOriginalFilename();
//						long size 				= file.getSize();
//						String fileExtension 	= fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
//						String uniqueName 		= UUID.randomUUID().toString().split("-")[0];
//						
//						String filePath 	=  uploadFolder +"\\" + uniqueName + fileExtension;
//						fvo.setFpath(filePath);   	//C:\\test\\upload\\45dfered.txt
//						//fvo.setFseq(0);   											//시퀀스 nextval
//						fvo.setFsize(size);
//						fvo.setOname(fileRealName);
//						//fvo.setSeq(1);												//실제 게시물 글번호 : 하드코딩
//						fvo.setSname(uniqueName + fileExtension);						//45dfered.txt
//						
//						System.out.println(fvo.toString());
//						
//						//파일카피
//						try {
//							file.transferTo( new File(filePath) ); 
//							fvoList.add(fvo);
//						} catch (IllegalStateException e) {
//							e.printStackTrace();
//						} catch (IOException e) {
//							e.printStackTrace();
//						}
//						
//				} //e.o.for
//			} //e.o.if
//		
//		
//		//-----------------------------------------------------------------------------------------	
//		// Base64 이미지 처리
//        if (imageData != null && !imageData.isEmpty()) {
//            fvo = new FileVO();
//            String base64Image = imageData.split(",")[1];
//            byte[] imageBytes = Base64.getDecoder().decode(base64Image);
//            String imgName = "img_" + UUID.randomUUID().toString().split("-")[0] + ".png";
//            String imgPath = uploadFolder + "\\" + imgName;
//
//            try {
//                FileUtils.writeByteArrayToFile(new File(imgPath), imageBytes);
//                fvo.setFpath(imgPath);
//                fvo.setFsize(imageBytes.length);
//                fvo.setOname(imgName);
//                fvo.setSname(imgName);
//                fvoList.add(fvo);
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
//        
//        
//        
//		int insertRows = boardService.svcBoardInsert(bvo, fvoList);
//		return "redirect:/board_list";						//   /board_list
//	}
	
	@RequestMapping(value = "/board_list")
	public String ctlBoardList(Model model
			, @RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage 
			) {
		//페이징
		int listCount = boardService.svcBoardCount();
		PagingUtil page = new PagingUtil("/board_list?", currentPage, listCount, 4, 5);
		String pageHtmlStr = page.getPagingHtml().toString();
		
		BoardVO boardVO = new BoardVO();
		boardVO.setStartSeq(page.getStartSeq());
		boardVO.setEndSeq(page.getEndSeq());
		
		ArrayList<BoardVO> list = (ArrayList)boardService.svcBoardSelect(boardVO);
		model.addAttribute("KEY_BOARDLIST", list);
		model.addAttribute("KEY_PAGEING_HTML", pageHtmlStr);
		return "board/board_list";     				//   /  lec05_board/board_list  .jsp  
	}
	
	@RequestMapping(value = "/board_detail")
	public String ctlBoardDetail(Model model, @RequestParam("seq") int seq){
		//------------------------------------------------------
		//상세만 가져가고 ,댓글목록은 (REST)로 출력
		//	트랜잭션 : SELECT(게시물상세) , SELECT(댓글목록) 
		//	게시물상세 EL : ${KEY_BOARDVO} () 
		//	댓글목록 EL  : ${KEY_REPLYLIST}
		//------------------------------------------------------
		BoardVO bvo = boardService.svcBoardSelectOne(seq);
		model.addAttribute("KEY_BOARDVO", bvo);
		return "board/board_detail";						//   /   lec05_board/board_detail  .jsp
	}
	
	//댓글목록 : REST
	@RequestMapping(value = "/reply_list_rest" , method = RequestMethod.POST, produces = "application/json" )
	@ResponseBody 
	public ResponseEntity<ArrayList<ReplyVO>> ctlReplyListForRest(Model model
			, @RequestParam("seq") int seq){
		System.out.println(seq);
		
		ArrayList<ReplyVO> rlist = (ArrayList)boardService.svcReplySelect(seq);
		return new ResponseEntity<ArrayList<ReplyVO>>(rlist, HttpStatus.OK);	
	}
	
	//댓글등록 : REST
	@RequestMapping(value = "/reply_insert_rest" , method = RequestMethod.POST)
	@ResponseBody 
	public String ctlReplyInsertForRest(Model model
			, @ModelAttribute ReplyVO rvo
			,HttpServletRequest request ){
		System.out.println(rvo.getReply());
		
		//----------------------------------------------------------------------------
		//세션에서 꺼낸 회원번호를 댓글 저장시 같이 저장 
		if (request.getSession() != null) {
			Integer userSeq = (Integer) request.getSession().getAttribute("SESS_USER_SEQ");
			//String userEmail 	= (String)request.getSession().getAttribute("SESS_USER_EMAIL");
			rvo.setUserSeq(userSeq);			
		}
		
		
		int res = boardService.svcReplyInsert(rvo);
		String msg = "입력에러";
		if(res > 0) {
			msg = "입력성공";
		}
		//return String.valueOf(res);	
		return String.valueOf(msg);
	}
	
	//댓글삭제 : REST
	@RequestMapping(value = "/reply_delete_rest" , method = RequestMethod.POST)
	@ResponseBody 
	public String ctlReplyDeleteForRest(Model model
			, @ModelAttribute ReplyVO rvo){
		System.out.println(rvo.getRseq());
		
		int deleteRows = boardService.svcReplyDelete(rvo.getRseq());
		String msg = "삭제에러";
		if(deleteRows > 0) {
			msg = "삭제성공";
		}
		//return String.valueOf(res);	
		return String.valueOf(msg);
	}
	
	@RequestMapping(value = "/board_update", method = RequestMethod.POST)
	public String ctlBoardUpdate(Model model, @ModelAttribute BoardVO bvo){
		int updateRows = boardService.svcBoardUpdate(bvo);
		//상세보기파라미터 : seq
		return "redirect:/board_detail?seq="+bvo.getSeq();						//   /board_detail?seq=3
	}
	
	@RequestMapping(value = "/board_delete", method = RequestMethod.POST)
	public String ctlBoardDel(Model model, @RequestParam("seq") int seq){
		int deleteRows = boardService.svcBoardDelete(seq);
		return "redirect:/board_list";											//   /board_list
	}
	
	
}
