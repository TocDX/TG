package com.tg.ctl;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tg.vo.FileVO;


@Controller
public class FileController {
	
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);
	
	@RequestMapping(value = "/file_upload", method = RequestMethod.POST)
	public String ctlFileUpload(Model model, 
			//@RequestParam("title") String title
			@RequestParam("ufile") MultipartFile file) {

		
		
		//사용자파일명, 크기, 확장자, 시스템파일명(유니크)
		String fileRealName 	= file.getOriginalFilename();
		long size 				= file.getSize();
		String fileExtension 	= fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
		String uniqueName 		= UUID.randomUUID().toString().split("-")[0];
		
		String uploadFolder = "/users/soo/downloads/TGether_prj/src/main/webapp/resources/static/imgs";
		String filePath 	=  uploadFolder +"/" + uniqueName + fileExtension;
		
		FileVO fvo = new FileVO();
		fvo.setFpath(filePath);   	//C:\\test\\upload\\45dfered.txt
		//fvo.setFseq(0);   											//시퀀스 nextval
		fvo.setFsize(size);
		fvo.setOname(fileRealName);
		fvo.setSeq(1);													//실제 게시물 글번호 : 하드코딩
		fvo.setSname(uniqueName + fileExtension);						//45dfered.txt
		
		System.out.println(fvo.toString());
		
		//파일카피
		try {
			file.transferTo( new File(filePath) ); 
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return "lec12_file/file_upload_result";            //  / hello   .jsp   
	}
	
	
}
