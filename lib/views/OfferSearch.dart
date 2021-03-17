import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trajectory_shop/models/Category.dart';
import 'package:trajectory_shop/models/Offer.dart';
import 'package:trajectory_shop/views/ProductDetails.dart';

class OfferSearch extends SearchDelegate<Offer>{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Offer>>(
      future: getOffers(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.data.length == 0){
            return Center(
              child: Text("Поиск не дал результатов"),
            );
          }else {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].name),
                  leading: Image.network(snapshot.data[index].pictures[0]),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsDetail(offer: snapshot.data[index])));
                  },
                );
              },
            );
          }
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<List<Offer>> getOffers() async {
    if(query == "") return [];
    try
    {
      Response<String> response = await Dio(new BaseOptions(
          receiveTimeout: 10000
      )).get("http://server.getoutfit.ru/offers?name=$query");
      if(response.statusCode == 200){
        List<dynamic> list = json.decode(response.data.toString());
        return list.map((offers) => Offer.fromJson(offers)).toList();
      }
      else{
        return null;
      }
    }catch(Exception){
      return null;
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
  
}