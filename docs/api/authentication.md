# 认证授权接口文档

## 🔐 用户认证

### 1. 用户登录

**接口信息**
- **URL**: `POST /login`
- **描述**: 用户登录认证，获取访问令牌
- **Content-Type**: `application/json`

**请求参数**
```json
{
  "username": "admin",      // 用户名，必填
  "password": "admin123",   // 密码，必填
  "code": "1234",          // 验证码，必填
  "uuid": "uuid-string"    // 验证码UUID，必填
}
```

**响应示例**
```json
{
  "code": 200,
  "msg": "操作成功",
  "token": "eyJhbGciOiJIUzUxMiJ9.eyJsb2dpbl91c2VyX2tleSI6IjEyMzQ1Njc4LTEyMzQtMTIzNC0xMjM0LTEyMzQ1Njc4OTAiLCJleHAiOjE2NDUxNjc2MDB9.xxx"
}
```

**错误码**
- `500`: 用户名或密码错误
- `500`: 验证码错误
- `500`: 用户已被停用，请联系管理员

---

### 2. 获取用户信息

**接口信息**
- **URL**: `GET /getInfo`
- **描述**: 获取当前登录用户的详细信息
- **认证**: 需要Bearer Token

**请求头**
```
Authorization: Bearer {token}
```

**响应示例**
```json
{
  "code": 200,
  "msg": "操作成功",
  "user": {
    "userId": 1,
    "deptId": 103,
    "userName": "admin",
    "nickName": "超级管理员",
    "email": "ry@163.com",
    "phonenumber": "15888888888",
    "sex": "1",
    "avatar": "",
    "status": "0",
    "delFlag": "0",
    "loginIp": "127.0.0.1",
    "loginDate": "2023-01-14T10:30:00",
    "createBy": "admin",
    "createTime": "2023-01-01T00:00:00",
    "updateBy": "",
    "updateTime": null,
    "remark": "管理员"
  },
  "roles": ["admin"],
  "permissions": ["*:*:*"],
  "isDefaultModifyPwd": false,
  "isPasswordExpired": false
}
```

---

### 3. 获取路由信息

**接口信息**
- **URL**: `GET /getRouters`
- **描述**: 获取用户可访问的菜单路由信息
- **认证**: 需要Bearer Token

**响应示例**
```json
{
  "code": 200,
  "msg": "操作成功",
  "data": [
    {
      "name": "System",
      "path": "/system",
      "hidden": false,
      "redirect": "noRedirect",
      "component": "Layout",
      "alwaysShow": true,
      "meta": {
        "title": "系统管理",
        "icon": "system",
        "noCache": false,
        "link": null
      },
      "children": [
        {
          "name": "User",
          "path": "user",
          "hidden": false,
          "component": "system/user/index",
          "meta": {
            "title": "用户管理",
            "icon": "user",
            "noCache": false,
            "link": null
          }
        }
      ]
    }
  ]
}
```

---

### 4. 用户注册

**接口信息**
- **URL**: `POST /register`
- **描述**: 用户注册（需要开启注册功能）
- **Content-Type**: `application/json`

**请求参数**
```json
{
  "username": "newuser",     // 用户名，必填
  "password": "123456",      // 密码，必填
  "confirmPassword": "123456" // 确认密码，必填
}
```

**响应示例**
```json
{
  "code": 200,
  "msg": "注册成功"
}
```

---

### 5. 用户登出

**接口信息**
- **URL**: `POST /logout`
- **描述**: 用户登出，清除服务器端token
- **认证**: 需要Bearer Token

**响应示例**
```json
{
  "code": 200,
  "msg": "退出成功"
}
```

---

## 🔑 Token说明

### Token格式
- **类型**: JWT (JSON Web Token)
- **算法**: HS512
- **有效期**: 30分钟（可配置）
- **刷新机制**: 每次请求自动刷新

### Token使用
1. 登录成功后获取token
2. 后续请求在Header中携带：`Authorization: Bearer {token}`
3. token过期后需要重新登录

### Token配置
配置文件：`application.yml`
```yaml
token:
  header: Authorization    # token名称
  secret: abcdefghijklmnopqrstuvwxyz  # 密钥
  expireTime: 30          # 过期时间(分钟)
```

---

## 🛡️ 权限控制

### 权限注解
- `@PreAuthorize("@ss.hasPermi('system:user:list')")`: 检查用户是否有指定权限
- `@PreAuthorize("@ss.hasRole('admin')")`: 检查用户是否有指定角色

### 权限标识格式
- 格式：`模块:功能:操作`
- 示例：
  - `system:user:list`: 用户查询权限
  - `system:user:add`: 用户新增权限
  - `system:user:edit`: 用户修改权限
  - `system:user:remove`: 用户删除权限
  - `*:*:*`: 超级管理员权限

### 角色权限
- `admin`: 超级管理员，拥有所有权限
- `common`: 普通角色，拥有基础查看权限
- 可通过角色管理界面自定义角色权限

---

## ❌ 错误处理

### 常见错误码
- `401`: 未授权，token无效或已过期
- `403`: 禁止访问，权限不足
- `500`: 服务器内部错误

### 错误响应格式
```json
{
  "code": 401,
  "msg": "token已过期"
}
```

---

## 🔒 安全配置

### 密码策略
- 最小长度：5位
- 支持字母、数字、特殊字符
- 密码错误次数限制：5次
- 锁定时间：10分钟

### 验证码配置
- 类型：数学计算验证码
- 有效期：2分钟
- 字符长度：4位

### 会话管理
- 单用户登录：支持
- 会话超时：30分钟
- 并发会话控制：支持

---

*更新时间：2025-01-14*
