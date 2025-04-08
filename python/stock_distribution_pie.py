import matplotlib.pyplot as plt

company_avg = df.groupby('COMPANY_NAME')['STOCK_CLOSE'].mean()

plt.figure(figsize=(8, 8))
plt.pie(company_avg, labels=company_avg.index, autopct='%1.1f%%', startangle=140)
plt.title('Distribution of Stock Prices by Company')
plt.show()
