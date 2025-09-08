# RuoYi-Vue API接口文档中心

欢迎使用RuoYi-Vue后端API接口文档！本文档提供了完整的API接口说明和使用指南。

## 📚 文档导航

### 🚀 [快速参考](./quick-reference.md)
- API接口速查表
- 常用请求示例
- 状态码说明
- 权限标识说明

### 📖 [完整接口文档](./README.md)
- 所有接口的详细说明
- 请求参数和响应格式
- 完整的API概览

### 🔐 [认证授权](./authentication.md)
- 用户登录认证
- Token使用说明
- 权限控制机制
- 安全配置说明

### 🛠️ [系统管理](./system-management.md)
- 用户管理接口
- 角色权限管理
- 菜单管理接口
- 部门岗位管理

## 🎯 快速开始

### 1. 获取验证码
```http
GET /captchaImage
```

### 2. 用户登录
```http
POST /login
Content-Type: application/json

{
  "username": "admin",
  "password": "admin123",
  "code": "验证码",
  "uuid": "验证码UUID"
}
```

### 3. 使用Token访问接口
```http
GET /system/user/list
Authorization: Bearer {token}
```

## 🔧 开发工具

### Swagger在线文档
- **地址**: http://localhost:8080/swagger-ui/index.html
- **功能**: 在线API文档和接口调试

### Druid数据库监控
- **地址**: http://localhost:8080/druid
- **账号**: ruoyi / 123456

## 📋 接口分类

### 核心功能
- **认证授权**: 登录、权限验证、用户信息
- **用户管理**: 用户CRUD、密码重置、状态管理
- **角色管理**: 角色CRUD、权限分配、数据权限
- **菜单管理**: 菜单CRUD、树形结构、路由配置

### 系统管理
- **部门管理**: 部门CRUD、树形结构
- **岗位管理**: 岗位CRUD、状态管理
- **字典管理**: 字典类型、字典数据
- **系统配置**: 参数配置、缓存管理

### 扩展功能
- **通知公告**: 公告CRUD、发布管理
- **文件管理**: 文件上传下载
- **系统监控**: 服务器监控、在线用户、操作日志
- **代码生成**: 自动生成CRUD代码

## ⚡ 技术特性

- **认证方式**: JWT Token
- **权限控制**: RBAC角色权限模型
- **数据权限**: 支持多种数据范围控制
- **接口安全**: Spring Security + 自定义权限注解
- **参数验证**: Hibernate Validator
- **异常处理**: 全局异常处理机制

## 📞 联系支持

- **官方网站**: http://www.ruoyi.vip
- **开源地址**: https://gitee.com/y_project/RuoYi-Vue
- **问题反馈**: https://gitee.com/y_project/RuoYi-Vue/issues

---

**版本**: RuoYi-Vue v3.9.0  
**更新时间**: 2025-01-14  
**文档维护**: 开发团队
