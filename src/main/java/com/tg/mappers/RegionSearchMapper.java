package com.tg.mappers;

import com.tg.common.Criteria;
import com.tg.vo.AreaBasedListVO;

import java.util.List;

public interface RegionSearchMapper {
    public List<AreaBasedListVO.Item> getRegionList(Criteria cri) ;
    public int regionGetCount(Criteria cri) ;

}
