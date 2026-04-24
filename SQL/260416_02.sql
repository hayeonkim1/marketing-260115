CREATE DATABASE crawler_lab_v1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER "mcp_user_hy"@"localhost" IDENTIFIED BY "1234567a";
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX
ON crawler_lab_v1.* TO "mcp_user_hy"@"localhost";

DROP USER 'mcp_user_hy'@'localhost';
CREATE USER 'mcp_user_hy'@'localhost' IDENTIFIED BY '1234567a';