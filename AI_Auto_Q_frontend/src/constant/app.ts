// src/constant/app.ts

/**
 * 应用类型枚举
 */
export const APP_TYPE_ENUM = {
  SCORE: 0,
  TEST: 1,
} as const;

/**
 * 应用类型映射（用于页面展示）
 */
export const APP_TYPE_MAP: Record<number, string> = {
  0: "评分类",
  1: "测试类",
};

/**
 * 评分策略枚举
 */
export const APP_SCORING_STRATEGY_ENUM = {
  CUSTOM: 0,
  AI: 1,
} as const;

/**
 * 评分策略映射
 */
export const APP_SCORING_STRATEGY_MAP: Record<number, string> = {
  0: "自定义评分",
  1: "AI评分",
};

/**
 * 审核状态枚举
 */
export const REVIEW_STATUS_ENUM = {
  REVIEWING: 0,
  PASS: 1,
  REJECT: 2,
} as const;

/**
 * 审核状态映射
 */
export const REVIEW_STATUS_MAP: Record<number, string> = {
  0: "审核中",
  1: "通过",
  2: "拒绝",
};