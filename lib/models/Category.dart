class Category {
  int parentId;
  int id;
  String name;

  Category({this.parentId, this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    parentId = json['parentId'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parentId'] = this.parentId;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}