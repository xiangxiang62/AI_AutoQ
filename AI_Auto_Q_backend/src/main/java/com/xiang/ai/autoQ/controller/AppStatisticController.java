package com.xiang.ai.autoQ.controller;

import com.xiang.ai.autoQ.common.BaseResponse;
import com.xiang.ai.autoQ.common.ResultUtils;
import com.xiang.ai.autoQ.exception.ErrorCode;
import com.xiang.ai.autoQ.exception.ThrowUtils;
import com.xiang.ai.autoQ.mapper.UserAnswerMapper;
import com.xiang.ai.autoQ.model.dto.userAnswer.AppAnswerCountDTO;
import com.xiang.ai.autoQ.model.dto.userAnswer.AppAnswerResultCountDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * 用户回答统计
 */
@RestController
@RequestMapping("/app/statistic")
@Slf4j
public class AppStatisticController {

    @Resource
    private UserAnswerMapper userAnswerMapper;

    /**
     * 获取应用回答数量
     *
     * @return 应用回答数量
     */
    @GetMapping("/answer_count")
    public BaseResponse<List<AppAnswerCountDTO>> getAppAnswerCount() {
        return ResultUtils.success(userAnswerMapper.doAppAnswerCount());
    }


    /**
     * 获取应用回复数量
     * @param appId
     * @return
     */
    @GetMapping("/answer_result_count")
    public BaseResponse<List<AppAnswerResultCountDTO>> getAppAnswerResultCount(Long appId) {
        ThrowUtils.throwIf(appId == null || appId <= 0, ErrorCode.PARAMS_ERROR);
        return ResultUtils.success(userAnswerMapper.doAppAnswerResultCount(appId));
    }


}
