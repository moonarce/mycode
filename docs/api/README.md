# RuoYi-Vue 后端API接口文档

**版本**: v3.9.0  
**创建日期**: 2025-01-14  
**基础URL**: http://localhost:8080  

---

## 📋 目录

1. [认证接口](#认证接口)
2. [用户管理](#用户管理)
3. [角色管理](#角色管理)
4. [菜单管理](#菜单管理)
5. [部门管理](#部门管理)
6. [岗位管理](#岗位管理)
7. [通知公告](#通知公告)
8. [字典管理](#字典管理)
9. [系统配置](#系统配置)
10. [文件上传](#文件上传)
11. [验证码](#验证码)
12. [系统监控](#系统监控)
13. [测试接口](#测试接口)

---

## 🔐 认证接口

### 用户登录
- **接口地址**: `POST /login`
- **接口描述**: 用户登录认证
- **请求参数**:
```json
{
  "username": "admin",
  "password": "admin123", 
  "code": "验证码",
  "uuid": "验证码UUID"
}
```
- **响应示例**:
```json
{
  "code": 200,
  "msg": "操作成功",
  "token": "eyJhbGciOiJIUzUxMiJ9..."
}
```

### 获取用户信息
- **接口地址**: `GET /getInfo`
- **接口描述**: 获取当前登录用户信息
- **请求头**: `Authorization: Bearer {token}`
- **响应示例**:
```json
{
  "code": 200,
  "msg": "操作成功",
  "user": {
    "userId": 1,
    "userName": "admin",
    "nickName": "超级管理员"
  },
  "roles": ["admin"],
  "permissions": ["*:*:*"]
}
```

### 获取路由信息
- **接口地址**: `GET /getRouters`
- **接口描述**: 获取用户菜单路由信息
- **请求头**: `Authorization: Bearer {token}`

---

## 👥 用户管理

### 获取用户列表
- **接口地址**: `GET /system/user/list`
- **接口描述**: 分页查询用户列表
- **权限标识**: `system:user:list`
- **请求参数**:
  - `pageNum`: 页码（可选）
  - `pageSize`: 每页条数（可选）
  - `userName`: 用户名（可选）
  - `status`: 状态（可选）
- **响应示例**:
```json
{
  "code": 200,
  "msg": "查询成功",
  "rows": [
    {
      "userId": 1,
      "userName": "admin",
      "nickName": "超级管理员",
      "email": "ry@163.com",
      "phonenumber": "15888888888",
      "sex": "1",
      "status": "0"
    }
  ],
  "total": 1
}
```

### 获取用户详情
- **接口地址**: `GET /system/user/{userId}`
- **接口描述**: 根据用户ID获取详细信息
- **权限标识**: `system:user:query`
- **路径参数**: `userId` - 用户ID

### 新增用户
- **接口地址**: `POST /system/user`
- **接口描述**: 新增用户
- **权限标识**: `system:user:add`
- **请求体**:
```json
{
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
}
```

### 修改用户
- **接口地址**: `PUT /system/user`
- **接口描述**: 修改用户信息
- **权限标识**: `system:user:edit`

### 删除用户
- **接口地址**: `DELETE /system/user/{userIds}`
- **接口描述**: 批量删除用户
- **权限标识**: `system:user:remove`
- **路径参数**: `userIds` - 用户ID数组，多个用逗号分隔

### 重置密码
- **接口地址**: `PUT /system/user/resetPwd`
- **接口描述**: 重置用户密码
- **权限标识**: `system:user:resetPwd`

### 修改状态
- **接口地址**: `PUT /system/user/changeStatus`
- **接口描述**: 修改用户状态
- **权限标识**: `system:user:edit`

### 导出用户
- **接口地址**: `POST /system/user/export`
- **接口描述**: 导出用户数据到Excel
- **权限标识**: `system:user:export`

### 导入用户
- **接口地址**: `POST /system/user/importData`
- **接口描述**: 从Excel导入用户数据
- **权限标识**: `system:user:import`

---

## 🛡️ 角色管理

### 获取角色列表
- **接口地址**: `GET /system/role/list`
- **接口描述**: 分页查询角色列表
- **权限标识**: `system:role:list`

### 获取角色详情
- **接口地址**: `GET /system/role/{roleId}`
- **接口描述**: 根据角色ID获取详细信息
- **权限标识**: `system:role:query`

### 新增角色
- **接口地址**: `POST /system/role`
- **接口描述**: 新增角色
- **权限标识**: `system:role:add`

### 修改角色
- **接口地址**: `PUT /system/role`
- **接口描述**: 修改角色信息
- **权限标识**: `system:role:edit`

### 删除角色
- **接口地址**: `DELETE /system/role/{roleIds}`
- **接口描述**: 批量删除角色
- **权限标识**: `system:role:remove`

### 角色数据权限
- **接口地址**: `PUT /system/role/dataScope`
- **接口描述**: 修改角色数据权限
- **权限标识**: `system:role:edit`

---

## 🏗️ 菜单管理

### 获取菜单列表
- **接口地址**: `GET /system/menu/list`
- **接口描述**: 获取菜单列表
- **权限标识**: `system:menu:list`

### 获取菜单详情
- **接口地址**: `GET /system/menu/{menuId}`
- **接口描述**: 根据菜单ID获取详细信息
- **权限标识**: `system:menu:query`

### 获取菜单下拉树
- **接口地址**: `GET /system/menu/treeselect`
- **接口描述**: 获取菜单下拉树列表

### 角色菜单树选择
- **接口地址**: `GET /system/menu/roleMenuTreeselect/{roleId}`
- **接口描述**: 加载对应角色菜单列表树

### 新增菜单
- **接口地址**: `POST /system/menu`
- **接口描述**: 新增菜单
- **权限标识**: `system:menu:add`

### 修改菜单
- **接口地址**: `PUT /system/menu`
- **接口描述**: 修改菜单信息
- **权限标识**: `system:menu:edit`

### 删除菜单
- **接口地址**: `DELETE /system/menu/{menuId}`
- **接口描述**: 删除菜单
- **权限标识**: `system:menu:remove`

---

## 🏢 部门管理

### 获取部门列表
- **接口地址**: `GET /system/dept/list`
- **接口描述**: 获取部门列表
- **权限标识**: `system:dept:list`

### 获取部门详情
- **接口地址**: `GET /system/dept/{deptId}`
- **接口描述**: 根据部门ID获取详细信息
- **权限标识**: `system:dept:query`

### 获取部门下拉树
- **接口地址**: `GET /system/dept/treeselect`
- **接口描述**: 获取部门下拉树列表

### 角色部门树选择
- **接口地址**: `GET /system/dept/roleDeptTreeselect/{roleId}`
- **接口描述**: 加载对应角色部门列表树

### 新增部门
- **接口地址**: `POST /system/dept`
- **接口描述**: 新增部门
- **权限标识**: `system:dept:add`

### 修改部门
- **接口地址**: `PUT /system/dept`
- **接口描述**: 修改部门信息
- **权限标识**: `system:dept:edit`

### 删除部门
- **接口地址**: `DELETE /system/dept/{deptId}`
- **接口描述**: 删除部门
- **权限标识**: `system:dept:remove`

---

## 💼 岗位管理

### 获取岗位列表
- **接口地址**: `GET /system/post/list`
- **接口描述**: 分页查询岗位列表
- **权限标识**: `system:post:list`

### 获取岗位详情
- **接口地址**: `GET /system/post/{postId}`
- **接口描述**: 根据岗位ID获取详细信息
- **权限标识**: `system:post:query`

### 新增岗位
- **接口地址**: `POST /system/post`
- **接口描述**: 新增岗位
- **权限标识**: `system:post:add`

### 修改岗位
- **接口地址**: `PUT /system/post`
- **接口描述**: 修改岗位信息
- **权限标识**: `system:post:edit`

### 删除岗位
- **接口地址**: `DELETE /system/post/{postIds}`
- **接口描述**: 批量删除岗位
- **权限标识**: `system:post:remove`

---

## 📢 通知公告

### 获取公告列表
- **接口地址**: `GET /system/notice/list`
- **接口描述**: 分页查询通知公告列表
- **权限标识**: `system:notice:list`

### 获取公告详情
- **接口地址**: `GET /system/notice/{noticeId}`
- **接口描述**: 根据公告ID获取详细信息
- **权限标识**: `system:notice:query`

### 新增公告
- **接口地址**: `POST /system/notice`
- **接口描述**: 新增通知公告
- **权限标识**: `system:notice:add`

### 修改公告
- **接口地址**: `PUT /system/notice`
- **接口描述**: 修改通知公告
- **权限标识**: `system:notice:edit`

### 删除公告
- **接口地址**: `DELETE /system/notice/{noticeIds}`
- **接口描述**: 批量删除通知公告
- **权限标识**: `system:notice:remove`

---

## 📚 字典管理

### 字典类型

#### 获取字典类型列表
- **接口地址**: `GET /system/dict/type/list`
- **接口描述**: 分页查询字典类型列表
- **权限标识**: `system:dict:list`

#### 获取字典类型详情
- **接口地址**: `GET /system/dict/type/{dictId}`
- **接口描述**: 根据字典ID获取详细信息
- **权限标识**: `system:dict:query`

#### 新增字典类型
- **接口地址**: `POST /system/dict/type`
- **接口描述**: 新增字典类型
- **权限标识**: `system:dict:add`

#### 修改字典类型
- **接口地址**: `PUT /system/dict/type`
- **接口描述**: 修改字典类型
- **权限标识**: `system:dict:edit`

#### 删除字典类型
- **接口地址**: `DELETE /system/dict/type/{dictIds}`
- **接口描述**: 批量删除字典类型
- **权限标识**: `system:dict:remove`

### 字典数据

#### 获取字典数据列表
- **接口地址**: `GET /system/dict/data/list`
- **接口描述**: 分页查询字典数据列表
- **权限标识**: `system:dict:list`

#### 根据字典类型查询字典数据
- **接口地址**: `GET /system/dict/data/type/{dictType}`
- **接口描述**: 根据字典类型查询字典数据信息

#### 获取字典数据详情
- **接口地址**: `GET /system/dict/data/{dictCode}`
- **接口描述**: 根据字典编码获取详细信息
- **权限标识**: `system:dict:query`

#### 新增字典数据
- **接口地址**: `POST /system/dict/data`
- **接口描述**: 新增字典数据
- **权限标识**: `system:dict:add`

#### 修改字典数据
- **接口地址**: `PUT /system/dict/data`
- **接口描述**: 修改字典数据
- **权限标识**: `system:dict:edit`

#### 删除字典数据
- **接口地址**: `DELETE /system/dict/data/{dictCodes}`
- **接口描述**: 批量删除字典数据
- **权限标识**: `system:dict:remove`

---

## ⚙️ 系统配置

### 获取参数配置列表
- **接口地址**: `GET /system/config/list`
- **接口描述**: 分页查询参数配置列表
- **权限标识**: `system:config:list`

### 获取参数配置详情
- **接口地址**: `GET /system/config/{configId}`
- **接口描述**: 根据参数编号获取详细信息
- **权限标识**: `system:config:query`

### 根据参数键名查询参数值
- **接口地址**: `GET /system/config/configKey/{configKey}`
- **接口描述**: 根据参数键名查询参数值

### 新增参数配置
- **接口地址**: `POST /system/config`
- **接口描述**: 新增参数配置
- **权限标识**: `system:config:add`

### 修改参数配置
- **接口地址**: `PUT /system/config`
- **接口描述**: 修改参数配置
- **权限标识**: `system:config:edit`

### 删除参数配置
- **接口地址**: `DELETE /system/config/{configIds}`
- **接口描述**: 批量删除参数配置
- **权限标识**: `system:config:remove`

### 刷新参数缓存
- **接口地址**: `DELETE /system/config/refreshCache`
- **接口描述**: 刷新参数缓存
- **权限标识**: `system:config:remove`

---

## 📁 文件上传

### 通用上传请求
- **接口地址**: `POST /common/upload`
- **接口描述**: 通用文件上传接口
- **请求类型**: `multipart/form-data`
- **请求参数**: `file` - 上传的文件
- **响应示例**:
```json
{
  "code": 200,
  "msg": "操作成功",
  "fileName": "2023/01/14/test_20230114001.jpg",
  "newFileName": "test_20230114001.jpg",
  "originalFilename": "test.jpg",
  "url": "/profile/upload/2023/01/14/test_20230114001.jpg"
}
```

### 本地资源通用下载
- **接口地址**: `GET /common/download/resource`
- **接口描述**: 本地资源通用下载
- **请求参数**: `resource` - 资源路径

---

## 🔐 验证码

### 获取验证码
- **接口地址**: `GET /captchaImage`
- **接口描述**: 生成验证码
- **响应示例**:
```json
{
  "code": 200,
  "msg": "操作成功",
  "captchaEnabled": true,
  "uuid": "uuid-string",
  "img": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA..."
}
```

---

## 📊 系统监控

### 服务器信息
- **接口地址**: `GET /monitor/server`
- **接口描述**: 获取服务器相关信息
- **权限标识**: `monitor:server:list`

### 缓存监控
- **接口地址**: `GET /monitor/cache`
- **接口描述**: 获取缓存监控信息
- **权限标识**: `monitor:cache:list`

### 在线用户监控
- **接口地址**: `GET /monitor/online/list`
- **接口描述**: 获取在线用户列表
- **权限标识**: `monitor:online:list`

### 强退用户
- **接口地址**: `DELETE /monitor/online/{tokenId}`
- **接口描述**: 强制退出用户
- **权限标识**: `monitor:online:forceLogout`

### 操作日志
- **接口地址**: `GET /monitor/operlog/list`
- **接口描述**: 获取操作日志列表
- **权限标识**: `monitor:operlog:list`

### 登录日志
- **接口地址**: `GET /monitor/logininfor/list`
- **接口描述**: 获取登录日志列表
- **权限标识**: `monitor:logininfor:list`

---

## 🧪 测试接口

### 获取测试用户列表
- **接口地址**: `GET /test/user/list`
- **接口描述**: 获取测试用户列表（Swagger示例接口）

### 获取测试用户详情
- **接口地址**: `GET /test/user/{userId}`
- **接口描述**: 根据用户ID获取测试用户详细信息

### 新增测试用户
- **接口地址**: `POST /test/user/save`
- **接口描述**: 新增测试用户

### 更新测试用户
- **接口地址**: `PUT /test/user/update`
- **接口描述**: 更新测试用户信息

### 删除测试用户
- **接口地址**: `DELETE /test/user/{userId}`
- **接口描述**: 删除测试用户

---

## 📝 通用响应格式

### 成功响应
```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {}
}
```

### 分页响应
```json
{
  "code": 200,
  "msg": "查询成功",
  "rows": [],
  "total": 0
}
```

### 错误响应
```json
{
  "code": 500,
  "msg": "系统异常，请联系管理员"
}
```

## 🔑 认证说明

- 除登录、验证码等公开接口外，其他接口都需要在请求头中携带token
- 请求头格式：`Authorization: Bearer {token}`
- token通过登录接口获取，有效期30分钟（可配置）

## 📋 权限说明

- 接口权限采用Spring Security + 自定义权限注解实现
- 权限标识格式：`模块:功能:操作`，如：`system:user:list`
- 超级管理员拥有所有权限：`*:*:*`

## 🌐 API文档访问

- **Swagger UI**: http://localhost:8080/swagger-ui/index.html
- **接口文档**: http://localhost:8080/doc.html

---

*此文档基于RuoYi-Vue v3.9.0版本生成，如有更新请及时同步修改。*
