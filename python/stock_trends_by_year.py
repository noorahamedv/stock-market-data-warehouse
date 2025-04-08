import pandas as pd
import matplotlib.pyplot as plt

df['Year'] = pd.to_datetime(df['TRADE_DATE']).dt.year
yearly_trend = df.groupby('Year')['STOCK_CLOSE'].mean().reset_index()

plt.figure(figsize=(10, 6))
plt.plot(yearly_trend['Year'], yearly_trend['STOCK_CLOSE'], marker='o', color='blue')
plt.title('Average Stock Close Prices by Year')
plt.xlabel('Year')
plt.ylabel('Average Close Price')
plt.grid(True)
plt.show()
