const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const app = express();
const port = 3000;

// 中间件
app.use(bodyParser.json());

// 连接到MongoDB
mongoose.connect('mongodb://localhost:27017/mydatabase', {
}).then(() => {
    console.log('Connected to MongoDB');
}).catch(err => {
    console.error('Failed to connect to MongoDB', err);
});

// 定义用户模型
const userSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true }
});

const PaymentHabit = mongoose.model('PaymentHabit', new mongoose.Schema({}, { strict: false }));
const CustomerType = mongoose.model('CustomerType', new mongoose.Schema({}, { strict: false }));
const PredictedUsage = mongoose.model('PredictedUsage', new mongoose.Schema({}, { strict: false }));

const User = mongoose.model('User', userSchema);

// 检查用户名是否存在
app.post('/check-username', async (req, res) => {
    const { username } = req.body;

    try {
        const user = await User.findOne({ username });
        res.status(200).json({ exists: !!user });
    } catch (err) {
        res.status(500).json({ message: 'Internal server error' });
    }
});


// 注册用户
app.post('/register', async (req, res) => {
    const { username, password } = req.body;

    try {
        const userExists = await User.findOne({ username });
        if (userExists) {
            return res.status(400).json({ message: 'User already exists' });
        }

        const newUser = new User({ username, password });
        await newUser.save();
        res.status(201).json({ message: 'User registered successfully' });
    } catch (err) {
        console.error('Error registering user', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// 用户登录
app.post('/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        const user = await User.findOne({ username, password });
        if (!user) {
            return res.status(400).json({ message: 'Invalid username or password' });
        }

        res.status(200).json({ message: 'Login successful' });
    } catch (err) {
        console.error('Error logging in', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// 获取平均缴费次数与平均缴费金额
app.get('/payment-habits', async (req, res) => {
    try {
        const paymentHabits = await PaymentHabit.find();
        res.status(200).json(paymentHabits);
    } catch (err) {
        res.status(500).json({ message: 'Internal server error' });
    }
});

// 获取用户编号与客户类型
app.get('/customer-types', async (req, res) => {
    try {
        const customerTypes = await CustomerType.find();
        res.status(200).json(customerTypes);
    } catch (err) {
        res.status(500).json({ message: 'Internal server error' });
    }
});

// 获取用户编号与预测用电量
app.get('/predicted-usage', async (req, res) => {
    try {
        const predictedUsage = await PredictedUsage.find();
        res.status(200).json(predictedUsage);
    } catch (err) {
        res.status(500).json({ message: 'Internal server error' });
    }
});

// 处理根路径
app.get('/', (req, res) => {
    res.send('Welcome to the homepage!');
});

// 启动服务器
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
