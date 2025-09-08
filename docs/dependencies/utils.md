# 工具类库依赖使用指南

## 📋 工具库概览

- **JSON处理**: FastJSON2 2.0.58, Jackson
- **Excel操作**: Apache POI 4.1.2
- **通用工具**: Apache Commons Lang3, Commons IO 2.19.0
- **模板引擎**: Velocity 2.3
- **系统监控**: Oshi 6.8.3
- **用户代理**: UserAgentUtils 1.21
- **配置解析**: SnakeYAML

---

## 🚀 JSON处理

### 1. FastJSON2 (推荐)

#### 基本使用
```java
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.JSONArray;

// 对象转JSON字符串
SysUser user = new SysUser();
String jsonString = JSON.toJSONString(user);

// JSON字符串转对象
SysUser user = JSON.parseObject(jsonString, SysUser.class);

// 处理JSONObject
JSONObject jsonObject = JSON.parseObject(jsonString);
String userName = jsonObject.getString("userName");
Long userId = jsonObject.getLong("userId");

// 处理JSONArray
String arrayJson = "[{\"name\":\"张三\"},{\"name\":\"李四\"}]";
JSONArray jsonArray = JSON.parseArray(arrayJson);
List<SysUser> userList = JSON.parseArray(arrayJson, SysUser.class);
```

#### 高级特性
```java
// 自定义序列化
@JSONField(format = "yyyy-MM-dd HH:mm:ss")
private Date createTime;

@JSONField(serialize = false)  // 序列化时忽略
private String password;

@JSONField(name = "user_name") // 自定义字段名
private String userName;

// 过滤null值
String json = JSON.toJSONString(user, JSONWriter.Feature.IgnoreNullValue);

// 格式化输出
String json = JSON.toJSONString(user, JSONWriter.Feature.PrettyFormat);

// 类型引用处理泛型
String json = "[{\"userId\":1,\"userName\":\"admin\"}]";
List<SysUser> users = JSON.parseObject(json, new TypeReference<List<SysUser>>(){});
```

### 2. Jackson (Spring Boot默认)

```java
@Autowired
private ObjectMapper objectMapper;

// 对象转JSON
String json = objectMapper.writeValueAsString(user);

// JSON转对象
SysUser user = objectMapper.readValue(json, SysUser.class);

// 处理泛型
List<SysUser> users = objectMapper.readValue(json, new TypeReference<List<SysUser>>(){});

// 配置ObjectMapper
@Bean
@Primary
public ObjectMapper objectMapper() {
    ObjectMapper mapper = new ObjectMapper();
    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
    return mapper;
}
```

---

## 📊 Excel处理 (Apache POI)

### 1. Excel读取

```java
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelReader {
    
    public List<SysUser> readUsersFromExcel(InputStream inputStream) throws IOException {
        List<SysUser> users = new ArrayList<>();
        
        try (Workbook workbook = new XSSFWorkbook(inputStream)) {
            Sheet sheet = workbook.getSheetAt(0);
            
            for (Row row : sheet) {
                if (row.getRowNum() == 0) continue; // 跳过标题行
                
                SysUser user = new SysUser();
                user.setUserName(getCellValue(row.getCell(0)));
                user.setNickName(getCellValue(row.getCell(1)));
                user.setEmail(getCellValue(row.getCell(2)));
                user.setPhonenumber(getCellValue(row.getCell(3)));
                
                users.add(user);
            }
        }
        
        return users;
    }
    
    private String getCellValue(Cell cell) {
        if (cell == null) return "";
        
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
                } else {
                    return String.valueOf((long) cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            default:
                return "";
        }
    }
}
```

### 2. Excel导出

```java
public class ExcelExporter {
    
    public void exportUsers(List<SysUser> users, HttpServletResponse response) throws IOException {
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("用户数据");
            
            // 创建标题行
            Row headerRow = sheet.createRow(0);
            String[] headers = {"用户名", "昵称", "邮箱", "手机号", "状态", "创建时间"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                
                // 设置样式
                CellStyle headerStyle = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                headerStyle.setFont(font);
                cell.setCellStyle(headerStyle);
            }
            
            // 填充数据
            for (int i = 0; i < users.size(); i++) {
                Row row = sheet.createRow(i + 1);
                SysUser user = users.get(i);
                
                row.createCell(0).setCellValue(user.getUserName());
                row.createCell(1).setCellValue(user.getNickName());
                row.createCell(2).setCellValue(user.getEmail());
                row.createCell(3).setCellValue(user.getPhonenumber());
                row.createCell(4).setCellValue("0".equals(user.getStatus()) ? "正常" : "停用");
                
                if (user.getCreateTime() != null) {
                    Cell dateCell = row.createCell(5);
                    dateCell.setCellValue(user.getCreateTime());
                    
                    // 设置日期格式
                    CellStyle dateStyle = workbook.createCellStyle();
                    CreationHelper createHelper = workbook.getCreationHelper();
                    dateStyle.setDataFormat(createHelper.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));
                    dateCell.setCellStyle(dateStyle);
                }
            }
            
            // 自动调整列宽
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }
            
            // 设置响应头
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=users.xlsx");
            
            workbook.write(response.getOutputStream());
        }
    }
}
```

### 3. 项目中的Excel工具类

```java
public class ExcelUtil<T> {
    
    private Class<T> clazz;
    
    public ExcelUtil(Class<T> clazz) {
        this.clazz = clazz;
    }
    
    /**
     * 导出Excel
     */
    public void exportExcel(HttpServletResponse response, List<T> list, String sheetName) {
        try {
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setCharacterEncoding("utf-8");
            String fileName = URLEncoder.encode(sheetName, "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
            
            EasyExcel.write(response.getOutputStream(), clazz).sheet(sheetName).doWrite(list);
        } catch (IOException e) {
            throw new ServiceException("导出Excel异常");
        }
    }
    
    /**
     * 导入Excel
     */
    public List<T> importExcel(InputStream is) throws Exception {
        return EasyExcel.read(is).head(clazz).sheet().doReadSync();
    }
}
```

---

## 🛠️ Apache Commons工具类

### 1. Commons Lang3

#### 字符串工具
```java
import org.apache.commons.lang3.StringUtils;

// 判空
StringUtils.isEmpty(str);          // null或""为true
StringUtils.isBlank(str);          // null、""或空白字符为true
StringUtils.isNotEmpty(str);       // 非空
StringUtils.isNotBlank(str);       // 非空白

// 默认值
String result = StringUtils.defaultIfEmpty(str, "默认值");
String result = StringUtils.defaultIfBlank(str, "默认值");

// 字符串操作
StringUtils.trim(str);             // 去除两端空白
StringUtils.strip(str);            // 去除两端空白(包括全角空格)
StringUtils.capitalize(str);       // 首字母大写
StringUtils.uncapitalize(str);     // 首字母小写

// 字符串判断
StringUtils.equals(str1, str2);    // 安全比较
StringUtils.equalsIgnoreCase(str1, str2); // 忽略大小写比较
StringUtils.contains(str, searchStr);     // 包含判断
StringUtils.startsWith(str, prefix);      // 前缀判断
StringUtils.endsWith(str, suffix);        // 后缀判断

// 字符串分割和连接
String[] array = StringUtils.split(str, ",");
String result = StringUtils.join(array, ",");
String result = StringUtils.join(list, ",");

// 字符串替换
StringUtils.replace(str, "old", "new");
StringUtils.replaceEach(str, new String[]{"a", "b"}, new String[]{"A", "B"});
```

#### 数组工具
```java
import org.apache.commons.lang3.ArrayUtils;

// 数组判空
ArrayUtils.isEmpty(array);
ArrayUtils.isNotEmpty(array);

// 数组操作
int[] newArray = ArrayUtils.add(array, element);        // 添加元素
int[] newArray = ArrayUtils.remove(array, index);       // 移除元素
int[] newArray = ArrayUtils.removeElement(array, element); // 移除指定元素

// 数组包含
boolean contains = ArrayUtils.contains(array, element);

// 数组转换
Integer[] objArray = ArrayUtils.toObject(intArray);     // 基本类型转包装类型
int[] primitiveArray = ArrayUtils.toPrimitive(objArray); // 包装类型转基本类型
```

#### 随机工具
```java
import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.lang3.RandomStringUtils;

// 随机数
int randomInt = RandomUtils.nextInt(1, 100);           // 1-99之间随机数
long randomLong = RandomUtils.nextLong(1L, 1000L);     // 随机长整型
double randomDouble = RandomUtils.nextDouble(0.0, 1.0); // 随机小数

// 随机字符串
String randomStr = RandomStringUtils.randomAlphabetic(10);      // 随机字母
String randomStr = RandomStringUtils.randomNumeric(6);         // 随机数字
String randomStr = RandomStringUtils.randomAlphanumeric(8);    // 字母数字
String randomStr = RandomStringUtils.random(10, "abcdefg");    // 指定字符集
```

### 2. Commons IO

#### 文件操作
```java
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

// 文件读写
String content = FileUtils.readFileToString(file, "UTF-8");
List<String> lines = FileUtils.readLines(file, "UTF-8");
FileUtils.writeStringToFile(file, content, "UTF-8");
FileUtils.writeLines(file, lines, "UTF-8");

// 文件复制
FileUtils.copyFile(srcFile, destFile);
FileUtils.copyDirectory(srcDir, destDir);
FileUtils.copyToDirectory(srcFile, destDir);

// 文件删除
FileUtils.deleteQuietly(file);                // 静默删除
FileUtils.deleteDirectory(directory);         // 删除目录
FileUtils.cleanDirectory(directory);          // 清空目录

// 文件信息
long size = FileUtils.sizeOf(file);           // 文件大小
String sizeStr = FileUtils.byteCountToDisplaySize(size); // 格式化大小

// 文件名操作
String extension = FilenameUtils.getExtension(filename);     // 获取扩展名
String baseName = FilenameUtils.getBaseName(filename);       // 获取文件名(不含扩展名)
String fullPath = FilenameUtils.getFullPath(filename);       // 获取路径
```

#### IO流操作
```java
import org.apache.commons.io.IOUtils;

// 流转换
String content = IOUtils.toString(inputStream, "UTF-8");
List<String> lines = IOUtils.readLines(inputStream, "UTF-8");
byte[] bytes = IOUtils.toByteArray(inputStream);

// 流复制
IOUtils.copy(inputStream, outputStream);
IOUtils.copyLarge(inputStream, outputStream);

// 安全关闭
IOUtils.closeQuietly(inputStream);
IOUtils.closeQuietly(outputStream);
```

---

## 🎨 Velocity模板引擎

### 1. 基本配置

```java
@Configuration
public class VelocityConfig {
    
    @Bean
    public VelocityEngine velocityEngine() {
        Properties props = new Properties();
        props.put("resource.loader", "class");
        props.put("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        props.put("input.encoding", "UTF-8");
        props.put("output.encoding", "UTF-8");
        
        VelocityEngine engine = new VelocityEngine(props);
        return engine;
    }
}
```

### 2. 模板使用

#### 模板文件 (template.vm)
```velocity
## 用户信息模板
#set($title = "用户列表")
<html>
<head>
    <title>$title</title>
</head>
<body>
    <h1>$title</h1>
    <table>
        <tr>
            <th>用户名</th>
            <th>昵称</th>
            <th>邮箱</th>
            <th>状态</th>
        </tr>
        #foreach($user in $userList)
        <tr>
            <td>$user.userName</td>
            <td>$user.nickName</td>
            <td>$user.email</td>
            <td>#if($user.status == "0")正常#{else}停用#end</td>
        </tr>
        #end
    </table>
    
    ## 条件判断
    #if($userList.size() > 0)
        <p>共有 $userList.size() 个用户</p>
    #else
        <p>暂无用户数据</p>
    #end
    
    ## 循环控制
    #foreach($user in $userList)
        #if($velocityCount == 1)
            <p>第一个用户: $user.userName</p>
        #end
        #if($foreach.hasNext)
            <p>还有下一个用户</p>
        #end
    #end
</body>
</html>
```

#### Java代码生成
```java
@Service
public class TemplateService {
    
    @Autowired
    private VelocityEngine velocityEngine;
    
    public String generateUserReport(List<SysUser> userList) {
        VelocityContext context = new VelocityContext();
        context.put("userList", userList);
        context.put("currentDate", new Date());
        context.put("totalCount", userList.size());
        
        Template template = velocityEngine.getTemplate("templates/user-report.vm", "UTF-8");
        StringWriter writer = new StringWriter();
        template.merge(context, writer);
        
        return writer.toString();
    }
    
    public void generateCodeFile(Map<String, Object> params, String templatePath, String outputPath) {
        VelocityContext context = new VelocityContext(params);
        
        Template template = velocityEngine.getTemplate(templatePath, "UTF-8");
        
        try (FileWriter writer = new FileWriter(outputPath)) {
            template.merge(context, writer);
        } catch (IOException e) {
            throw new ServiceException("生成文件失败: " + e.getMessage());
        }
    }
}
```

---

## 📊 Oshi系统监控

### 1. 系统信息获取

```java
import oshi.SystemInfo;
import oshi.hardware.*;
import oshi.software.os.*;

@Component
public class SystemMonitor {
    
    private SystemInfo systemInfo = new SystemInfo();
    private HardwareAbstractionLayer hardware = systemInfo.getHardware();
    private OperatingSystem operatingSystem = systemInfo.getOperatingSystem();
    
    /**
     * 获取CPU信息
     */
    public Map<String, Object> getCpuInfo() {
        CentralProcessor processor = hardware.getProcessor();
        
        Map<String, Object> cpuInfo = new HashMap<>();
        cpuInfo.put("name", processor.getProcessorIdentifier().getName());
        cpuInfo.put("physicalPackageCount", processor.getPhysicalPackageCount());
        cpuInfo.put("physicalProcessorCount", processor.getPhysicalProcessorCount());
        cpuInfo.put("logicalProcessorCount", processor.getLogicalProcessorCount());
        
        // CPU使用率
        long[] prevTicks = processor.getSystemCpuLoadTicks();
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        long[] ticks = processor.getSystemCpuLoadTicks();
        double cpuUsage = processor.getSystemCpuLoadBetweenTicks(prevTicks) * 100;
        cpuInfo.put("usage", String.format("%.2f", cpuUsage));
        
        return cpuInfo;
    }
    
    /**
     * 获取内存信息
     */
    public Map<String, Object> getMemoryInfo() {
        GlobalMemory memory = hardware.getMemory();
        
        Map<String, Object> memInfo = new HashMap<>();
        long total = memory.getTotal();
        long available = memory.getAvailable();
        long used = total - available;
        
        memInfo.put("total", formatBytes(total));
        memInfo.put("used", formatBytes(used));
        memInfo.put("available", formatBytes(available));
        memInfo.put("usageRate", String.format("%.2f", (double) used / total * 100));
        
        return memInfo;
    }
    
    /**
     * 获取磁盘信息
     */
    public List<Map<String, Object>> getDiskInfo() {
        List<HWDiskStore> diskStores = hardware.getDiskStores();
        List<Map<String, Object>> diskList = new ArrayList<>();
        
        for (HWDiskStore disk : diskStores) {
            Map<String, Object> diskInfo = new HashMap<>();
            diskInfo.put("name", disk.getName());
            diskInfo.put("model", disk.getModel());
            diskInfo.put("size", formatBytes(disk.getSize()));
            diskInfo.put("reads", disk.getReads());
            diskInfo.put("writes", disk.getWrites());
            
            diskList.add(diskInfo);
        }
        
        return diskList;
    }
    
    /**
     * 获取系统信息
     */
    public Map<String, Object> getSystemInfo() {
        Map<String, Object> sysInfo = new HashMap<>();
        
        sysInfo.put("osName", operatingSystem.getFamily());
        sysInfo.put("osVersion", operatingSystem.getVersionInfo().toString());
        sysInfo.put("osArch", System.getProperty("os.arch"));
        sysInfo.put("computerName", operatingSystem.getNetworkParams().getHostName());
        sysInfo.put("userDir", System.getProperty("user.dir"));
        
        return sysInfo;
    }
    
    /**
     * 获取JVM信息
     */
    public Map<String, Object> getJvmInfo() {
        Map<String, Object> jvmInfo = new HashMap<>();
        
        Runtime runtime = Runtime.getRuntime();
        long total = runtime.totalMemory();
        long free = runtime.freeMemory();
        long used = total - free;
        long max = runtime.maxMemory();
        
        jvmInfo.put("javaVersion", System.getProperty("java.version"));
        jvmInfo.put("javaVendor", System.getProperty("java.vendor"));
        jvmInfo.put("javaHome", System.getProperty("java.home"));
        jvmInfo.put("total", formatBytes(total));
        jvmInfo.put("used", formatBytes(used));
        jvmInfo.put("free", formatBytes(free));
        jvmInfo.put("max", formatBytes(max));
        jvmInfo.put("usage", String.format("%.2f", (double) used / total * 100));
        
        return jvmInfo;
    }
    
    private String formatBytes(long bytes) {
        if (bytes < 1024) {
            return bytes + " B";
        }
        int exp = (int) (Math.log(bytes) / Math.log(1024));
        String pre = "KMGTPE".charAt(exp - 1) + "";
        return String.format("%.2f %sB", bytes / Math.pow(1024, exp), pre);
    }
}
```

---

## 🌐 UserAgentUtils

### 1. 用户代理解析

```java
import eu.bitwalker.useragentutils.UserAgent;
import eu.bitwalker.useragentutils.Browser;
import eu.bitwalker.useragentutils.OperatingSystem;

@Component
public class UserAgentService {
    
    /**
     * 解析用户代理字符串
     */
    public Map<String, String> parseUserAgent(String userAgentString) {
        UserAgent userAgent = UserAgent.parseUserAgentString(userAgentString);
        
        Map<String, String> info = new HashMap<>();
        
        // 浏览器信息
        Browser browser = userAgent.getBrowser();
        info.put("browser", browser.getName());
        info.put("browserVersion", userAgent.getBrowserVersion().getVersion());
        info.put("browserType", browser.getBrowserType().getName());
        
        // 操作系统信息
        OperatingSystem os = userAgent.getOperatingSystem();
        info.put("os", os.getName());
        info.put("osGroup", os.getGroup().getName());
        info.put("deviceType", os.getDeviceType().getName());
        
        return info;
    }
    
    /**
     * 获取客户端信息
     */
    public String getClientInfo(HttpServletRequest request) {
        String userAgentString = request.getHeader("User-Agent");
        if (StringUtils.isBlank(userAgentString)) {
            return "Unknown";
        }
        
        Map<String, String> info = parseUserAgent(userAgentString);
        return info.get("os") + " " + info.get("browser");
    }
    
    /**
     * 判断是否为移动端
     */
    public boolean isMobile(String userAgentString) {
        UserAgent userAgent = UserAgent.parseUserAgentString(userAgentString);
        OperatingSystem os = userAgent.getOperatingSystem();
        return os.getDeviceType().getName().equals("Mobile");
    }
}
```

---

## ⚠️ 使用建议

### 1. JSON处理选择
- **FastJSON2**: 性能更好，推荐用于高频JSON操作
- **Jackson**: Spring Boot默认，与框架集成更好

### 2. Excel处理优化
- 大数据量使用流式处理
- 设置合理的内存配置
- 及时关闭资源

### 3. 工具类使用
- 优先使用Apache Commons工具类
- 注意空指针安全
- 合理使用缓存

### 4. 模板引擎
- 模板文件统一管理
- 注意模板安全性
- 合理使用缓存

---

*更新时间：2025-01-14*
