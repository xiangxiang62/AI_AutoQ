import { defineStore } from "pinia";
import { ref } from "vue";
import { getLoginUserUsingGet } from "@/api/userController";
import ACCESS_ENUM from "@/access/accessEnum";

export const useLoginUserStore = defineStore("loginUser", () => {
  const loginUser = ref<API.LoginUserVO>({
    userName: "未登录",
  });


  async function fetchLoginUser() {
    const res = await getLoginUserUsingGet();
    if (res.code === 0 && res.data) {
      loginUser.value = res.data;
    } else {
      loginUser.value = { userRole: ACCESS_ENUM.NOT_LOGIN };
    }
  }


  function setLoginUser(newLoginUser: API.LoginUserVO) {
    loginUser.value = newLoginUser;
  }

  return { loginUser, setLoginUser, fetchLoginUser };
});
