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
import BasicLayout from "@/layouts/BasicLayout.vue";
import { getLoginUserUsingGet } from "@/api/userController";
import { useLoginUserStore } from "@/store/user";
const loginUserStore = useLoginUserStore();
loginUserStore.fetchLoginUser();

const route = useRoute();
getLoginUserUsingGet().then((res) => {
  console.log(res);
});

</script>
