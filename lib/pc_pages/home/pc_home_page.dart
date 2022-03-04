import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/pc_match_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PCHomePage extends StatefulWidget {
  const PCHomePage({Key? key}) : super(key: key);

  @override
  _PCHomePageState createState() => _PCHomePageState();
}

class _PCHomePageState extends State<PCHomePage> {
  List<SPClassGuessMatchInfo> ?spProHotMatch =[];//热门赛事
  String spProHomeMatchType = "足球";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spFunGetHotMatch();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          SPClassImageUtil.spFunGetImagePath('pc_home_bg'),
          width: MediaQuery.of(context).size.width,
        ),
        Column(
          children: [
            MatchWidget(),
            ExpertWidget(),
          ],
        )

      ],
    );
  }

//  足球赛事
  Widget MatchWidget(){
    return Container(
      margin: EdgeInsets.only(left: 464.w,right: 464.w,top: 6.w),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                SPClassImageUtil.spFunGetImagePath('pc_match_bg'),
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                left: 9.w,
                top: 6.w,
                child: Container(
                  width: 124.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(24))
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        SPClassImageUtil.spFunGetImagePath('zuqiu'),
                        width: 16.w,
                      ),
                      SizedBox(width: 4.w,),
                      Text('足球赛事',style: TextStyle(fontSize: 18.sp,color: MyColors.grey_66),)
                    ],
                  ) ,),
              ),
              Positioned(
                  left: 25.w,
                  right: 25.w,
                  bottom: 25.w,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: spProHotMatch!.map((e) {
                        return PCMatchItemWidget(data: e,);
                      }).toList(),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget ExpertWidget(){
    return Container(
      color: Colors.white,
     child: Column(
       children: [
         Row(
           children: [
             Image.asset(
               SPClassImageUtil.spFunGetImagePath('people'),
               width: 16.w,
             ),
             Text('足球专家',style: TextStyle(fontSize: 20.sp,color: MyColors.grey_33),)
           ],
         )
       ],
     ),
    );
  }



  spFunGetHotMatch() {
    SPClassApiManager.spFunGetInstance().spFunGuessMatchList<SPClassGuessMatchInfo>(queryParams: {"page": 1,"date":"","spProFetchType": "hot",'match_type':spProHomeMatchType},spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){
          if(mounted){
            setState(() {
              spProHotMatch=list.spProDataList.length>4?list.spProDataList.sublist(0,4):list.spProDataList;
            });
          }
        },onError: (v){},spProOnProgress: (v){}
    ));
  }


}
