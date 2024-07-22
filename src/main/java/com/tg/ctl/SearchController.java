package com.tg.ctl;


import com.tg.svc.SearchServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController

public class SearchController {

    @Autowired
    private SearchServiceImpl searchService;
    @RequestMapping("/searchForm")
    public String searchForm() {
        return "searchForm";  // JSP 파일명 (searchForm.jsp)
    }

    @RequestMapping("/search")
    public String search(@RequestParam String keyword, Model model) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("content", searchService.searchContent(keyword));
        result.put("festival", searchService.searchFestival(keyword));
        result.put("board", searchService.searchBoard(keyword));

        model.addAttribute("result", result);
        return "search";  // JSP 파일명 (searchResult.jsp)
    }
}
