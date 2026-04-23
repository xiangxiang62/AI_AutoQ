package com.xiang.ai.autoQ.scoring;


import com.xiang.ai.autoQ.model.domain.App;
import com.xiang.ai.autoQ.model.domain.UserAnswer;

import java.util.List;

/**
 * 评分策略
 *
 */
public interface ScoringStrategy {

    /**
     * 执行评分
     *
     * @param choices
     * @param app
     * @return
     * @throws Exception
     */
    UserAnswer doScore(List<String> choices, App app) throws Exception;
}