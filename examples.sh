#!/bin/bash

# Java脚手架工具使用示例
# Java Scaffolding Tool Usage Examples

echo "Java脚手架工具使用示例 (Java Scaffolding Tool Usage Examples)"
echo "================================================================"
echo ""

# 示例1：使用默认配置创建项目
echo "示例1：使用默认配置创建项目 (Example 1: Create project with default settings)"
echo "命令 (Command): ./java-scaffold.sh"
echo ""

# 示例2：创建Web应用项目
echo "示例2：创建Web应用项目 (Example 2: Create web application project)"
echo "命令 (Command):"
echo "./java-scaffold.sh \\"
echo "  --artifact-id my-web-app \\"
echo "  --package com.mycompany.webapp \\"
echo "  --main-class WebApplication"
echo ""

# 示例3：创建微服务项目
echo "示例3：创建微服务项目 (Example 3: Create microservice project)"
echo "命令 (Command):"
echo "./java-scaffold.sh \\"
echo "  --group-id com.mycompany \\"
echo "  --artifact-id user-service \\"
echo "  --package com.mycompany.userservice \\"
echo "  --main-class UserServiceApplication"
echo ""

# 示例4：在指定目录创建项目
echo "示例4：在指定目录创建项目 (Example 4: Create project in specific directory)"
echo "命令 (Command):"
echo "./java-scaffold.sh \\"
echo "  --artifact-id hello-world \\"
echo "  --directory ./projects/hello-world"
echo ""

# 示例5：查看帮助信息
echo "示例5：查看帮助信息 (Example 5: Show help information)"
echo "命令 (Command): ./java-scaffold.sh --help"
echo ""

echo "================================================================"
echo "项目创建后的快速开始 (Quick start after project creation):"
echo "1. cd [项目目录] (cd [project-directory])"
echo "2. mvn clean compile"
echo "3. mvn exec:java"
echo "4. mvn test"
echo "================================================================"