import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:trajectory_shop/helpers/LoadingStatus.dart';
import 'package:trajectory_shop/models/Offer.dart';
import 'package:trajectory_shop/views/ProductDetails.dart';

class ProductsList extends StatefulWidget {
  ProductsList({Key key, this.title, this.categoryId}) : super(key: key);
  final String title;
  final int categoryId;

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {

  LoadingStatus loading = LoadingStatus.empty;
  List<Offer> offers = [];

  @override
  void initState() {
    super.initState();
    getOffers();
  }

  Future<void> getOffers() async {
    setState(() {
      loading = LoadingStatus.loading;
    });
    try
    {
      Response<String> response = await Dio(new BaseOptions(
          receiveTimeout: 10000
      )).get("http://server.getoutfit.ru/offers?categoryId=${widget.categoryId}");
      if(response.statusCode == 200){
        List<dynamic> list = await json.decode(response.data.toString());
        offers = list.map((offers) => Offer.fromJson(offers)).toList();
        setState(() {
          if(offers.length == 0)
            loading = LoadingStatus.empty;
          else
            loading = LoadingStatus.success;
        });
      }
      else{
        setState(() {
          loading = LoadingStatus.error;
        });
      }
    }catch(Exception){
      setState(() {
        loading = LoadingStatus.error;
      });
    }
  }

  Widget generate(){
    if(loading == LoadingStatus.success){
      return ListView.separated(
        shrinkWrap: true,
        itemCount: offers.length,
        separatorBuilder: (BuildContext context, int index){
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(offers[index].name),
            leading: Image.network(offers[index].pictures[0]),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsDetail(offer: offers[index])));
            },
          );
        },
      );
    }
    if(loading == LoadingStatus.loading) {
      return Center(
          child: CircularProgressIndicator()
      );
    }
    if(loading == LoadingStatus.empty) {
      return Center(
          child: Text("Товаров в данной категории нет")
      );
    }
    if(loading == LoadingStatus.error) {
      return Center(
          child: Text("Произошла ошибка")
      );
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white),),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await getOffers();
          return;
        },
        child: Center(
          child:
          Padding(
              padding: EdgeInsets.all(8.0),
              child: generate()
          ),
        ),
      )
    );
  }
}
