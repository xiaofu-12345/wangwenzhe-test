# Java脚手架工具 (Java Scaffolding Tool)

这是一个简单而强大的Java项目脚手架工具，可以快速创建标准的Maven Java项目结构。

## 功能特点 (Features)

- 🚀 快速创建Java Maven项目
- 📁 标准的Maven目录结构
- 🧪 包含JUnit 5测试框架
- 📝 自动生成示例代码和测试
- 🌐 支持中英双语
- ⚙️ 可自定义项目配置

## 安装和使用 (Installation and Usage)

### 前提条件 (Prerequisites)

- Java 17 或更高版本
- Apache Maven 3.6+
- Bash shell (Linux/macOS) 或 Git Bash (Windows)

### 基本使用 (Basic Usage)

```bash
# 使用默认配置创建项目
./java-scaffold.sh

# 自定义项目配置
./java-scaffold.sh -a my-project -p com.mycompany.myproject

# 查看所有选项
./java-scaffold.sh --help
```

### 命令行选项 (Command Line Options)

| 选项 (Option) | 描述 (Description) | 默认值 (Default) |
|---------------|-------------------|------------------|
| `-h, --help` | 显示帮助信息 | - |
| `-g, --group-id` | Maven Group ID | com.example |
| `-a, --artifact-id` | Maven Artifact ID | my-java-app |
| `-v, --version` | 项目版本号 | 1.0.0 |
| `-p, --package` | Java包名 | com.example.app |
| `-m, --main-class` | 主类名 | Application |
| `-d, --directory` | 项目目录 | 使用artifact-id |

### 使用示例 (Examples)

```bash
# 创建一个Web应用项目
./java-scaffold.sh \
  --artifact-id my-web-app \
  --package com.mycompany.webapp \
  --main-class WebApplication

# 创建一个微服务项目
./java-scaffold.sh \
  --group-id com.mycompany \
  --artifact-id user-service \
  --package com.mycompany.userservice \
  --main-class UserServiceApplication

# 在指定目录创建项目
./java-scaffold.sh \
  --artifact-id hello-world \
  --directory ./projects/hello-world
```

## 生成的项目结构 (Generated Project Structure)

```
my-java-app/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/app/
│   │   │       ├── Application.java
│   │   │       └── GreetingService.java
│   │   └── resources/
│   └── test/
│       ├── java/
│       │   └── com/example/app/
│       │       └── GreetingServiceTest.java
│       └── resources/
├── pom.xml
├── .gitignore
└── README.md
```

## 生成的文件说明 (Generated Files Description)

### pom.xml
- 标准的Maven配置文件
- 预配置Java 17
- 包含JUnit 5测试依赖
- 包含常用的Maven插件

### 主类 (Main Class)
- 标准的Java main方法
- 支持命令行参数处理
- 包含中英双语输出

### 服务类 (Service Class)
- 演示基本的Java类结构
- 包含构造函数、方法重载等
- 良好的JavaDoc注释

### 测试类 (Test Class)
- 使用JUnit 5框架
- 包含多种测试场景
- 演示测试最佳实践

### .gitignore
- Maven标准忽略文件
- IDE相关文件
- 操作系统生成文件

## 快速开发指南 (Quick Development Guide)

创建项目后，可以立即开始开发：

```bash
# 进入项目目录
cd my-java-app

# 编译项目
mvn clean compile

# 运行应用
mvn exec:java

# 运行测试
mvn test

# 打包项目
mvn clean package

# 运行打包后的应用
java -jar target/my-java-app-1.0.0.jar
```

## 扩展功能 (Extended Features)

### 添加新依赖 (Adding Dependencies)

在 `pom.xml` 中添加依赖：

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <version>3.1.0</version>
</dependency>
```

### 创建新的包和类 (Creating New Packages and Classes)

```bash
# 创建新包目录
mkdir -p src/main/java/com/example/app/service
mkdir -p src/main/java/com/example/app/controller

# 创建对应的测试目录
mkdir -p src/test/java/com/example/app/service
mkdir -p src/test/java/com/example/app/controller
```

## 贡献 (Contributing)

欢迎提交Issue和Pull Request来改进这个脚手架工具！

## 许可证 (License)

MIT License
