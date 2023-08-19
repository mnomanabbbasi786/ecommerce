
class CategoryModel{
  String id;
  String name;
  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
        id: json['id'],
        name: json['category_name']
    );
  }


  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'name':name
    };
  }
}