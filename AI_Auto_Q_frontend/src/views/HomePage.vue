<template>
  <div id="homePage">
    <!-- 搜索栏 -->
    <div class="searchBar">
      <a-input-search
        v-model="searchText"
        :style="{ width: '320px' }"
        placeholder="快速发现答题应用"
        button-text="搜索"
        size="large"
        search-button
        @search="doSearch"
      />
    </div>

    <!-- 列表 -->
    <a-list
      class="list-demo-action-layout"
      :grid-props="{ gutter: [20, 20], sm: 24, md: 12, lg: 8, xl: 6 }"
      :bordered="false"
      :data="dataList"
      :pagination-props="{
        pageSize: searchParams.pageSize,
        current: searchParams.current,
        total,
      }"
      @page-change="onPageChange"
    >
      <template #item="{ item }">
        <AppCard :app="item" />
      </template>
    </a-list>
  </div>
</template>

<script setup lang="ts">
import { ref, watchEffect } from "vue";
import AppCard from "@/components/AppCard.vue";
import { listAppVoByPageUsingPost } from "@/api/appController";
import message from "@arco-design/web-vue/es/message";
import { REVIEW_STATUS_ENUM } from "@/constant/app";
import API from "@/api";

// ✅ 搜索输入框
const searchText = ref<string>("");

// 初始化搜索条件
const initSearchParams = {
  current: 1,
  pageSize: 12,
  sortOrder: "descend",
  sortField: "createTime",
};

// 查询参数
const searchParams = ref<API.AppQueryRequest>({
  ...initSearchParams,
});

// 数据
const dataList = ref<API.AppVO[]>([]);
const total = ref<number>(0);

/**
 * 加载数据
 */
const loadData = async () => {
  const params = {
    reviewStatus: REVIEW_STATUS_ENUM.PASS,
    ...searchParams.value,
  };

  const res = await listAppVoByPageUsingPost(params);

  if (res.code === 0) {
    dataList.value = res.data?.records || [];
    total.value = res.data?.total || 0;
  } else {
    message.error("获取数据失败，" + res.message);
  }
};

/**
 * 搜索
 */
const doSearch = () => {
  searchParams.value = {
    ...searchParams.value,
    current: 1,
    // ⚠️ 根据你后端字段改
    searchText: searchText.value,
    // 如果你后端是 appName，就改成：
    // appName: searchText.value,
  };
};

/**
 * 分页
 */
const onPageChange = (page: number) => {
  searchParams.value = {
    ...searchParams.value,
    current: page,
  };
};

/**
 * 自动监听参数变化 → 重新加载数据
 */
watchEffect(() => {
  loadData();
});
</script>

<style scoped>
#homePage {
}

.searchBar {
  margin-bottom: 28px;
  text-align: center;
}

.list-demo-action-layout .image-area {
  width: 183px;
  height: 119px;
  overflow: hidden;
  border-radius: 2px;
}

.list-demo-action-layout .list-demo-item {
  padding: 20px 0;
  border-bottom: 1px solid var(--color-fill-3);
}

.list-demo-action-layout .image-area img {
  width: 100%;
}

.list-demo-action-layout .arco-list-item-action .arco-icon {
  margin: 0 4px;
}
</style>