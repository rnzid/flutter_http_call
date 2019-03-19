import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


void main()=>runApp(Project1());
class Project1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Http request",
      home: HomePage(),
    );
  }
}
class Coin{
  String id;
  String name;
  String symbol;
  String priceUSD;

  Coin.fromMap(Map data):
  id=data['id'],
  name=data['name'],
  symbol=data['symbol'],
  priceUSD=data['price_usd'];
  
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
Future<List>getCurrencies()async{
  http.Response res =await http.Client().get('https://api.coinlore.com/api/tickers/');
  return json.decode(res.body)['data'];
}
class _HomePageState extends State<HomePage> {
  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("crypto currency"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getCurrencies(),
          builder: (BuildContext context,AsyncSnapshot snapshot ){
            if(!snapshot.hasData)return Center(child: CircularProgressIndicator(),);
            if(snapshot.hasError)return Center(child: Text('has error'),);
            List data=snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index){
                Coin coin=Coin.fromMap(data[index]);
                return ListTile(
                  title: Text(coin.name),
                  subtitle: Text(coin.symbol),
                  trailing: Text("\$${coin.priceUSD}"),

                );
              },
            );
          },
        ),
      ),
    );
  }
}
