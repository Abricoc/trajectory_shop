class Offer {
  int categoryId;
  String description;
  String vendorCode;
  int modifiedTime;
  String vendor;
  bool deleted;
  String salesNotes;
  List<Params> params;
  String name;
  String currencyId;
  bool available;
  String url;
  List<String> pictures;
  int price;
  String id;

  Offer(
      {this.categoryId,
        this.description,
        this.vendorCode,
        this.modifiedTime,
        this.vendor,
        this.deleted,
        this.salesNotes,
        this.params,
        this.name,
        this.currencyId,
        this.available,
        this.url,
        this.pictures,
        this.price,
        this.id});

  Offer.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    description = json['description'];
    vendorCode = json['vendorCode'];
    modifiedTime = json['modified_time'];
    vendor = json['vendor'];
    deleted = json['deleted'];
    salesNotes = json['sales_notes'];
    if (json['params'] != null) {
      params = new List<Params>();
      json['params'].forEach((v) {
        params.add(new Params.fromJson(v));
      });
    }
    name = json['name'];
    currencyId = json['currencyId'];
    available = json['available'];
    url = json['url'];
    pictures = json['pictures'].cast<String>();
    price = json['price'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['description'] = this.description;
    data['vendorCode'] = this.vendorCode;
    data['modified_time'] = this.modifiedTime;
    data['vendor'] = this.vendor;
    data['deleted'] = this.deleted;
    data['sales_notes'] = this.salesNotes;
    if (this.params != null) {
      data['params'] = this.params.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['currencyId'] = this.currencyId;
    data['available'] = this.available;
    data['url'] = this.url;
    data['pictures'] = this.pictures;
    data['price'] = this.price;
    data['id'] = this.id;
    return data;
  }
}

class Params {
  String name;
  String unit;
  String value;

  Params({this.name, this.unit, this.value});

  Params.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    unit = json['unit'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['value'] = this.value;
    return data;
  }
}