import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import '../../../shared/style/colors.dart';
import '../../shared/comonents/components.dart';
import '../../shared/network/local/cachHelper.dart';
import '../login/shop_loginScreen.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class onBoardingScreen extends StatefulWidget {

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onBoarding.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'),
    BoardingModel(
        image: 'assets/images/onBoarding.png',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'),
    BoardingModel(
        image: 'assets/images/onBoarding.png',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body')
  ];

  var boardController = PageController();

  bool isLastPage =false;

  void goToLogin (){
    CachHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value == true){
        navegateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: (){
                goToLogin();
              },
              buttonlable: "SKIP",
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                  onPageChanged: (int index){
                  if (index == boarding.length-1){
                    setState(() {
                      isLastPage =true;
                    });
                  }else{
                    setState(() {
                      isLastPage =false;
                    });
                  }
                  },
                  itemBuilder: (context , index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
               SmoothPageIndicator(
                   controller: boardController,
                   effect: ExpandingDotsEffect(
                     dotColor:Colors.grey ,
                     activeDotColor: defultColor,
                     dotHeight: 10,
                     dotWidth: 10,
                     expansionFactor: 4,
                     spacing: 5.0,
                   ),
                   count: boarding.length),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLastPage){
                        goToLogin();
                      }else{
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750,),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                  child: Icon(Icons.arrow_forward_ios),
                )

              ],
            )

          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
                image: AssetImage('${model.image}')
            ),
          ),
          Text(
            "${model.title}",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15,),
          Text(
            "${model.body}",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15,),
        ],
      );
}
