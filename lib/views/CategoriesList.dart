import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:trajectory_shop/helpers/LoadingStatus.dart';
import 'package:trajectory_shop/models/Category.dart';
import 'package:trajectory_shop/views/OfferSearch.dart';
import 'package:trajectory_shop/views/ProductsList.dart';

class CategoriesList extends StatefulWidget {
  CategoriesList({Key key, this.title, this.parentId}) : super(key: key);
  final String title;
  final int parentId;

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {

  LoadingStatus loading = LoadingStatus.empty;
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future<void> getCategories() async {
    print(1123131);
    setState(() {
      loading = LoadingStatus.loading;
    });
    try{
      Response response = await Dio(new BaseOptions(
        connectTimeout: 10000
      )).get("http://server.getoutfit.ru/categories?limit=1000");
      if(response.statusCode == 200) {
        Iterable list = response.data;
        setState(() {
          categories = list.map((categories) => Category.fromJson(categories)).toList();
          if(categories.length == 0)
            loading = LoadingStatus.empty;
          else
            loading = LoadingStatus.success;
        });
      }else{
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

  // ignore: missing_return
  Widget generate(BuildContext context){
    if(loading == LoadingStatus.success){
      return ListView.separated(
        shrinkWrap: true,
        itemCount: categories.length,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index){
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(categories[index].name),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsList(title: categories[index].name, categoryId: categories[index].id)));
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
          child: Text("Список категорий пуст")
      );
    }
    if(loading == LoadingStatus.error) {
      return Center(
          child: Column(
            children: [
              Text("Произошла ошибка"),
              TextButton(
                onPressed: () async{
                  await getCategories();
                },
                child: Text("Повторить?")),
            ],
          ),
      );
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: OfferSearch());
          })
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await getCategories();
          return;
        },
        child: Center(
          child:
          Padding(
              padding: EdgeInsets.all(8.0),
              child: generate(context)
          ),
        ),
      )
    );
  }
}
