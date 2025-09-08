# RuoYi-Vue 项目依赖文档

**版本**: v3.9.0
**创建日期**: 2025-01-14

---

## 📋 目录

1. [依赖概览](#依赖概览)
2. [核心框架](#核心框架)
3. [数据库相关](#数据库相关)
4. [安全认证](#安全认证)
5. [工具类库](#工具类库)
6. [文档接口](#文档接口)
7. [监控运维](#监控运维)
8. [代码生成](#代码生成)
9. [其他依赖](#其他依赖)

---

## 🎯 依赖概览

### 核心技术栈

| 技术             | 版本   | 用途         |
| ---------------- | ------ | ------------ |
| Spring Boot      | 2.5.15 | 核心框架     |
| Spring Framework | 5.3.39 | Spring框架   |
| Spring Security  | 5.7.14 | 安全认证     |
| MyBatis          | 3.5.x  | ORM框架      |
| Druid            | 1.2.23 | 数据库连接池 |
| Redis            | -      | 缓存数据库   |
| MySQL            | 8.0+   | 关系型数据库 |

### 主要功能依赖

| 依赖       | 版本   | 功能      |
| ---------- | ------ | --------- |
| PageHelper | 1.4.7  | 分页插件  |
| FastJSON2  | 2.0.58 | JSON解析  |
| JWT        | 0.9.1  | Token生成 |
| Swagger    | 3.0.0  | API文档   |
| POI        | 4.1.2  | Excel处理 |
| Kaptcha    | 2.3.3  | 验证码    |
| Velocity   | 2.3    | 模板引擎  |
| Oshi       | 6.8.3  | 系统监控  |

---

## 🌟 核心框架

### 1. Spring Boot

- **版本**: 2.5.15
- **用途**: 项目核心框架，提供自动配置和快速开发能力
- **主要模块**:
  - `spring-boot-starter-web`: Web开发
  - `spring-boot-starter-aop`: AOP切面编程
  - `spring-boot-starter-validation`: 参数验证
  - `spring-boot-starter-data-redis`: Redis支持
  - `spring-boot-devtools`: 开发工具

### 2. Spring Framework

- **版本**: 5.3.39
- **用途**: Spring核心框架
- **主要模块**:
  - `spring-context-support`: 上下文支持
  - `spring-web`: Web支持

### 3. Spring Security

- **版本**: 5.7.14
- **用途**: 安全认证框架
- **功能**: 认证、授权、防护

---

## 💾 数据库相关

### 1. MySQL驱动

- **依赖**: `mysql-connector-java`
- **用途**: MySQL数据库连接驱动
- **支持版本**: MySQL 5.7+

### 2. Druid连接池

- **版本**: 1.2.23
- **依赖**: `druid-spring-boot-starter`
- **用途**: 阿里巴巴数据库连接池
- **特性**: 监控、防SQL注入、性能统计

### 3. MyBatis

- **用途**: ORM框架，通过Spring Boot自动配置
- **配置**: `mybatis-config.xml`

### 4. PageHelper

- **版本**: 1.4.7
- **依赖**: `pagehelper-spring-boot-starter`
- **用途**: MyBatis分页插件

### 5. Redis

- **依赖**: `spring-boot-starter-data-redis`
- **用途**: 缓存数据库支持
- **连接池**: Lettuce + Commons Pool2

---

## 🛡️ 安全认证

### 1. Spring Security

- **依赖**: `spring-boot-starter-security`
- **功能**:
  - 用户认证
  - 权限授权
  - 密码加密
  - CSRF防护

### 2. JWT

- **版本**: 0.9.1
- **依赖**: `jjwt`
- **用途**: JSON Web Token生成和解析
- **算法**: HS512

### 3. Kaptcha验证码

- **版本**: 2.3.3
- **依赖**: `kaptcha`
- **用途**: 图形验证码生成
- **类型**: 数学计算、字符验证

---

## 🔧 工具类库

### 1. Apache Commons

- **Commons Lang3**: 通用工具类
- **Commons IO** (2.19.0): IO操作工具
- **Commons Pool2**: 对象池

### 2. JSON处理

- **FastJSON2** (2.0.58): 阿里JSON解析器
- **Jackson**: Spring Boot默认JSON处理器

### 3. Excel处理

- **Apache POI** (4.1.2): Excel读写操作
- **依赖**: `poi-ooxml`
- **支持格式**: .xlsx, .xls

### 4. 配置文件解析

- **SnakeYAML**: YAML配置文件解析
- **JAXB**: XML绑定支持

### 5. 用户代理解析

- **UserAgentUtils** (1.21): 解析客户端操作系统、浏览器信息
- **依赖**: `eu.bitwalker:UserAgentUtils`

---

## 📚 文档接口

### 1. Swagger

- **版本**: 3.0.0
- **依赖**: `springfox-boot-starter`
- **用途**: API文档生成和在线调试
- **访问地址**: http://localhost:8080/swagger-ui/index.html

### 2. Swagger Models

- **版本**: 1.6.2 (手动指定)
- **用途**: 修复类型转换错误

---

## 📊 监控运维

### 1. Oshi

- **版本**: 6.8.3
- **依赖**: `oshi-core`
- **用途**: 获取系统信息
- **功能**: CPU、内存、磁盘、网络监控

### 2. Druid监控

- **功能**: SQL监控、连接池监控
- **访问地址**: http://localhost:8080/druid
- **账号**: ruoyi / 123456

### 3. Spring Boot Actuator

- **用途**: 应用监控和管理
- **端点**: 健康检查、指标收集

---

## 🔨 代码生成

### 1. Velocity

- **版本**: 2.3
- **依赖**: `velocity-engine-core`
- **用途**: 代码生成模板引擎
- **模板位置**: `ruoyi-generator/src/main/resources/vm/`

### 2. 代码生成器

- **模块**: `ruoyi-generator`
- **功能**: 根据数据库表自动生成CRUD代码
- **支持**: Controller、Service、Mapper、Vue页面

---

## 🎯 其他依赖

### 1. Servlet API

- **依赖**: `javax.servlet-api`
- **用途**: Servlet规范支持

### 2. 定时任务

- **模块**: `ruoyi-quartz`
- **功能**: Quartz定时任务支持

### 3. 日志框架

- **Logback** (1.2.13): 日志记录
- **SLF4J**: 日志门面

### 4. Tomcat

- **版本**: 9.0.108
- **用途**: 内嵌Web服务器

---

## 📦 模块依赖关系

```
ruoyi-admin (启动模块)
├── ruoyi-framework (框架核心)
│   ├── ruoyi-system (系统模块)
│   │   └── ruoyi-common (通用工具)
│   └── ruoyi-common
├── ruoyi-quartz (定时任务)
│   └── ruoyi-common
└── ruoyi-generator (代码生成)
    └── ruoyi-common
```

---

## 🔍 版本兼容性

### Java版本

- **要求**: JDK 1.8+
- **推荐**: JDK 1.8 / JDK 11

### 数据库版本

- **MySQL**: 5.7+ / 8.0+
- **Redis**: 3.0+

### 浏览器支持

- Chrome 60+
- Firefox 60+
- Safari 12+
- Edge 79+

---

## 📝 依赖管理

### Maven仓库

- **阿里云仓库**: https://maven.aliyun.com/repository/public
- **中央仓库**: Maven Central

### 版本管理

- 统一在父POM中管理版本
- 使用 `<dependencyManagement>`统一版本
- 子模块继承版本配置

### 依赖排除

- Swagger中排除旧版本models
- Kaptcha中排除servlet-api
- 避免版本冲突

---

*更新时间：2025-01-14*
