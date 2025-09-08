# 系统管理接口文档

## 👥 用户管理

### 1. 获取用户列表

**接口信息**
- **URL**: `GET /system/user/list`
- **描述**: 分页查询用户列表
- **权限**: `system:user:list`

**请求参数**
| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| pageNum | int | 否 | 页码，默认1 |
| pageSize | int | 否 | 每页条数，默认10 |
| userName | string | 否 | 用户名 |
| phonenumber | string | 否 | 手机号码 |
| status | string | 否 | 状态(0正常 1停用) |
| deptId | long | 否 | 部门ID |
| beginTime | string | 否 | 开始时间 |
| endTime | string | 否 | 结束时间 |

**响应示例**
```json
{
  "code": 200,
  "msg": "查询成功",
  "rows": [
    {
      "userId": 1,
      "deptId": 103,
      "userName": "admin",
      "nickName": "超级管理员",
      "userType": "00",
      "email": "ry@163.com",
      "phonenumber": "15888888888",
      "sex": "1",
      "avatar": "",
      "status": "0",
      "delFlag": "0",
      "loginIp": "127.0.0.1",
      "loginDate": "2023-01-14T10:30:00",
      "dept": {
        "deptId": 103,
        "deptName": "研发部门"
      },
      "roles": [
        {
          "roleId": 1,
          "roleName": "超级管理员",
          "roleKey": "admin"
        }
      ]
    }
  ],
  "total": 1
}
```

### 2. 获取用户详情

**接口信息**
- **URL**: `GET /system/user/{userId}`
- **描述**: 根据用户ID获取详细信息
- **权限**: `system:user:query`

**路径参数**
| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| userId | long | 是 | 用户ID |

**响应示例**
```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "userId": 1,
    "userName": "admin",
    "nickName": "超级管理员",
    "email": "ry@163.com",
    "phonenumber": "15888888888",
    "sex": "1",
    "status": "0",
    "deptId": 103,
    "roles": [1],
    "roleIds": [1],
    "postIds": [1]
  },
  "posts": [
    {
      "postId": 1,
      "postCode": "ceo",
      "postName": "董事长"
    }
  ],
  "roles": [
    {
      "roleId": 1,
      "roleName": "超级管理员",
      "roleKey": "admin",
      "flag": false
    }
  ]
}
```

### 3. 新增用户

**接口信息**
- **URL**: `POST /system/user`
- **描述**: 新增用户
- **权限**: `system:user:add`

**请求体**
```json
{
  "userName": "testuser",      // 用户名，必填
  "nickName": "测试用户",       // 用户昵称，必填
  "password": "123456",        // 密码，必填
  "email": "test@example.com", // 邮箱
  "phonenumber": "13800138000", // 手机号
  "sex": "0",                  // 性别(0男 1女 2未知)
  "status": "0",               // 状态(0正常 1停用)
  "deptId": 100,              // 部门ID
  "postIds": [1],             // 岗位ID数组
  "roleIds": [2],             // 角色ID数组
  "remark": "备注信息"         // 备注
}
```

**响应示例**
```json
{
  "code": 200,
  "msg": "操作成功"
}
```

### 4. 修改用户

**接口信息**
- **URL**: `PUT /system/user`
- **描述**: 修改用户信息
- **权限**: `system:user:edit`

**请求体**
```json
{
  "userId": 2,                // 用户ID，必填
  "userName": "testuser",     // 用户名，必填
  "nickName": "测试用户",      // 用户昵称，必填
  "email": "test@example.com", // 邮箱
  "phonenumber": "13800138000", // 手机号
  "sex": "0",                 // 性别
  "status": "0",              // 状态
  "deptId": 100,             // 部门ID
  "postIds": [1],            // 岗位ID数组
  "roleIds": [2],            // 角色ID数组
  "remark": "修改备注"        // 备注
}
```

### 5. 删除用户

**接口信息**
- **URL**: `DELETE /system/user/{userIds}`
- **描述**: 批量删除用户
- **权限**: `system:user:remove`

**路径参数**
| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| userIds | string | 是 | 用户ID，多个用逗号分隔 |

**响应示例**
```json
{
  "code": 200,
  "msg": "删除成功"
}
```

### 6. 重置密码

**接口信息**
- **URL**: `PUT /system/user/resetPwd`
- **描述**: 重置用户密码
- **权限**: `system:user:resetPwd`

**请求体**
```json
{
  "userId": 2,
  "password": "123456"
}
```

### 7. 修改用户状态

**接口信息**
- **URL**: `PUT /system/user/changeStatus`
- **描述**: 启用/停用用户
- **权限**: `system:user:edit`

**请求体**
```json
{
  "userId": 2,
  "status": "1"  // 0正常 1停用
}
```

---

## 🛡️ 角色管理

### 1. 获取角色列表

**接口信息**
- **URL**: `GET /system/role/list`
- **描述**: 分页查询角色列表
- **权限**: `system:role:list`

**请求参数**
| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| pageNum | int | 否 | 页码 |
| pageSize | int | 否 | 每页条数 |
| roleName | string | 否 | 角色名称 |
| roleKey | string | 否 | 权限字符 |
| status | string | 否 | 状态 |
| beginTime | string | 否 | 开始时间 |
| endTime | string | 否 | 结束时间 |

**响应示例**
```json
{
  "code": 200,
  "msg": "查询成功",
  "rows": [
    {
      "roleId": 1,
      "roleName": "超级管理员",
      "roleKey": "admin",
      "roleSort": 1,
      "dataScope": "1",
      "menuCheckStrictly": true,
      "deptCheckStrictly": true,
      "status": "0",
      "delFlag": "0",
      "createBy": "admin",
      "createTime": "2023-01-01T00:00:00",
      "updateBy": "",
      "updateTime": null,
      "remark": "超级管理员",
      "flag": false,
      "menuIds": null,
      "deptIds": null,
      "permissions": null,
      "admin": true
    }
  ],
  "total": 1
}
```

### 2. 获取角色详情

**接口信息**
- **URL**: `GET /system/role/{roleId}`
- **描述**: 根据角色ID获取详细信息
- **权限**: `system:role:query`

### 3. 新增角色

**接口信息**
- **URL**: `POST /system/role`
- **描述**: 新增角色
- **权限**: `system:role:add`

**请求体**
```json
{
  "roleName": "测试角色",      // 角色名称，必填
  "roleKey": "test",          // 权限字符，必填
  "roleSort": 3,             // 显示顺序，必填
  "status": "0",             // 状态(0正常 1停用)
  "menuIds": [1, 2, 3],      // 菜单权限ID数组
  "deptIds": [100, 101],     // 部门权限ID数组
  "dataScope": "2",          // 数据范围(1:全部数据权限 2:自定数据权限 3:本部门数据权限 4:本部门及以下数据权限)
  "remark": "测试角色"        // 备注
}
```

### 4. 修改角色

**接口信息**
- **URL**: `PUT /system/role`
- **描述**: 修改角色信息
- **权限**: `system:role:edit`

### 5. 删除角色

**接口信息**
- **URL**: `DELETE /system/role/{roleIds}`
- **描述**: 批量删除角色
- **权限**: `system:role:remove`

### 6. 分配数据权限

**接口信息**
- **URL**: `PUT /system/role/dataScope`
- **描述**: 修改角色数据权限
- **权限**: `system:role:edit`

**请求体**
```json
{
  "roleId": 2,
  "roleName": "普通角色",
  "roleKey": "common",
  "dataScope": "2",         // 数据范围
  "deptIds": [100, 101]     // 部门权限
}
```

---

## 🏗️ 菜单管理

### 1. 获取菜单列表

**接口信息**
- **URL**: `GET /system/menu/list`
- **描述**: 获取菜单列表
- **权限**: `system:menu:list`

**请求参数**
| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| menuName | string | 否 | 菜单名称 |
| status | string | 否 | 状态 |

**响应示例**
```json
{
  "code": 200,
  "msg": "操作成功",
  "data": [
    {
      "menuId": 1,
      "menuName": "系统管理",
      "parentId": 0,
      "orderNum": 1,
      "path": "system",
      "component": null,
      "query": "",
      "isFrame": "1",
      "isCache": "0",
      "menuType": "M",
      "visible": "0",
      "status": "0",
      "perms": "",
      "icon": "system",
      "createBy": "admin",
      "createTime": "2023-01-01T00:00:00",
      "updateBy": "",
      "updateTime": null,
      "remark": "系统管理目录",
      "children": [
        {
          "menuId": 100,
          "menuName": "用户管理",
          "parentId": 1,
          "orderNum": 1,
          "path": "user",
          "component": "system/user/index",
          "query": "",
          "isFrame": "1",
          "isCache": "0",
          "menuType": "C",
          "visible": "0",
          "status": "0",
          "perms": "system:user:list",
          "icon": "user",
          "children": []
        }
      ]
    }
  ]
}
```

### 2. 获取菜单详情

**接口信息**
- **URL**: `GET /system/menu/{menuId}`
- **描述**: 根据菜单ID获取详细信息
- **权限**: `system:menu:query`

### 3. 新增菜单

**接口信息**
- **URL**: `POST /system/menu`
- **描述**: 新增菜单
- **权限**: `system:menu:add`

**请求体**
```json
{
  "menuName": "测试菜单",        // 菜单名称，必填
  "parentId": 0,               // 父菜单ID
  "orderNum": 1,               // 显示顺序
  "path": "test",              // 路由地址
  "component": "test/index",   // 组件路径
  "query": "",                 // 路由参数
  "isFrame": "1",              // 是否为外链(0是 1否)
  "isCache": "0",              // 是否缓存(0缓存 1不缓存)
  "menuType": "C",             // 菜单类型(M目录 C菜单 F按钮)
  "visible": "0",              // 显示状态(0显示 1隐藏)
  "status": "0",               // 菜单状态(0正常 1停用)
  "perms": "system:test:list", // 权限标识
  "icon": "test",              // 菜单图标
  "remark": "测试菜单"          // 备注
}
```

### 4. 修改菜单

**接口信息**
- **URL**: `PUT /system/menu`
- **描述**: 修改菜单信息
- **权限**: `system:menu:edit`

### 5. 删除菜单

**接口信息**
- **URL**: `DELETE /system/menu/{menuId}`
- **描述**: 删除菜单
- **权限**: `system:menu:remove`

---

## 🏢 部门管理

### 1. 获取部门列表

**接口信息**
- **URL**: `GET /system/dept/list`
- **描述**: 获取部门列表
- **权限**: `system:dept:list`

**请求参数**
| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| deptName | string | 否 | 部门名称 |
| status | string | 否 | 状态 |

**响应示例**
```json
{
  "code": 200,
  "msg": "操作成功",
  "data": [
    {
      "deptId": 100,
      "parentId": 0,
      "ancestors": "0",
      "deptName": "若依科技",
      "orderNum": 0,
      "leader": "若依",
      "phone": "15888888888",
      "email": "ry@qq.com",
      "status": "0",
      "delFlag": "0",
      "createBy": "admin",
      "createTime": "2023-01-01T00:00:00",
      "updateBy": "",
      "updateTime": null,
      "children": [
        {
          "deptId": 101,
          "parentId": 100,
          "ancestors": "0,100",
          "deptName": "深圳总公司",
          "orderNum": 1,
          "leader": "若依",
          "phone": "15888888888",
          "email": "ry@qq.com",
          "status": "0",
          "delFlag": "0",
          "children": []
        }
      ]
    }
  ]
}
```

### 2. 获取部门详情

**接口信息**
- **URL**: `GET /system/dept/{deptId}`
- **描述**: 根据部门ID获取详细信息
- **权限**: `system:dept:query`

### 3. 新增部门

**接口信息**
- **URL**: `POST /system/dept`
- **描述**: 新增部门
- **权限**: `system:dept:add`

**请求体**
```json
{
  "parentId": 100,           // 父部门ID
  "deptName": "测试部门",     // 部门名称，必填
  "orderNum": 1,            // 显示顺序
  "leader": "张三",          // 负责人
  "phone": "13800138000",   // 联系电话
  "email": "test@qq.com",   // 邮箱
  "status": "0"             // 状态(0正常 1停用)
}
```

### 4. 修改部门

**接口信息**
- **URL**: `PUT /system/dept`
- **描述**: 修改部门信息
- **权限**: `system:dept:edit`

### 5. 删除部门

**接口信息**
- **URL**: `DELETE /system/dept/{deptId}`
- **描述**: 删除部门
- **权限**: `system:dept:remove`

---

## 💼 岗位管理

### 1. 获取岗位列表

**接口信息**
- **URL**: `GET /system/post/list`
- **描述**: 分页查询岗位列表
- **权限**: `system:post:list`

**请求参数**
| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| pageNum | int | 否 | 页码 |
| pageSize | int | 否 | 每页条数 |
| postCode | string | 否 | 岗位编码 |
| postName | string | 否 | 岗位名称 |
| status | string | 否 | 状态 |

**响应示例**
```json
{
  "code": 200,
  "msg": "查询成功",
  "rows": [
    {
      "postId": 1,
      "postCode": "ceo",
      "postName": "董事长",
      "postSort": 1,
      "status": "0",
      "createBy": "admin",
      "createTime": "2023-01-01T00:00:00",
      "updateBy": "",
      "updateTime": null,
      "remark": "",
      "flag": false
    }
  ],
  "total": 1
}
```

### 2. 获取岗位详情

**接口信息**
- **URL**: `GET /system/post/{postId}`
- **描述**: 根据岗位ID获取详细信息
- **权限**: `system:post:query`

### 3. 新增岗位

**接口信息**
- **URL**: `POST /system/post`
- **描述**: 新增岗位
- **权限**: `system:post:add`

**请求体**
```json
{
  "postCode": "test",        // 岗位编码，必填
  "postName": "测试岗位",     // 岗位名称，必填
  "postSort": 1,            // 显示顺序，必填
  "status": "0",            // 状态(0正常 1停用)
  "remark": "测试岗位"       // 备注
}
```

### 4. 修改岗位

**接口信息**
- **URL**: `PUT /system/post`
- **描述**: 修改岗位信息
- **权限**: `system:post:edit`

### 5. 删除岗位

**接口信息**
- **URL**: `DELETE /system/post/{postIds}`
- **描述**: 批量删除岗位
- **权限**: `system:post:remove`

---

*更新时间：2025-01-14*
