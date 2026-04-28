package com.xiang.ai.autoQ.model.dto.userAnswer;

import lombok.Data;

/**
 * 用户回答数量 DTO
 */
@Data
public class AppAnswerCountDTO {

    /**
     * 应用 id
     */
    private Long appId;
    
    /**
     * 回答数量
     */
    private Long answerCount;

}
