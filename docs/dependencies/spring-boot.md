# Spring Boot 使用指南

## 📋 基本信息

- **版本**: 2.5.15
- **官方文档**: https://spring.io/projects/spring-boot
- **用途**: 项目核心框架，简化Spring应用开发

---

## 🚀 核心特性

### 1. 自动配置
Spring Boot会根据类路径中的依赖自动配置应用程序。

```java
@SpringBootApplication
public class RuoYiApplication {
    public static void main(String[] args) {
        SpringApplication.run(RuoYiApplication.class, args);
    }
}
```

### 2. 起步依赖
通过starter依赖简化依赖管理。

```xml
<!-- Web开发起步依赖 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>

<!-- 安全认证起步依赖 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

---

## 🔧 常用注解

### 1. 核心注解

#### @SpringBootApplication
```java
@SpringBootApplication
// 等同于以下三个注解的组合
// @EnableAutoConfiguration
// @ComponentScan
// @Configuration
public class RuoYiApplication {
    // 启动类代码
}
```

#### @RestController
```java
@RestController
@RequestMapping("/api/user")
public class UserController {
    
    @GetMapping("/list")
    public AjaxResult getUserList() {
        // 返回用户列表
        return AjaxResult.success(userList);
    }
}
```

#### @Service
```java
@Service
public class UserServiceImpl implements IUserService {
    
    @Autowired
    private UserMapper userMapper;
    
    @Override
    public List<SysUser> selectUserList(SysUser user) {
        return userMapper.selectUserList(user);
    }
}
```

### 2. 配置注解

#### @ConfigurationProperties
```java
@Component
@ConfigurationProperties(prefix = "ruoyi")
public class RuoYiConfig {
    
    private String name;
    private String version;
    
    // getter and setter
}
```

#### @Value
```java
@Service
public class ConfigService {
    
    @Value("${ruoyi.name}")
    private String projectName;
    
    @Value("${server.port:8080}")
    private int serverPort;
}
```

---

## 🌐 Web开发

### 1. 控制器开发

```java
@RestController
@RequestMapping("/system/user")
public class SysUserController extends BaseController {
    
    @Autowired
    private ISysUserService userService;
    
    /**
     * 获取用户列表
     */
    @PreAuthorize("@ss.hasPermi('system:user:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysUser user) {
        startPage();
        List<SysUser> list = userService.selectUserList(user);
        return getDataTable(list);
    }
    
    /**
     * 新增用户
     */
    @PreAuthorize("@ss.hasPermi('system:user:add')")
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysUser user) {
        if (StringUtils.isNotEmpty(user.getUserName()) 
            && UserConstants.NOT_UNIQUE.equals(userService.checkUserNameUnique(user.getUserName()))) {
            return AjaxResult.error("新增用户'" + user.getUserName() + "'失败，登录账号已存在");
        }
        user.setCreateBy(getUsername());
        user.setPassword(SecurityUtils.encryptPassword(user.getPassword()));
        return toAjax(userService.insertUser(user));
    }
}
```

### 2. 异常处理

```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    
    /**
     * 权限校验异常
     */
    @ExceptionHandler(AccessDeniedException.class)
    public AjaxResult handleAccessDeniedException(AccessDeniedException e) {
        return AjaxResult.error(HttpStatus.FORBIDDEN, "没有权限，请联系管理员授权");
    }
    
    /**
     * 请求参数类型不匹配
     */
    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public AjaxResult handleMethodArgumentTypeMismatchException(MethodArgumentTypeMismatchException e) {
        return AjaxResult.error("请求参数类型不匹配");
    }
}
```

---

## 📊 数据访问

### 1. JPA方式（可选）

```java
@Entity
@Table(name = "sys_user")
public class SysUser {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;
    
    @Column(name = "user_name")
    private String userName;
    
    // getter and setter
}

@Repository
public interface UserRepository extends JpaRepository<SysUser, Long> {
    
    List<SysUser> findByUserName(String userName);
    
    @Query("SELECT u FROM SysUser u WHERE u.status = ?1")
    List<SysUser> findByStatus(String status);
}
```

### 2. MyBatis集成（项目采用）

```java
// Mapper接口
@Mapper
public interface SysUserMapper {
    
    /**
     * 查询用户列表
     */
    public List<SysUser> selectUserList(SysUser user);
    
    /**
     * 新增用户
     */
    public int insertUser(SysUser user);
}
```

---

## ⚙️ 配置管理

### 1. 配置文件

#### application.yml
```yaml
# 项目相关配置
ruoyi:
  name: RuoYi
  version: 3.9.0
  copyrightYear: 2025

# 服务器配置
server:
  port: 8080
  servlet:
    context-path: /

# 数据源配置
spring:
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/ry-vue
    username: root
    password: password
```

### 2. 多环境配置

```yaml
# application.yml
spring:
  profiles:
    active: dev

---
# application-dev.yml (开发环境)
spring:
  profiles: dev
  datasource:
    url: jdbc:mysql://localhost:3306/ry-vue-dev

---
# application-prod.yml (生产环境)
spring:
  profiles: prod
  datasource:
    url: jdbc:mysql://prod-server:3306/ry-vue-prod
```

---

## 🔍 测试支持

### 1. 单元测试

```java
@SpringBootTest
@RunWith(SpringRunner.class)
public class UserServiceTest {
    
    @Autowired
    private ISysUserService userService;
    
    @Test
    public void testSelectUserList() {
        SysUser user = new SysUser();
        user.setUserName("admin");
        
        List<SysUser> userList = userService.selectUserList(user);
        Assert.assertNotNull(userList);
        Assert.assertTrue(userList.size() > 0);
    }
}
```

### 2. Web测试

```java
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureTestDatabase
public class UserControllerTest {
    
    @Autowired
    private TestRestTemplate restTemplate;
    
    @Test
    public void testGetUserList() {
        ResponseEntity<String> response = restTemplate.getForEntity("/system/user/list", String.class);
        Assert.assertEquals(HttpStatus.OK, response.getStatusCode());
    }
}
```

---

## 📈 监控管理

### 1. Actuator端点

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```

```yaml
# 配置监控端点
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics
  endpoint:
    health:
      show-details: when_authorized
```

### 2. 健康检查

```java
@Component
public class CustomHealthIndicator implements HealthIndicator {
    
    @Override
    public Health health() {
        // 自定义健康检查逻辑
        if (checkExternalService()) {
            return Health.up()
                    .withDetail("external-service", "Available")
                    .build();
        } else {
            return Health.down()
                    .withDetail("external-service", "Unavailable")
                    .build();
        }
    }
}
```

---

## 🔧 开发工具

### 1. DevTools热部署

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <optional>true</optional>
</dependency>
```

**配置**:
```yaml
spring:
  devtools:
    restart:
      enabled: true
      additional-paths: src/main/java
    livereload:
      enabled: true
```

### 2. 配置处理器

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-configuration-processor</artifactId>
    <optional>true</optional>
</dependency>
```

---

## 📚 最佳实践

### 1. 项目结构
```
src/main/java/
├── com.ruoyi/
│   ├── RuoYiApplication.java          # 启动类
│   ├── web/controller/                # 控制器层
│   ├── framework/config/              # 配置类
│   └── common/                        # 通用组件
src/main/resources/
├── application.yml                    # 主配置文件
├── application-dev.yml                # 开发环境配置
├── static/                           # 静态资源
└── templates/                        # 模板文件
```

### 2. 配置类编写
```java
@Configuration
@EnableConfigurationProperties(RuoYiConfig.class)
public class ApplicationConfig {
    
    @Bean
    @ConditionalOnMissingBean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
    
    @Bean
    @ConditionalOnProperty(name = "ruoyi.redis.enabled", havingValue = "true")
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);
        return template;
    }
}
```

### 3. 日志配置
```yaml
logging:
  level:
    com.ruoyi: debug
    org.springframework: warn
  pattern:
    console: "%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{50} - %msg%n"
    file: "%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{50} - %msg%n"
  file:
    name: logs/ruoyi.log
```

---

## ⚠️ 注意事项

1. **版本兼容**: 确保依赖版本兼容性
2. **自动配置**: 理解自动配置原理，避免配置冲突
3. **性能优化**: 合理使用缓存和连接池
4. **安全配置**: 生产环境关闭不必要的端点
5. **日志管理**: 合理设置日志级别和输出格式

---

*更新时间：2025-01-14*
