const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// 中间件
app.use(bodyParser.json());

// 模拟数据库
let users = [
    { username: '123', password: '123' }
];
// 注册用户
app.post('/register', (req, res) => {
    const { username, password } = req.body;
    const userExists = users.find(user => user.username === username);

    if (userExists) {
        return res.status(400).json({ message: 'User already exists' });
    }

    users.push({ username, password });
    res.status(201).json({ message: 'User registered successfully' });
});

// 用户登录
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    const user = users.find(user => user.username === username && user.password === password);

    if (!user) {
        return res.status(400).json({ message: 'Invalid username or password' });
    }

    res.status(200).json({ message: 'Login successful' });
});

// 启动服务器
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
