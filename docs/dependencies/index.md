# RuoYi-Vue 依赖文档中心

欢迎使用RuoYi-Vue项目依赖文档！本文档详细介绍了项目中使用的各种依赖及其常用方法接口。

## 📚 文档导航

### 📋 [依赖概览](./README.md)
- 完整的依赖列表和版本信息
- 技术栈介绍
- 模块依赖关系
- 版本兼容性说明

### 🌟 [Spring Boot框架](./spring-boot.md)
- Spring Boot 2.5.15 核心特性
- 自动配置和起步依赖
- 常用注解使用方法
- Web开发和数据访问
- 配置管理和监控
- 开发工具和最佳实践

### 💾 [数据库相关](./database.md)
- MySQL数据库连接配置
- Druid连接池使用和监控
- MyBatis ORM框架详解
- PageHelper分页插件
- Redis缓存操作
- 数据库监控和优化

### 🛡️ [安全认证](./security.md)
- Spring Security安全框架
- JWT Token生成和验证
- BCrypt密码加密
- Kaptcha验证码生成
- 权限控制和数据权限
- 安全最佳实践

### 🔧 [工具类库](./utils.md)
- FastJSON2/Jackson JSON处理
- Apache POI Excel操作
- Apache Commons工具类
- Velocity模板引擎
- Oshi系统监控
- UserAgentUtils用户代理解析

## 🎯 快速查找

### 按功能分类

#### 🌐 Web开发
- **Spring Boot Web**: 控制器、异常处理、参数验证
- **Spring MVC**: RESTful API、文件上传下载
- **Swagger**: API文档生成和在线调试

#### 💾 数据处理
- **MySQL**: 数据库连接和SQL操作
- **MyBatis**: ORM映射和动态SQL
- **Redis**: 缓存操作和分布式锁
- **PageHelper**: 分页查询

#### 🛡️ 安全控制
- **Spring Security**: 认证授权框架
- **JWT**: Token生成验证
- **权限注解**: @PreAuthorize使用
- **验证码**: 图形验证码生成

#### 🔧 工具辅助
- **JSON**: 对象序列化反序列化
- **Excel**: 数据导入导出
- **模板**: 代码生成和报告生成
- **监控**: 系统性能监控

### 按依赖名称

| 依赖名称 | 版本 | 功能 | 文档链接 |
|---------|------|------|----------|
| Spring Boot | 2.5.15 | 核心框架 | [详细文档](./spring-boot.md) |
| Spring Security | 5.7.14 | 安全认证 | [详细文档](./security.md) |
| Druid | 1.2.23 | 连接池 | [详细文档](./database.md#druid连接池) |
| MyBatis | - | ORM框架 | [详细文档](./database.md#mybatis框架) |
| PageHelper | 1.4.7 | 分页插件 | [详细文档](./database.md#pagehelper分页插件) |
| FastJSON2 | 2.0.58 | JSON处理 | [详细文档](./utils.md#json处理) |
| Apache POI | 4.1.2 | Excel操作 | [详细文档](./utils.md#excel处理-apache-poi) |
| JWT | 0.9.1 | Token生成 | [详细文档](./security.md#jwt-token) |
| Kaptcha | 2.3.3 | 验证码 | [详细文档](./security.md#kaptcha验证码) |
| Swagger | 3.0.0 | API文档 | [详细文档](./README.md#文档接口) |
| Velocity | 2.3 | 模板引擎 | [详细文档](./utils.md#velocity模板引擎) |
| Oshi | 6.8.3 | 系统监控 | [详细文档](./utils.md#oshi系统监控) |

## 🚀 快速开始

### 1. 环境准备
确保您的开发环境满足以下要求：
- JDK 1.8+
- Maven 3.6+
- MySQL 5.7+
- Redis 3.0+

### 2. 常用依赖配置

#### Maven依赖管理
```xml
<dependencyManagement>
    <dependencies>
        <!-- Spring Boot BOM -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-dependencies</artifactId>
            <version>2.5.15</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

#### 核心配置
```yaml
# application.yml
spring:
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/ry-vue
  redis:
    host: localhost
    port: 6379
    database: 0
```

### 3. 代码示例

#### 控制器开发
```java
@RestController
@RequestMapping("/api")
public class DemoController {
    
    @GetMapping("/hello")
    public AjaxResult hello() {
        return AjaxResult.success("Hello RuoYi!");
    }
}
```

#### 数据访问
```java
@Mapper
public interface UserMapper {
    List<SysUser> selectUserList(SysUser user);
}
```

#### 缓存使用
```java
@Autowired
private RedisCache redisCache;

public void cacheUser(SysUser user) {
    redisCache.setCacheObject("user:" + user.getUserId(), user, 30, TimeUnit.MINUTES);
}
```

## 💡 开发建议

### 1. 依赖选择
- **JSON处理**: 优先使用FastJSON2，性能更好
- **日期处理**: 使用Java 8的LocalDateTime
- **字符串操作**: 使用Apache Commons Lang3
- **文件操作**: 使用Apache Commons IO

### 2. 性能优化
- 合理配置连接池参数
- 使用Redis缓存热点数据
- 启用分页查询避免大结果集
- 使用异步处理提升响应速度

### 3. 安全考虑
- 所有接口都要进行权限校验
- 敏感信息不要记录到日志
- 使用参数化查询防止SQL注入
- 定期更新依赖版本修复安全漏洞

## 🔗 相关链接

### 官方文档
- [Spring Boot官方文档](https://spring.io/projects/spring-boot)
- [Spring Security官方文档](https://spring.io/projects/spring-security)
- [MyBatis官方文档](https://mybatis.org/mybatis-3/)
- [Apache Commons官方文档](https://commons.apache.org/)

### 社区资源
- [RuoYi官网](http://www.ruoyi.vip)
- [RuoYi源码](https://gitee.com/y_project/RuoYi-Vue)
- [Spring Boot中文文档](https://springboot.io/)

## 📞 技术支持

如果您在使用过程中遇到问题，可以通过以下方式获取帮助：

1. **查阅文档**: 首先查看相关依赖的详细文档
2. **搜索问题**: 在项目Issues中搜索类似问题
3. **社区求助**: 在技术社区发布问题
4. **官方支持**: 联系RuoYi官方技术支持

---

**版本**: RuoYi-Vue v3.9.0  
**更新时间**: 2025-01-14  
**文档维护**: 开发团队
