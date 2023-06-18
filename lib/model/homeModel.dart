class HomeModel{
  bool ?status;
  HomeData? data;


  HomeModel.formJson(Map<String, dynamic>json){
    status=json['status'];
    data =json['data'] != null ? HomeData.fromJson(json['data']) :null ;
  }
}

class HomeData{
  List<BannerModel> banners=[];
  List<ProductModel> products=[];
  


  HomeData.fromJson(Map<String, dynamic> json) {


    json['banners'].forEach((element){

      banners.add(BannerModel.fromJson(element));

    });

    json['products'].forEach((ele){
      products.add(ProductModel.fromJson(ele));
    });

  }

  // Map<String, dynamic>? toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   if (this.banners != null) {
  //     data['banners'] = this.banners.map((v) => v.toJson()).toList();
  //   }
  // }

}

class BannerModel{
  int? id;
  String? image;

  BannerModel.fromJson(Map<String,dynamic>json){
    id=json['id'] ;
    image=json['image'];

  }


}

class ProductModel{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String ,dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart' ];


  }
}