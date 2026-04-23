package com.xiang.ai.autoQ.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.xiang.ai.autoQ.model.domain.App;
import com.baomidou.mybatisplus.extension.service.IService;
import com.xiang.ai.autoQ.model.dto.app.AppQueryRequest;
import com.xiang.ai.autoQ.model.vo.AppVO;

import javax.servlet.http.HttpServletRequest;

/**
* @author 19643
* @description 针对表【app(应用)】的数据库操作Service
* @createDate 2026-04-23 10:46:36
*/
public interface AppService extends IService<App> {
    /**
     * 校验数据
     *
     * @param app
     * @param add 对创建的数据进行校验
     */
    void validApp(App app, boolean add);

    /**
     * 获取查询条件
     *
     * @param appQueryRequest
     * @return
     */
    QueryWrapper<App> getQueryWrapper(AppQueryRequest appQueryRequest);

    /**
     * 获取应用封装
     *
     * @param app
     * @param request
     * @return
     */
    AppVO getAppVO(App app, HttpServletRequest request);

    /**
     * 分页获取应用封装
     *
     * @param appPage
     * @param request
     * @return
     */
    Page<AppVO> getAppVOPage(Page<App> appPage, HttpServletRequest request);
}
