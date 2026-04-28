package com.xiang.ai.autoQ.mapper;

import com.xiang.ai.autoQ.model.domain.UserAnswer;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiang.ai.autoQ.model.dto.userAnswer.AppAnswerCountDTO;
import com.xiang.ai.autoQ.model.dto.userAnswer.AppAnswerResultCountDTO;

import java.util.List;

/**
* @author 19643
* @description 针对表【user_answer(用户答题记录)】的数据库操作Mapper
* @createDate 2026-04-23 10:46:36
* @Entity com.xiang.ai.autoQ.model.domain.UserAnswer
*/
public interface UserAnswerMapper extends BaseMapper<UserAnswer> {

    /**
     * 获取应用回答数量
     *
     * @return
     */
    List<AppAnswerCountDTO> doAppAnswerCount();

    /**
     * 应用回答数量
     *
     * @param appId
     * @return
     */
    List<AppAnswerResultCountDTO> doAppAnswerResultCount(Long appId);
}




