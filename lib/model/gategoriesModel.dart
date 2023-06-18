class GategoryModel{
  bool? status;
  GategoryDataModel? data;

  GategoryModel.formJson(Map<String,dynamic> json){
    status=json['status'];
    data=GategoryDataModel.formJson(json['data']) ;
  }
}

class GategoryDataModel{
  int? currentPage;
  List<GategoryData> data=[];

  GategoryDataModel.formJson(Map<String,dynamic> json ){
    currentPage=json['current_page'];

    json['data'].forEach((ele)=>
    data.add(GategoryData.formJson(ele))
    );
  }
}

class GategoryData{
  int? id;
  String? name;
  String? image;

  GategoryData.formJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}