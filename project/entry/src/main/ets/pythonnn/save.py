import pandas as pd
from pymongo import MongoClient

# 连接到 MongoDB
client = MongoClient('mongodb://localhost:27017/')
db = client['mydatabase']

# 读取 CSV 文件
df1 = pd.read_csv('居民客户的用电缴费习惯分析1.csv')
df2 = pd.read_csv('居民客户的用电缴费习惯分析2.csv')
df3 = pd.read_csv('居民客户的用电缴费习惯分析3.csv')

# 将数据插入到 MongoDB
db['payment_habits'].insert_many(df1.to_dict('records'))
db['customer_types'].insert_many(df2.to_dict('records'))
db['predicted_usage'].insert_many(df3.to_dict('records'))
