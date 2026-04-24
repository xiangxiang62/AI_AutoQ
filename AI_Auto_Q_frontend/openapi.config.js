const { generateService } = require("@umijs/openapi");

const schemaPath =
  process.env.OPENAPI_SCHEMA_PATH || "http://localhost:8123/api/v2/api-docs";

async function validateSchema(url) {
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(`OpenAPI 文档请求失败: ${response.status} ${response.statusText}`);
  }

  const schema = await response.json();
  if (!schema || typeof schema !== "object") {
    throw new Error("OpenAPI 文档返回内容不是合法 JSON 对象");
  }

  if (!schema.paths || typeof schema.paths !== "object") {
    throw new Error(
      [
        `OpenAPI 文档缺少 paths 字段，当前地址: ${url}`,
        "这通常表示后端 Swagger/OpenAPI 配置异常，或当前地址不是实际接口文档地址。",
      ].join("\n")
    );
  }
}

async function main() {
  await validateSchema(schemaPath);
  await generateService({
    requestLibPath: "import request from '@/request'",
    schemaPath,
    serversPath: "./src",
  });
}

main().catch((error) => {
  console.error(error.message || error);
  process.exit(1);
});
