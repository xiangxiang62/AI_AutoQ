<template>
  <div id="app">
    <template v-if="route.path.startsWith('/user')">
      <router-view />
    </template>
    <template v-else>
      <BasicLayout />
    </template>
  </div>
</template>


<style>
#app {
}
</style>



<script setup lang="ts">
import { useRoute } from "vue-router";
const route = useRoute();
import BasicLayout from "@/layouts/BasicLayout.vue";
import { useLoginUserStore } from "@/store/userStore";
import { onMounted } from "vue";
const loginUserStore = useLoginUserStore();
loginUserStore.fetchLoginUser();


/**
 * 全局初始化函数，有全局单次调用的代码，都可以写到这里
 */
const doInit = () => {
  console.log("hello 欢迎来到我的项目");
};

onMounted(() => {
  doInit();
});


</script>
