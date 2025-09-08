# API接口快速参考

## 🚀 快速开始

### 基础信息
- **基础URL**: `http://localhost:8080`
- **认证方式**: Bearer Token
- **Content-Type**: `application/json`
- **字符编码**: `UTF-8`

### 认证流程
1. 获取验证码：`GET /captchaImage`
2. 用户登录：`POST /login`
3. 携带token访问其他接口：`Authorization: Bearer {token}`

---

## 📋 接口速查表

### 🔐 认证相关
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/captchaImage` | 获取验证码 | 无 |
| POST | `/login` | 用户登录 | 无 |
| POST | `/logout` | 用户登出 | 无 |
| POST | `/register` | 用户注册 | 无 |
| GET | `/getInfo` | 获取用户信息 | 登录 |
| GET | `/getRouters` | 获取路由信息 | 登录 |

### 👥 用户管理 `/system/user`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 用户列表 | `system:user:list` |
| GET | `/{userId}` | 用户详情 | `system:user:query` |
| POST | `/` | 新增用户 | `system:user:add` |
| PUT | `/` | 修改用户 | `system:user:edit` |
| DELETE | `/{userIds}` | 删除用户 | `system:user:remove` |
| PUT | `/resetPwd` | 重置密码 | `system:user:resetPwd` |
| PUT | `/changeStatus` | 修改状态 | `system:user:edit` |
| POST | `/export` | 导出用户 | `system:user:export` |
| POST | `/importData` | 导入用户 | `system:user:import` |

### 🛡️ 角色管理 `/system/role`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 角色列表 | `system:role:list` |
| GET | `/{roleId}` | 角色详情 | `system:role:query` |
| POST | `/` | 新增角色 | `system:role:add` |
| PUT | `/` | 修改角色 | `system:role:edit` |
| DELETE | `/{roleIds}` | 删除角色 | `system:role:remove` |
| PUT | `/dataScope` | 数据权限 | `system:role:edit` |
| PUT | `/changeStatus` | 修改状态 | `system:role:edit` |

### 🏗️ 菜单管理 `/system/menu`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 菜单列表 | `system:menu:list` |
| GET | `/{menuId}` | 菜单详情 | `system:menu:query` |
| GET | `/treeselect` | 菜单树 | 登录 |
| GET | `/roleMenuTreeselect/{roleId}` | 角色菜单树 | 登录 |
| POST | `/` | 新增菜单 | `system:menu:add` |
| PUT | `/` | 修改菜单 | `system:menu:edit` |
| DELETE | `/{menuId}` | 删除菜单 | `system:menu:remove` |

### 🏢 部门管理 `/system/dept`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 部门列表 | `system:dept:list` |
| GET | `/{deptId}` | 部门详情 | `system:dept:query` |
| GET | `/treeselect` | 部门树 | 登录 |
| GET | `/roleDeptTreeselect/{roleId}` | 角色部门树 | 登录 |
| POST | `/` | 新增部门 | `system:dept:add` |
| PUT | `/` | 修改部门 | `system:dept:edit` |
| DELETE | `/{deptId}` | 删除部门 | `system:dept:remove` |

### 💼 岗位管理 `/system/post`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 岗位列表 | `system:post:list` |
| GET | `/{postId}` | 岗位详情 | `system:post:query` |
| POST | `/` | 新增岗位 | `system:post:add` |
| PUT | `/` | 修改岗位 | `system:post:edit` |
| DELETE | `/{postIds}` | 删除岗位 | `system:post:remove` |

### 📢 通知公告 `/system/notice`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 公告列表 | `system:notice:list` |
| GET | `/{noticeId}` | 公告详情 | `system:notice:query` |
| POST | `/` | 新增公告 | `system:notice:add` |
| PUT | `/` | 修改公告 | `system:notice:edit` |
| DELETE | `/{noticeIds}` | 删除公告 | `system:notice:remove` |

### 📚 字典管理
#### 字典类型 `/system/dict/type`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 字典类型列表 | `system:dict:list` |
| GET | `/{dictId}` | 字典类型详情 | `system:dict:query` |
| POST | `/` | 新增字典类型 | `system:dict:add` |
| PUT | `/` | 修改字典类型 | `system:dict:edit` |
| DELETE | `/{dictIds}` | 删除字典类型 | `system:dict:remove` |
| GET | `/optionselect` | 字典选择框 | 登录 |

#### 字典数据 `/system/dict/data`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 字典数据列表 | `system:dict:list` |
| GET | `/{dictCode}` | 字典数据详情 | `system:dict:query` |
| GET | `/type/{dictType}` | 根据类型查询 | 无 |
| POST | `/` | 新增字典数据 | `system:dict:add` |
| PUT | `/` | 修改字典数据 | `system:dict:edit` |
| DELETE | `/{dictCodes}` | 删除字典数据 | `system:dict:remove` |

### ⚙️ 系统配置 `/system/config`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 配置列表 | `system:config:list` |
| GET | `/{configId}` | 配置详情 | `system:config:query` |
| GET | `/configKey/{configKey}` | 根据键查询 | 无 |
| POST | `/` | 新增配置 | `system:config:add` |
| PUT | `/` | 修改配置 | `system:config:edit` |
| DELETE | `/{configIds}` | 删除配置 | `system:config:remove` |
| DELETE | `/refreshCache` | 刷新缓存 | `system:config:remove` |

### 📁 文件管理 `/common`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| POST | `/upload` | 文件上传 | 登录 |
| GET | `/download/resource` | 文件下载 | 登录 |
| GET | `/download` | 通用下载 | 登录 |

### 📊 系统监控
#### 服务器监控 `/monitor`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/server` | 服务器信息 | `monitor:server:list` |
| GET | `/cache` | 缓存信息 | `monitor:cache:list` |
| GET | `/cache/getNames` | 缓存名称 | `monitor:cache:list` |
| GET | `/cache/getKeys/{cacheName}` | 缓存键名 | `monitor:cache:list` |
| GET | `/cache/getValue/{cacheName}/{cacheKey}` | 缓存内容 | `monitor:cache:list` |
| DELETE | `/cache/clearCacheName/{cacheName}` | 清理缓存名 | `monitor:cache:list` |
| DELETE | `/cache/clearCacheKey/{cacheKey}` | 清理缓存键 | `monitor:cache:list` |
| DELETE | `/cache/clearCacheAll` | 清理全部 | `monitor:cache:list` |

#### 在线用户 `/monitor/online`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 在线用户列表 | `monitor:online:list` |
| DELETE | `/{tokenId}` | 强退用户 | `monitor:online:forceLogout` |

#### 操作日志 `/monitor/operlog`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 操作日志列表 | `monitor:operlog:list` |
| DELETE | `/{operIds}` | 删除操作日志 | `monitor:operlog:remove` |
| DELETE | `/clean` | 清空操作日志 | `monitor:operlog:remove` |
| POST | `/export` | 导出操作日志 | `monitor:operlog:export` |

#### 登录日志 `/monitor/logininfor`
| 方法 | 路径 | 描述 | 权限 |
|------|------|------|------|
| GET | `/list` | 登录日志列表 | `monitor:logininfor:list` |
| DELETE | `/{infoIds}` | 删除登录日志 | `monitor:logininfor:remove` |
| DELETE | `/clean` | 清空登录日志 | `monitor:logininfor:remove` |
| DELETE | `/unlock/{userName}` | 解锁用户 | `monitor:logininfor:unlock` |
| POST | `/export` | 导出登录日志 | `monitor:logininfor:export` |

---

## 🔧 常用请求示例

### 用户登录
```bash
curl -X POST http://localhost:8080/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "admin123",
    "code": "1234",
    "uuid": "uuid-string"
  }'
```

### 获取用户列表
```bash
curl -X GET "http://localhost:8080/system/user/list?pageNum=1&pageSize=10" \
  -H "Authorization: Bearer {token}"
```

### 新增用户
```bash
curl -X POST http://localhost:8080/system/user \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer {token}" \
  -d '{
    "userName": "testuser",
    "nickName": "测试用户",
    "password": "123456",
    "email": "test@example.com",
    "phonenumber": "13800138000",
    "sex": "0",
    "status": "0",
    "deptId": 100,
    "postIds": [1],
    "roleIds": [2]
  }'
```

### 文件上传
```bash
curl -X POST http://localhost:8080/common/upload \
  -H "Authorization: Bearer {token}" \
  -F "file=@/path/to/file.jpg"
```

---

## 📝 响应状态码

| 状态码 | 描述 | 说明 |
|--------|------|------|
| 200 | 成功 | 请求成功 |
| 401 | 未授权 | 未登录或token过期 |
| 403 | 禁止访问 | 权限不足 |
| 404 | 未找到 | 资源不存在 |
| 500 | 服务器错误 | 系统异常 |

---

## 🎯 权限标识说明

### 权限格式
- 格式：`模块:功能:操作`
- 示例：`system:user:list`

### 常用权限
- `*:*:*` - 超级管理员权限
- `system:user:list` - 用户查询
- `system:user:add` - 用户新增
- `system:user:edit` - 用户修改
- `system:user:remove` - 用户删除
- `system:role:list` - 角色查询
- `monitor:server:list` - 服务监控

---

## 🔍 调试工具

### Swagger文档
- **地址**: http://localhost:8080/swagger-ui/index.html
- **功能**: 在线API文档和调试

### Druid监控
- **地址**: http://localhost:8080/druid
- **账号**: ruoyi / 123456
- **功能**: 数据库连接池监控

---

*更新时间：2025-01-14*
