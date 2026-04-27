import router from "@/router";
import { useLoginUserStore } from "@/store/userStore";
import ACCESS_ENUM from "@/access/accessEnum";
import checkAccess from "@/access/checkAccess";

router.beforeEach(async (to, from, next) => {
  const loginUserStore = useLoginUserStore();
  let loginUser = loginUserStore.loginUser;
  const needAccess = (to.meta?.access as string) ?? ACCESS_ENUM.NOT_LOGIN;

  if (!loginUser?.userRole || loginUser.userRole === ACCESS_ENUM.NOT_LOGIN) {
    await loginUserStore.fetchLoginUser();
    loginUser = loginUserStore.loginUser;
  }

  if (needAccess !== ACCESS_ENUM.NOT_LOGIN) {
    if (!loginUser?.userRole || loginUser.userRole === ACCESS_ENUM.NOT_LOGIN) {
      next(`/user/login?redirect=${encodeURIComponent(to.fullPath)}`);
      return;
    }

    if (!checkAccess(loginUser, needAccess)) {
      next("/noAuth");
      return;
    }
  }

  next();
});

export default checkAccess;
