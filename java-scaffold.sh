#!/bin/bash

# Java项目脚手架工具
# Java Project Scaffolding Tool

set -e

# 默认配置
DEFAULT_GROUP_ID="com.example"
DEFAULT_ARTIFACT_ID="my-java-app"
DEFAULT_VERSION="1.0.0"
DEFAULT_PACKAGE="com.example.app"
DEFAULT_MAIN_CLASS="Application"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 显示帮助信息
show_help() {
    echo "Java项目脚手架工具 - Java Project Scaffolding Tool"
    echo ""
    echo "用法: $0 [选项]"
    echo "Usage: $0 [options]"
    echo ""
    echo "选项 (Options):"
    echo "  -h, --help              显示此帮助信息 (Show this help message)"
    echo "  -g, --group-id          Group ID (默认: $DEFAULT_GROUP_ID)"
    echo "  -a, --artifact-id       Artifact ID (默认: $DEFAULT_ARTIFACT_ID)"
    echo "  -v, --version           版本号 (默认: $DEFAULT_VERSION)"
    echo "  -p, --package           包名 (默认: $DEFAULT_PACKAGE)"
    echo "  -m, --main-class        主类名 (默认: $DEFAULT_MAIN_CLASS)"
    echo "  -d, --directory         项目目录 (默认: 使用artifact-id)"
    echo ""
    echo "示例 (Examples):"
    echo "  $0"
    echo "  $0 -a my-project -p com.mycompany.myproject"
    echo "  $0 --artifact-id hello-world --package com.example.hello"
}

# 解析命令行参数
parse_arguments() {
    GROUP_ID="$DEFAULT_GROUP_ID"
    ARTIFACT_ID="$DEFAULT_ARTIFACT_ID"
    VERSION="$DEFAULT_VERSION"
    PACKAGE="$DEFAULT_PACKAGE"
    MAIN_CLASS="$DEFAULT_MAIN_CLASS"
    PROJECT_DIR=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -g|--group-id)
                GROUP_ID="$2"
                shift 2
                ;;
            -a|--artifact-id)
                ARTIFACT_ID="$2"
                shift 2
                ;;
            -v|--version)
                VERSION="$2"
                shift 2
                ;;
            -p|--package)
                PACKAGE="$2"
                shift 2
                ;;
            -m|--main-class)
                MAIN_CLASS="$2"
                shift 2
                ;;
            -d|--directory)
                PROJECT_DIR="$2"
                shift 2
                ;;
            *)
                print_error "未知选项: $1"
                print_error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done

    # 如果没有指定项目目录，使用artifact-id
    if [[ -z "$PROJECT_DIR" ]]; then
        PROJECT_DIR="$ARTIFACT_ID"
    fi
}

# 创建项目目录结构
create_directory_structure() {
    print_info "创建项目目录结构..."
    print_info "Creating project directory structure..."

    # 创建基础目录
    mkdir -p "$PROJECT_DIR"
    mkdir -p "$PROJECT_DIR/src/main/java"
    mkdir -p "$PROJECT_DIR/src/main/resources"
    mkdir -p "$PROJECT_DIR/src/test/java"
    mkdir -p "$PROJECT_DIR/src/test/resources"

    # 创建包目录结构
    PACKAGE_DIR=$(echo "$PACKAGE" | tr '.' '/')
    mkdir -p "$PROJECT_DIR/src/main/java/$PACKAGE_DIR"
    mkdir -p "$PROJECT_DIR/src/test/java/$PACKAGE_DIR"

    print_success "目录结构创建完成 (Directory structure created)"
}

# 创建pom.xml文件
create_pom_xml() {
    print_info "创建Maven配置文件..."
    print_info "Creating Maven configuration file..."

    cat > "$PROJECT_DIR/pom.xml" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>$GROUP_ID</groupId>
    <artifactId>$ARTIFACT_ID</artifactId>
    <version>$VERSION</version>
    <packaging>jar</packaging>

    <name>$ARTIFACT_ID</name>
    <description>A Java application created with java-scaffold</description>

    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <junit.version>5.9.2</junit.version>
    </properties>

    <dependencies>
        <!-- JUnit 5 for testing -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>\${junit.version}</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <!-- Maven Compiler Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
                <configuration>
                    <source>17</source>
                    <target>17</target>
                </configuration>
            </plugin>

            <!-- Maven Surefire Plugin for testing -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.0.0</version>
            </plugin>

            <!-- Maven Exec Plugin for running the application -->
            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>exec-maven-plugin</artifactId>
                <version>3.1.0</version>
                <configuration>
                    <mainClass>$PACKAGE.$MAIN_CLASS</mainClass>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
EOF

    print_success "Maven配置文件创建完成 (Maven configuration file created)"
}

# 创建主类文件
create_main_class() {
    print_info "创建主类文件..."
    print_info "Creating main class file..."

    PACKAGE_DIR=$(echo "$PACKAGE" | tr '.' '/')
    
    cat > "$PROJECT_DIR/src/main/java/$PACKAGE_DIR/$MAIN_CLASS.java" << EOF
package $PACKAGE;

/**
 * 主应用程序类
 * Main application class
 */
public class $MAIN_CLASS {
    
    /**
     * 应用程序入口点
     * Application entry point
     * 
     * @param args 命令行参数 (command line arguments)
     */
    public static void main(String[] args) {
        System.out.println("Hello, World!");
        System.out.println("欢迎使用Java脚手架工具创建的项目！");
        System.out.println("Welcome to the project created by Java Scaffolding Tool!");
        
        if (args.length > 0) {
            System.out.println("命令行参数 (Command line arguments):");
            for (int i = 0; i < args.length; i++) {
                System.out.println("  args[" + i + "] = " + args[i]);
            }
        }
    }
}
EOF

    print_success "主类文件创建完成 (Main class file created)"
}

# 创建示例服务类
create_example_service() {
    print_info "创建示例服务类..."
    print_info "Creating example service class..."

    PACKAGE_DIR=$(echo "$PACKAGE" | tr '.' '/')
    
    cat > "$PROJECT_DIR/src/main/java/$PACKAGE_DIR/GreetingService.java" << EOF
package $PACKAGE;

/**
 * 问候服务类 - 演示基本的Java类结构
 * Greeting service class - demonstrates basic Java class structure
 */
public class GreetingService {
    
    private final String defaultGreeting;
    
    /**
     * 构造函数
     * Constructor
     */
    public GreetingService() {
        this.defaultGreeting = "Hello";
    }
    
    /**
     * 构造函数，自定义默认问候语
     * Constructor with custom default greeting
     * 
     * @param defaultGreeting 默认问候语 (default greeting)
     */
    public GreetingService(String defaultGreeting) {
        this.defaultGreeting = defaultGreeting;
    }
    
    /**
     * 生成问候消息
     * Generate greeting message
     * 
     * @param name 姓名 (name)
     * @return 问候消息 (greeting message)
     */
    public String greet(String name) {
        if (name == null || name.trim().isEmpty()) {
            return defaultGreeting + ", World!";
        }
        return defaultGreeting + ", " + name + "!";
    }
    
    /**
     * 生成正式的问候消息
     * Generate formal greeting message
     * 
     * @param title 称谓 (title)
     * @param name 姓名 (name)
     * @return 正式问候消息 (formal greeting message)
     */
    public String greetFormal(String title, String name) {
        if (title == null) title = "";
        if (name == null) name = "Guest";
        
        String fullName = title.trim().isEmpty() ? name : title + " " + name;
        return defaultGreeting + ", " + fullName + "!";
    }
}
EOF

    print_success "示例服务类创建完成 (Example service class created)"
}

# 创建测试类
create_test_class() {
    print_info "创建测试类..."
    print_info "Creating test class..."

    PACKAGE_DIR=$(echo "$PACKAGE" | tr '.' '/')
    
    cat > "$PROJECT_DIR/src/test/java/$PACKAGE_DIR/GreetingServiceTest.java" << EOF
package $PACKAGE;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.Assertions.*;

/**
 * GreetingService的单元测试
 * Unit tests for GreetingService
 */
class GreetingServiceTest {
    
    private GreetingService greetingService;
    
    @BeforeEach
    void setUp() {
        greetingService = new GreetingService();
    }
    
    @Test
    void testGreetWithName() {
        String result = greetingService.greet("张三");
        assertEquals("Hello, 张三!", result);
    }
    
    @Test
    void testGreetWithEmptyName() {
        String result = greetingService.greet("");
        assertEquals("Hello, World!", result);
    }
    
    @Test
    void testGreetWithNullName() {
        String result = greetingService.greet(null);
        assertEquals("Hello, World!", result);
    }
    
    @Test
    void testCustomGreeting() {
        GreetingService customService = new GreetingService("Hi");
        String result = customService.greet("李四");
        assertEquals("Hi, 李四!", result);
    }
    
    @Test
    void testFormalGreeting() {
        String result = greetingService.greetFormal("Mr.", "Smith");
        assertEquals("Hello, Mr. Smith!", result);
    }
    
    @Test
    void testFormalGreetingWithoutTitle() {
        String result = greetingService.greetFormal("", "王五");
        assertEquals("Hello, 王五!", result);
    }
}
EOF

    print_success "测试类创建完成 (Test class created)"
}

# 创建.gitignore文件
create_gitignore() {
    print_info "创建.gitignore文件..."
    print_info "Creating .gitignore file..."

    cat > "$PROJECT_DIR/.gitignore" << EOF
# Maven
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties
.mvn/timing.properties
.mvn/wrapper/maven-wrapper.jar

# IDE
.idea/
*.iml
.vscode/
.settings/
.project
.classpath

# OS
.DS_Store
Thumbs.db

# Logs
*.log

# Temporary files
*.tmp
*.bak
*.swp
*~.nib
local.properties

# JVM
hs_err_pid*
EOF

    print_success ".gitignore文件创建完成 (.gitignore file created)"
}

# 创建README文件
create_readme() {
    print_info "创建README文件..."
    print_info "Creating README file..."

    cat > "$PROJECT_DIR/README.md" << EOF
# $ARTIFACT_ID

这是一个使用Java脚手架工具创建的项目。
This is a project created using the Java Scaffolding Tool.

## 项目信息 (Project Information)

- **Group ID**: $GROUP_ID
- **Artifact ID**: $ARTIFACT_ID
- **Version**: $VERSION
- **Package**: $PACKAGE
- **Main Class**: $MAIN_CLASS

## 快速开始 (Quick Start)

### 前提条件 (Prerequisites)

- Java 17 或更高版本 (Java 17 or higher)
- Apache Maven 3.6+ 

### 编译项目 (Build the Project)

\`\`\`bash
mvn clean compile
\`\`\`

### 运行应用程序 (Run the Application)

\`\`\`bash
mvn exec:java
\`\`\`

或者 (Or):

\`\`\`bash
mvn clean package
java -jar target/$ARTIFACT_ID-$VERSION.jar
\`\`\`

### 运行测试 (Run Tests)

\`\`\`bash
mvn test
\`\`\`

### 打包项目 (Package the Project)

\`\`\`bash
mvn clean package
\`\`\`

## 项目结构 (Project Structure)

\`\`\`
$ARTIFACT_ID/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── ${PACKAGE//./\/}/
│   │   │       ├── $MAIN_CLASS.java
│   │   │       └── GreetingService.java
│   │   └── resources/
│   └── test/
│       ├── java/
│       │   └── ${PACKAGE//./\/}/
│       │       └── GreetingServiceTest.java
│       └── resources/
├── pom.xml
├── .gitignore
└── README.md
\`\`\`

## 开发指南 (Development Guide)

### 添加新的依赖 (Adding New Dependencies)

在 \`pom.xml\` 文件的 \`<dependencies>\` 部分添加新的依赖项。
Add new dependencies in the \`<dependencies>\` section of the \`pom.xml\` file.

### 运行特定测试 (Running Specific Tests)

\`\`\`bash
mvn test -Dtest=GreetingServiceTest
\`\`\`

### 生成项目报告 (Generate Project Reports)

\`\`\`bash
mvn site
\`\`\`

## 贡献 (Contributing)

1. Fork 此项目 (Fork the project)
2. 创建特性分支 (Create your feature branch): \`git checkout -b feature/amazing-feature\`
3. 提交更改 (Commit your changes): \`git commit -m 'Add some amazing feature'\`
4. 推送分支 (Push to the branch): \`git push origin feature/amazing-feature\`
5. 打开拉取请求 (Open a Pull Request)

## 许可证 (License)

此项目使用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
EOF

    print_success "README文件创建完成 (README file created)"
}

# 主函数
main() {
    echo "=================================================="
    echo "Java项目脚手架工具 - Java Project Scaffolding Tool"
    echo "=================================================="
    echo ""

    # 解析命令行参数
    parse_arguments "$@"

    # 显示配置信息
    print_info "项目配置 (Project Configuration):"
    echo "  Group ID: $GROUP_ID"
    echo "  Artifact ID: $ARTIFACT_ID"
    echo "  Version: $VERSION"
    echo "  Package: $PACKAGE"
    echo "  Main Class: $MAIN_CLASS"
    echo "  Project Directory: $PROJECT_DIR"
    echo ""

    # 检查目录是否已存在
    if [[ -d "$PROJECT_DIR" ]]; then
        print_warning "目录 '$PROJECT_DIR' 已存在！"
        print_warning "Directory '$PROJECT_DIR' already exists!"
        read -p "是否继续？这将覆盖现有文件。(Continue? This will overwrite existing files.) [y/N]: " -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "操作已取消 (Operation cancelled)"
            exit 0
        fi
    fi

    # 创建项目
    print_info "开始创建Java项目..."
    print_info "Starting to create Java project..."
    echo ""

    create_directory_structure
    create_pom_xml
    create_main_class
    create_example_service
    create_test_class
    create_gitignore
    create_readme

    echo ""
    print_success "=================================================="
    print_success "Java项目创建完成！(Java project created successfully!)"
    print_success "=================================================="
    echo ""
    print_info "下一步 (Next steps):"
    echo "  1. cd $PROJECT_DIR"
    echo "  2. mvn clean compile"
    echo "  3. mvn exec:java"
    echo "  4. mvn test"
    echo ""
    print_info "享受编程！(Happy coding!)"
}

# 运行主函数
main "$@"