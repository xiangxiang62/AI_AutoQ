package com.xiang.ai.autoQ.model.dto.userAnswer;

import lombok.Data;

/**
 * 应用回答结果数量
 */
@Data
public class AppAnswerResultCountDTO {
    // 结果名称
    private String resultName;
    // 对应个数
    private String resultCount;
}
