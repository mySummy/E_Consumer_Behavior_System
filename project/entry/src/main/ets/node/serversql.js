const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const { exec } = require('child_process');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;
app.use(bodyParser.json());

// 创建数据库连接
const connection = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '6666',
    database: process.env.DB_DATABASE || 'mysql'
});


connection.connect((err) => {
    if (err) throw err;
    console.log('Connected!');

    const sql = `
    CREATE TABLE IF NOT EXISTS User (
      id INT AUTO_INCREMENT PRIMARY KEY,
      username VARCHAR(255) NOT NULL,
      password VARCHAR(255) NOT NULL
    )
  `;

    connection.query(sql, (err, result) => {
        if (err) throw err;
        console.log('Table created');
    });

    connection.end();
});


// 创建 MySQL 连接池
const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '6666',
    database: process.env.DB_DATABASE || 'mysql',
    authPlugins: {
        mysql_native_password: true
    }
});


// 检查用户名是否存在
app.post('/check-username', (req, res) => {
    const { username } = req.body;
    const query = 'SELECT 1 FROM User WHERE username = ? LIMIT 1';

    pool.execute(query, [username], (error, results) => {
        if (error) {
            console.error('Error executing query:', error);
            return res.status(500).json({ message: 'Internal Server Error' });
        }

        res.status(200).json({ exists: results.length > 0 });
    });
});

// 注册新用户
app.post('/register', (req, res) => {
    const { username, password } = req.body;

    pool.getConnection((error, connection) => {
        if (error) {
            console.error('连接到 MySQL 时出错:', error);
            return res.status(500).json({ message: '内部服务器错误' });
        }

        const query = 'INSERT INTO User (username, password) VALUES (?, ?)';
        connection.query(query, [username, password], (error, results) => {
            connection.release();

            if (error) {
                console.error('执行查询时出错:', error);
                return res.status(500).json({ message: '内部服务器错误' });
            }

            res.status(201).json({ message: '用户注册成功' });
        });
    });
});


// 用户登录
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    pool.getConnection((error, connection) => {
        if (error) {
            console.error('连接到 MySQL 时出错:', error);
            return res.status(500).json({ message: '内部服务器错误' });
        }

        const query = 'SELECT * FROM User WHERE username = ? AND password = ?';
        connection.query(query, [username, password], (error, results) => {
            connection.release();

            if (error) {
                console.error('执行查询时出错:', error);
                return res.status(500).json({ message: '内部服务器错误' });
            }

            if (results.length === 0) {
                return res.status(400).json({ message: '用户名或密码无效' });
            }

            res.status(200).json({ message: '用户登录成功' });
        });
    });
});

// 分析 MySQL 数据库
app.get('/analyze', (req, res) => {
    const { database } = req.query;

    if (!database) {
        return res.status(400).json({ message: '缺少必要的参数: database' });
    }

    const analyzeCommand = `mysqlcheck --analyze ${database}`;

    exec(analyzeCommand, (error, stdout, stderr) => {
        if (error) {
            console.error('执行分析命令时出错:', error);
            return res.status(500).json({ message: '内部服务器错误' });
        }

        console.log('分析命令执行成功');
        res.status(200).json({ message: '分析命令执行成功' });
    });
});

app.listen(port, () => {
    console.log("服务器已经启动，正在监听端口 ${port}");
});