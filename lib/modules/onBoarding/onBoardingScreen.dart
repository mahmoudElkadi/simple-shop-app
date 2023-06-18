import 'package:flutter/material.dart';
import 'package:shop_app/Network/local/shared_helper.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/styles/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/login.dart';

class BoardingModel
{
final String image;
final String title;
final String body;

BoardingModel({
 required this.image,
 required this.title,
 required this.body,
});

}
bool isLast=false;



class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController= PageController();

  List<BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/image/onBoardaingShop.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 body'),
    BoardingModel(
        image: 'assets/image/shop2.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 body'),
    BoardingModel(
        image: 'assets/image/shop3.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 body'),

  ];

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then(
            (value){
          if(value==true){
            navigateAndFinish(context, LoginScreen());
          }
        });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text('Skip'))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                  onPageChanged: (int index){
                    if(index==boarding.length -1){
                      setState(() {
                        isLast=true;
                      });
                    }else{
                      isLast=false;
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
            ),

            
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    activeDotColor: defaultColor,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5
                  )
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){

                    if(isLast==false){
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastOutSlowIn);
                    }else{
                      submit();
                    }

                  },
                  child: Icon(Icons.arrow_circle_right_outlined),)
              ],
            )
        ],),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image: AssetImage("${model.image}"),
        ),
      ),

      Text(
        "${model.title}",
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      SizedBox(height: 15,),
      Text(
        "${model.body}",
        style: TextStyle(
          fontSize: 14,

        ),
      ),
    ],
  );
}
