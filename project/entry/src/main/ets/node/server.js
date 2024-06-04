const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const xlsx = require('xlsx-populate');
const { MongoClient } = require('mongodb');
const app = express();
const port = 3000;

const csvFilePath = 'E:/E_Consumer_Behavior_System/E_Consumer_Behavior_System/project/A5-master/任务123/居民客户的用电缴费习惯分析1.csv';
const csv = require('csv-parser');
const fs = require('fs');

// mongo运行：
//"C:\Program Files\MongoDB\Server\7.0\bin\mongod.exe" --dbpath="C:\data\db"
// 中间件

//const app = express();
// 连接到MongoDB
//mongoose.connect('mongodb://10.0.2.15:27017/mydatabase', {
//}).then(() => {
  //  console.log('Connected to MongoDB');
//}).catch(err => {
  //  console.error('Failed to connect to MongoDB', err);
//});


app.use(bodyParser.json());

// 连接到MongoDB
mongoose.connect('mongodb://localhost:27017/mydatabase', {
}).then(() => {
    console.log('Connected to MongoDB');
}).catch(err => {
    console.error('Failed to connect to MongoDB', err);
});

// 创建  模型
const XLSXDataSchema = new mongoose.Schema({
    // 定义字段和类型
    snumber: String,//用户编号
    sdata: Number,//缴费日期
    amount: Boolean,//缴费金额
});

// 将模型与集合关联
const XLSXData = mongoose.model('XLSXData', XLSXDataSchema);


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
        let paymentCount = 0;
        let paymentAmount = 0;

        fs.createReadStream(csvFilePath)
            .pipe(csv())
            .on('data', (row) => {
                // 假设CSV文件中的列名为"缴费次数"和"缴费金额"
                paymentCount = parseInt(row['平均缴费次数']);
                paymentAmount = parseFloat(row['平均缴费金额']);
            })
            .on('end', () => {
                res.status(200).json({
                    paymentCount: paymentCount,
                    paymentAmount: paymentAmount
                });
            });
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

// 调用Python脚本的API端点
app.get('/analyze', (req, res) => {
    exec('python 任务3.py', (error, stdout, stderr) => {
        if (error) {
            console.error(`exec error: ${error}`);
            return res.status(500).json({ message: 'Error executing Python script', error: stderr });
        }

        // 将Python脚本的输出结果解析为JSON对象并返回给客户端
        const result = JSON.parse(stdout); // 假设stdout是一个JSON字符串
        res.status(200).json({ message: 'Analysis complete', result: result });
    });
});

const { exec } = require('child_process');
// 处理分析请求
app.get('/analyze', async (req, res) => {
    try {
        // 调用 Python 脚本并处理输出
        exec('python 任务3.py', (error, stdout, stderr) => {
            if (error) {
                console.error(`exec error: ${error}`);
                res.status(500).json({ message: 'Internal server error' });
                return;
            }
            // 将 Python 脚本的输出发送回客户端
            const output = JSON.parse(stdout);
            res.status(200).json(output);
        });
    } catch (err) {
        res.status(500).json({ message: 'Internal server error' });
    }
});


// 存储 XLSX 文件
app.post('/save-xlsx', async (req, res) => {
    const filePath = 'E:/E_Consumer_Behavior_System/E_Consumer_Behavior_System/project/A5-master/任务123/居民客户的用电缴费习惯分析1.csv'; // CSV文件路径

    const data = []; // 用于存储解析后的数据

    try {
        fs.createReadStream(filePath)
            .pipe(csv())
            .on('data', (row) => {
                data.push(row);
            })
            .on('end', async () => {
                try {
                    const result = []; // 存储转换后的结构体变量数据

                    // 遍历数据并转换为结构体变量格式
                    data.forEach((item) => {
                        const record = {
                            userNumber: item.snumber,
                            paymentDate: item.sdata,
                            paymentAmount: item.amount
                        };
                        result.push(record);
                    });

                    // 存储数据到数据库
                    await XLSXData.create(result);

                    res.status(200).json({ message: 'Data saved to database successfully' });
                } catch (err) {
                    console.error('Error saving data to database:', err);
                    res.status(500).json({ message: 'Failed to save data to database' });
                }
            });
    } catch (err) {
        console.error('Error parsing CSV file:', err);
        res.status(500).json({ message: 'Failed to parse CSV file' });
    }
});

// 从 MongoDB 读取数据并生成 XLSX 文件
app.get('/read-xlsx', async (req, res) => {
    try {
        // 连接到 MongoDB
        const client = await MongoClient.connect('mongodb://localhost:27017', {
            useUnifiedTopology: true,
        });

        const db = client.db('XLSXData'); // 数据库名称为 XLSXData
        const collection = db.collection('your_collection'); // 替换为您的集合名称

        const data = [];

        // 从集合中读取数据
        const cursor = collection.find();

        await cursor.forEach((document) => {
            const { snumber, sdata, amount } = document;
            data.push({ snumber, sdata, amount });
        });

        client.close();

        res.status(200).json(data);
    } catch (err) {
        console.error('Error reading data from MongoDB:', err);
        res.status(500).json({ message: 'Failed to read data from MongoDB' });
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
