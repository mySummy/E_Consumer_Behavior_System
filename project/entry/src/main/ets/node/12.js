const xlsx = require('xlsx');
const createCsvWriter = require('csv-writer').createObjectCsvWriter;
const path = require('path');

// 确认当前工作目录
console.log('Current working directory:', process.cwd());

// 读取Excel文件
const filePath = path.resolve('E:/E_Consumer_Behavior_System/E_Consumer_Behavior_System/project/A5-master/任务123/cph.xlsx');
console.log('Reading file from:', filePath); // 打印文件路径以确认正确性
const workbook = xlsx.readFile(filePath);
const sheet_name_list = workbook.SheetNames;
const df = xlsx.utils.sheet_to_json(workbook.Sheets[sheet_name_list[0]], { header: ['用户编号', '缴费日期', '缴费金额'] }).slice(1);

// 检查是否有缺失值
const hasNull = df.some(row => Object.values(row).includes(null));
console.log('有缺失值:', hasNull);

// 根据‘用户编号’进行分组
const df1 = df.reduce((acc, row) => {
    if (!acc[row.用户编号]) {
        acc[row.用户编号] = [];
    }
    acc[row.用户编号].push(row);
    return acc;
}, {});

// 用户总人数
const len1 = Object.keys(df1).length;

// 用户总缴费金额
const sum1 = df.reduce((acc, row) => acc + row.缴费金额, 0);

// 平均缴费金额
const avg_money = sum1 / len1;

// 平均缴费次数
const avg_count = Object.values(df1).reduce((acc, group) => acc + group.length, 0) / len1;

// 写入居民客户的用电缴费习惯分析1.csv
const csvWriter1 = createCsvWriter({
    path: 'E:/E_Consumer_Behavior_System/E_Consumer_Behavior_System/project/A5-master/任务123/居民客户的用电缴费习惯分析1.csv', // 指定完整的文件路径
    header: [
        { id: '平均缴费次数', title: '平均缴费次数' },
        { id: '平均缴费金额', title: '平均缴费金额' }
    ],
});

    encoding: 'utf-8' // 使用 UTF-8 编码
csvWriter1.writeRecords([{ '平均缴费次数': avg_count, '平均缴费金额': avg_money }])
    .then(() => console.log('居民客户的用电缴费习惯分析1.csv 写入完成'));

// 居民客户的缴费次数和缴费金额
const df2 = Object.keys(df1).map(userId => {
    const group = df1[userId];
    return {
        '用户编号': userId,
        '缴费日期': group.length,
        '缴费金额': group.reduce((acc, row) => acc + row.缴费金额, 0)
    };
});

// 写入居民客户的用电缴费习惯分析2.csv
const csvWriter2 = createCsvWriter({
    path: 'E:/E_Consumer_Behavior_System/E_Consumer_Behavior_System/project/A5-master/任务123/居民客户的用电缴费习惯分析2.csv', // 指定完整的文件路径
    header: [
        { id: '用户编号', title: '用户编号' },
        { id: '客户类型', title: '客户类型' }
    ],
});

const records = df2.map(row => {
    let customerType = '';
    if (row['缴费日期'] > avg_count && row['缴费金额'] > avg_money) {
        customerType = '高价值型客户';
    } else if (row['缴费日期'] > avg_count && row['缴费金额'] < avg_money) {
        customerType = '大众型客户';
    } else if (row['缴费日期'] < avg_count && row['缴费金额'] > avg_money) {
        customerType = '潜力型客户';
    } else {
        customerType = '低价值型客户';
    }
    return {
        '用户编号': row['用户编号'],
        '客户类型': customerType
    };
});

csvWriter2.writeRecords(records)
    .then(() => console.log('居民客户的用电缴费习惯分析2.csv 写入完成'));
