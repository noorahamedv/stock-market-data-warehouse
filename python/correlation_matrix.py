import seaborn as sns
import matplotlib.pyplot as plt

corr = df[['STOCK_CLOSE', 'STOCK_OPEN', 'STOCK_HIGH', 'STOCK_LOW', 'STOCK_VOLUME']].corr()

plt.figure(figsize=(10, 6))
sns.heatmap(corr, annot=True, cmap='coolwarm', fmt='.2f')
plt.title('Correlation Matrix of Stock Variables')
plt.show()
