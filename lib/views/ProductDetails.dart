import 'package:flutter/material.dart';
import 'package:trajectory_shop/models/Offer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';


class ProductsDetail extends StatefulWidget {
  ProductsDetail({Key key, this.offer}) : super(key: key);
  final Offer offer;

  @override
  _ProductsDetailState createState() => _ProductsDetailState();
}

class _ProductsDetailState extends State<ProductsDetail> {

  @override
  void initState() {
    super.initState();
    getOffer();
  }

  Future<void> getOffer() async{
    print(widget.offer);
  }

  void LauchURL(String url){
      launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.offer.name, style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(children: [
            CarouselSlider(
              options: CarouselOptions(height: 250.0),
              items: widget.offer.pictures.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.network(i)
                    );
                  },
                );
              }).toList(),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(widget.offer.name, style: TextStyle(fontSize: 16.0), textAlign: TextAlign.center,),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0, bottom: 15.0),
              child: Text("Цена: ${widget.offer.price} ${widget.offer.currencyId}", style: TextStyle(fontSize: 16.0), textAlign: TextAlign.center,),
            ),
            Text(widget.offer.description, textAlign: TextAlign.justify,),
          ],
          )
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: ElevatedButton(
          onPressed: () {
            LauchURL(widget.offer.url);
          },
          child: SizedBox(
            width: double.infinity,
            child: Text("Купить в магазине", style: TextStyle(fontSize: 16.0), textAlign: TextAlign.center,)
          ),
        ),
      )
    );
  }

}