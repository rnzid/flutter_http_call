class Coin {
  String id;
  String name;
  String symbol;
  String priceUSD;

  Coin.fromMap(Map data):
  id=data['id'],
  name=data['name'],
  symbol=data['symbol'],
  priceUSD=data['Price_usd'];
  
}