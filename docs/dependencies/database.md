# 数据库相关依赖使用指南

## 📋 数据库技术栈

- **数据库**: MySQL 8.0+
- **连接池**: Druid 1.2.23
- **ORM框架**: MyBatis
- **分页插件**: PageHelper 1.4.7
- **缓存**: Redis + Lettuce

---

## 💾 MySQL数据库

### 1. 驱动配置

```xml
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
</dependency>
```

### 2. 连接配置

```yaml
# application-druid.yml
spring:
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driverClassName: com.mysql.cj.jdbc.Driver
    druid:
      master:
        url: jdbc:mysql://localhost:3306/ry-vue?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8
        username: root
        password: password
```

### 3. 常用SQL示例

```sql
-- 创建数据库
CREATE DATABASE `ry-vue` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 创建用户表
CREATE TABLE sys_user (
  user_id           bigint(20)      NOT NULL AUTO_INCREMENT    COMMENT '用户ID',
  dept_id           bigint(20)      DEFAULT NULL               COMMENT '部门ID',
  user_name         varchar(30)     NOT NULL                   COMMENT '用户账号',
  nick_name         varchar(30)     NOT NULL                   COMMENT '用户昵称',
  email             varchar(50)     DEFAULT ''                 COMMENT '用户邮箱',
  phonenumber       varchar(11)     DEFAULT ''                 COMMENT '手机号码',
  sex               char(1)         DEFAULT '0'                COMMENT '用户性别',
  status            char(1)         DEFAULT '0'                COMMENT '帐号状态',
  create_by         varchar(64)     DEFAULT ''                 COMMENT '创建者',
  create_time       datetime                                   COMMENT '创建时间',
  update_by         varchar(64)     DEFAULT ''                 COMMENT '更新者',
  update_time       datetime                                   COMMENT '更新时间',
  PRIMARY KEY (user_id)
) ENGINE=InnoDB COMMENT = '用户信息表';
```

---

## 🏊 Druid连接池

### 1. 基本配置

```yaml
spring:
  datasource:
    druid:
      # 初始连接数
      initialSize: 5
      # 最小连接池数量
      minIdle: 10
      # 最大连接池数量
      maxActive: 20
      # 配置获取连接等待超时的时间
      maxWait: 60000
      # 配置连接超时时间
      connectTimeout: 30000
      # 配置网络超时时间
      socketTimeout: 60000
```

### 2. 监控配置

```yaml
spring:
  datasource:
    druid:
      # Web统计过滤器
      webStatFilter:
        enabled: true
      # 监控页面配置
      statViewServlet:
        enabled: true
        url-pattern: /druid/*
        login-username: ruoyi
        login-password: 123456
      # 过滤器配置
      filter:
        stat:
          enabled: true
          log-slow-sql: true
          slow-sql-millis: 1000
```

### 3. Java配置类

```java
@Configuration
public class DruidConfig {
    
    @Bean
    @ConfigurationProperties("spring.datasource.druid")
    public DataSource dataSource() {
        DruidDataSource datasource = new DruidDataSource();
        return datasource;
    }
    
    /**
     * 配置监控页面
     */
    @Bean
    public ServletRegistrationBean<StatViewServlet> druidStatViewServlet() {
        ServletRegistrationBean<StatViewServlet> bean = new ServletRegistrationBean<>(new StatViewServlet(), "/druid/*");
        
        // 白名单设置
        bean.addInitParameter("allow", "");
        // 黑名单设置
        bean.addInitParameter("deny", "");
        // 用户名密码
        bean.addInitParameter("loginUsername", "ruoyi");
        bean.addInitParameter("loginPassword", "123456");
        
        return bean;
    }
}
```

### 4. 监控使用

- **访问地址**: http://localhost:8080/druid
- **功能**:
  - SQL监控
  - 连接池监控
  - 慢SQL分析
  - Web应用监控

---

## 🗺️ MyBatis框架

### 1. 配置文件

```yaml
# application.yml
mybatis:
  # 搜索指定包别名
  typeAliasesPackage: com.ruoyi.**.domain
  # 配置mapper的扫描，找到所有的mapper.xml映射文件
  mapperLocations: classpath*:mapper/**/*Mapper.xml
  # 加载全局的配置文件
  configLocation: classpath:mybatis/mybatis-config.xml
```

```xml
<!-- mybatis-config.xml -->
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <settings>
        <!-- 使全局的映射器启用或禁用缓存 -->
        <setting name="cacheEnabled" value="true" />
        <!-- 允许JDBC 支持自动生成主键 -->
        <setting name="useGeneratedKeys" value="true" />
        <!-- 配置默认的执行器 -->
        <setting name="defaultExecutorType" value="SIMPLE" />
        <!-- 指定 MyBatis 所用日志的具体实现 -->
        <setting name="logImpl" value="SLF4J" />
    </settings>
</configuration>
```

### 2. Mapper接口

```java
@Mapper
public interface SysUserMapper {
    
    /**
     * 查询用户信息
     */
    public SysUser selectUserById(Long userId);
    
    /**
     * 查询用户列表
     */
    public List<SysUser> selectUserList(SysUser user);
    
    /**
     * 新增用户信息
     */
    public int insertUser(SysUser user);
    
    /**
     * 修改用户信息
     */
    public int updateUser(SysUser user);
    
    /**
     * 删除用户信息
     */
    public int deleteUserById(Long userId);
    
    /**
     * 批量删除用户信息
     */
    public int deleteUserByIds(Long[] userIds);
}
```

### 3. XML映射文件

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.ruoyi.system.mapper.SysUserMapper">

    <resultMap type="SysUser" id="SysUserResult">
        <id     property="userId"       column="user_id"      />
        <result property="deptId"       column="dept_id"      />
        <result property="userName"     column="user_name"    />
        <result property="nickName"     column="nick_name"    />
        <result property="email"        column="email"        />
        <result property="phonenumber"  column="phonenumber"  />
        <result property="sex"          column="sex"          />
        <result property="status"       column="status"       />
        <result property="createBy"     column="create_by"    />
        <result property="createTime"   column="create_time"  />
        <result property="updateBy"     column="update_by"    />
        <result property="updateTime"   column="update_time"  />
        <result property="remark"       column="remark"       />
        <association property="dept"    column="dept_id" javaType="SysDept" resultMap="deptResult" />
        <collection  property="roles"   javaType="java.util.List" resultMap="RoleResult" />
    </resultMap>

    <sql id="selectUserVo">
        select u.user_id, u.dept_id, u.user_name, u.nick_name, u.email, u.avatar, u.phonenumber, u.password, u.sex, u.status, u.del_flag, u.login_ip, u.login_date, u.create_by, u.create_time, u.remark,
               d.dept_id, d.parent_id, d.dept_name, d.order_num, d.leader, d.status as dept_status,
               r.role_id, r.role_name, r.role_key, r.role_sort, r.data_scope, r.status as role_status
        from sys_user u
		    left join sys_dept d on u.dept_id = d.dept_id
		    left join sys_user_role ur on u.user_id = ur.user_id
		    left join sys_role r on r.role_id = ur.role_id
    </sql>

    <select id="selectUserList" parameterType="SysUser" resultMap="SysUserResult">
		<include refid="selectUserVo"/>
		where u.del_flag = '0'
		<if test="userId != null and userId != 0">
			AND u.user_id = #{userId}
		</if>
		<if test="userName != null and userName != ''">
			AND u.user_name like concat('%', #{userName}, '%')
		</if>
		<if test="status != null and status != ''">
			AND u.status = #{status}
		</if>
		<if test="phonenumber != null and phonenumber != ''">
			AND u.phonenumber like concat('%', #{phonenumber}, '%')
		</if>
		<if test="params.beginTime != null and params.beginTime != ''"><!-- 开始时间检索 -->
			AND date_format(u.create_time,'%y%m%d') &gt;= date_format(#{params.beginTime},'%y%m%d')
		</if>
		<if test="params.endTime != null and params.endTime != ''"><!-- 结束时间检索 -->
			AND date_format(u.create_time,'%y%m%d') &lt;= date_format(#{params.endTime},'%y%m%d')
		</if>
		<if test="deptId != null and deptId != 0">
			AND (u.dept_id = #{deptId} OR u.dept_id IN ( SELECT t.dept_id FROM sys_dept t WHERE find_in_set(#{deptId}, ancestors) ))
		</if>
    </select>

    <insert id="insertUser" parameterType="SysUser" useGeneratedKeys="true" keyProperty="userId">
 		insert into sys_user(
 			<if test="userId != null and userId != 0">user_id,</if>
 			<if test="deptId != null and deptId != 0">dept_id,</if>
 			<if test="userName != null and userName != ''">user_name,</if>
 			<if test="nickName != null and nickName != ''">nick_name,</if>
 			<if test="email != null and email != ''">email,</if>
 			<if test="phonenumber != null and phonenumber != ''">phonenumber,</if>
 			<if test="sex != null and sex != ''">sex,</if>
 			<if test="password != null and password != ''">password,</if>
 			<if test="status != null and status != ''">status,</if>
 			<if test="createBy != null and createBy != ''">create_by,</if>
 			<if test="remark != null and remark != ''">remark,</if>
 			create_time
 		)values(
 			<if test="userId != null and userId != ''">#{userId},</if>
 			<if test="deptId != null and deptId != ''">#{deptId},</if>
 			<if test="userName != null and userName != ''">#{userName},</if>
 			<if test="nickName != null and nickName != ''">#{nickName},</if>
 			<if test="email != null and email != ''">#{email},</if>
 			<if test="phonenumber != null and phonenumber != ''">#{phonenumber},</if>
 			<if test="sex != null and sex != ''">#{sex},</if>
 			<if test="password != null and password != ''">#{password},</if>
 			<if test="status != null and status != ''">#{status},</if>
 			<if test="createBy != null and createBy != ''">#{createBy},</if>
 			<if test="remark != null and remark != ''">#{remark},</if>
 			sysdate()
 		)
	</insert>
</mapper>
```

### 4. 动态SQL

```xml
<!-- 动态WHERE条件 -->
<select id="selectUserByCondition" resultType="SysUser">
    SELECT * FROM sys_user
    <where>
        <if test="userName != null and userName != ''">
            AND user_name = #{userName}
        </if>
        <if test="status != null and status != ''">
            AND status = #{status}
        </if>
    </where>
</select>

<!-- 动态SET更新 -->
<update id="updateUserSelective" parameterType="SysUser">
    UPDATE sys_user
    <set>
        <if test="userName != null and userName != ''">user_name = #{userName},</if>
        <if test="nickName != null and nickName != ''">nick_name = #{nickName},</if>
        <if test="email != null and email != ''">email = #{email},</if>
        <if test="status != null and status != ''">status = #{status},</if>
        update_time = sysdate()
    </set>
    WHERE user_id = #{userId}
</update>

<!-- 批量插入 -->
<insert id="batchInsertUser">
    INSERT INTO sys_user (user_name, nick_name, email, status, create_time)
    VALUES
    <foreach collection="list" item="user" separator=",">
        (#{user.userName}, #{user.nickName}, #{user.email}, #{user.status}, sysdate())
    </foreach>
</insert>
```

---

## 📄 PageHelper分页插件

### 1. 配置

```yaml
# application.yml
pagehelper:
  helperDialect: mysql
  supportMethodsArguments: true
  params: count=countSql
```

### 2. 使用方式

```java
@Service
public class UserServiceImpl implements IUserService {
    
    @Override
    public List<SysUser> selectUserList(SysUser user) {
        // 开启分页
        PageHelper.startPage(user.getPageNum(), user.getPageSize());
        return userMapper.selectUserList(user);
    }
}

@RestController
public class UserController extends BaseController {
    
    @GetMapping("/list")
    public TableDataInfo list(SysUser user) {
        // 开始分页
        startPage();
        List<SysUser> list = userService.selectUserList(user);
        // 返回分页结果
        return getDataTable(list);
    }
}
```

### 3. 高级用法

```java
// 不进行count查询
PageHelper.startPage(1, 10, false);

// 设置排序
PageHelper.startPage(1, 10, "user_id desc");

// 手动分页
Page<SysUser> page = PageHelper.startPage(1, 10).doSelectPage(() -> userMapper.selectUserList(user));

// 获取分页信息
PageInfo<SysUser> pageInfo = new PageInfo<>(list);
```

---

## 🔴 Redis缓存

### 1. 配置

```yaml
# application.yml
spring:
  redis:
    host: localhost
    port: 6379
    database: 0
    password: 
    timeout: 10s
    lettuce:
      pool:
        min-idle: 0
        max-idle: 8
        max-active: 8
        max-wait: -1ms
```

### 2. RedisTemplate配置

```java
@Configuration
public class RedisConfig {
    
    @Bean
    @SuppressWarnings(value = { "unchecked", "rawtypes" })
    public RedisTemplate<Object, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<Object, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);

        FastJson2JsonRedisSerializer serializer = new FastJson2JsonRedisSerializer(Object.class);

        // 使用StringRedisSerializer来序列化和反序列化redis的key值
        template.setKeySerializer(new StringRedisSerializer());
        template.setValueSerializer(serializer);

        // Hash的key也采用StringRedisSerializer的序列化方式
        template.setHashKeySerializer(new StringRedisSerializer());
        template.setHashValueSerializer(serializer);

        template.afterPropertiesSet();
        return template;
    }
}
```

### 3. 缓存工具类

```java
@Component
public class RedisCache {
    
    @Autowired
    public RedisTemplate redisTemplate;

    /**
     * 缓存基本的对象
     */
    public <T> void setCacheObject(final String key, final T value) {
        redisTemplate.opsForValue().set(key, value);
    }

    /**
     * 缓存基本的对象，设置过期时间
     */
    public <T> void setCacheObject(final String key, final T value, final Integer timeout, final TimeUnit timeUnit) {
        redisTemplate.opsForValue().set(key, value, timeout, timeUnit);
    }

    /**
     * 获得缓存的基本对象
     */
    public <T> T getCacheObject(final String key) {
        ValueOperations<String, T> operation = redisTemplate.opsForValue();
        return operation.get(key);
    }

    /**
     * 删除单个对象
     */
    public boolean deleteObject(final String key) {
        return redisTemplate.delete(key);
    }

    /**
     * 缓存List数据
     */
    public <T> long setCacheList(final String key, final List<T> dataList) {
        Long count = redisTemplate.opsForList().rightPushAll(key, dataList);
        return count == null ? 0 : count;
    }

    /**
     * 获得缓存的list对象
     */
    public <T> List<T> getCacheList(final String key) {
        return redisTemplate.opsForList().range(key, 0, -1);
    }
}
```

### 4. 使用示例

```java
@Service
public class UserServiceImpl implements IUserService {
    
    @Autowired
    private RedisCache redisCache;
    
    private static final String USER_CACHE_KEY = "user:info:";
    
    @Override
    public SysUser selectUserById(Long userId) {
        String cacheKey = USER_CACHE_KEY + userId;
        
        // 先从缓存获取
        SysUser user = redisCache.getCacheObject(cacheKey);
        if (user != null) {
            return user;
        }
        
        // 缓存不存在，查询数据库
        user = userMapper.selectUserById(userId);
        if (user != null) {
            // 存入缓存，设置30分钟过期
            redisCache.setCacheObject(cacheKey, user, 30, TimeUnit.MINUTES);
        }
        
        return user;
    }
}
```

---

## 📊 数据库监控

### 1. SQL监控

```java
@Component
public class SqlMonitorInterceptor implements Interceptor {
    
    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        long startTime = System.currentTimeMillis();
        Object result = invocation.proceed();
        long endTime = System.currentTimeMillis();
        
        // 记录SQL执行时间
        if (endTime - startTime > 1000) {
            log.warn("慢SQL检测: 执行时间{}ms", endTime - startTime);
        }
        
        return result;
    }
}
```

### 2. 连接池监控

```java
@RestController
@RequestMapping("/monitor")
public class DatabaseMonitorController {
    
    @Autowired
    private DataSource dataSource;
    
    @GetMapping("/datasource")
    public AjaxResult getDataSourceInfo() {
        if (dataSource instanceof DruidDataSource) {
            DruidDataSource druidDataSource = (DruidDataSource) dataSource;
            
            Map<String, Object> info = new HashMap<>();
            info.put("activeCount", druidDataSource.getActiveCount());
            info.put("maxActive", druidDataSource.getMaxActive());
            info.put("poolingCount", druidDataSource.getPoolingCount());
            info.put("connectCount", druidDataSource.getConnectCount());
            
            return AjaxResult.success(info);
        }
        return AjaxResult.error("不支持的数据源类型");
    }
}
```

---

## ⚠️ 最佳实践

### 1. 数据库设计
- 使用合适的数据类型
- 建立必要的索引
- 避免过深的表关联
- 合理设计分库分表

### 2. SQL优化
- 避免SELECT *
- 使用LIMIT分页
- 合理使用索引
- 避免N+1查询

### 3. 连接池配置
- 根据并发量调整连接数
- 设置合理的超时时间
- 启用连接验证
- 监控连接池状态

### 4. 缓存策略
- 合理设置过期时间
- 避免缓存雪崩
- 处理缓存穿透
- 定期清理过期数据

---

*更新时间：2025-01-14*
