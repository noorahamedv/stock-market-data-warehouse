import seaborn as sns
import matplotlib.pyplot as plt

df['Day'] = pd.to_datetime(df['TRADE_DATE']).dt.day

plt.figure(figsize=(12, 6))
sns.lineplot(data=df, x='Day', y='STOCK_VOLUME', label='Volume', color='orange')
sns.lineplot(data=df, x='Day', y='STOCK_ADJ_CLOSE', label='Adj Close', color='blue')
sns.lineplot(data=df, x='Day', y='STOCK_HIGH', label='High', color='green')
plt.title('Stock Performance by Day in Month')
plt.xlabel('Day of Month')
plt.ylabel('Value')
plt.legend()
plt.show()
