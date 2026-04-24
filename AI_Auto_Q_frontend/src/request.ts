import axios, { type AxiosRequestConfig, type AxiosResponse } from "axios";

const requestInstance = axios.create({
  baseURL: "http://localhost:8123",
  timeout: 10000,
  withCredentials: true,
});

requestInstance.interceptors.request.use(
  (config) => config,
  (error) => Promise.reject(error)
);

requestInstance.interceptors.response.use(
  (response) => {
    const { data, request } = response;

    if (
      data?.code === 40100 &&
      !request?.responseURL?.includes("user/get/login") &&
      !window.location.pathname.includes("/user/login")
    ) {
      window.location.href = `/user/login?redirect=${window.location.href}`;
    }

    return response;
  },
  (error) => Promise.reject(error)
);

export type RequestOptions = AxiosRequestConfig;

async function request<T = unknown>(
  url: string,
  options?: RequestOptions
): Promise<T> {
  const response: AxiosResponse<T> = await requestInstance.request<T>({
    url,
    ...options,
  });
  return response.data;
}

export default request;
