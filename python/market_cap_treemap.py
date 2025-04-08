import plotly.express as px

df['MARKET_CAP'] = df['STOCK_CLOSE'] * df['STOCK_VOLUME']
market_cap = df.groupby('COMPANY_NAME')['MARKET_CAP'].sum().reset_index()

fig = px.treemap(market_cap, path=['COMPANY_NAME'], values='MARKET_CAP', title='Market Capitalization by Company')
fig.show()
