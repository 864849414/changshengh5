import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassExpertListEntity.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/pc_pages/home/pc_expert_item.dart';
import 'package:changshengh5/pc_pages/home/pc_ranking_list.dart';
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

class _PCHomePageState extends State<PCHomePage> with TickerProviderStateMixin<PCHomePage>{
  List<SPClassGuessMatchInfo> ?spProHotMatch =[];//热门赛事
  String spProHomeMatchType = "足球";
  String spProMatchType = "is_zq_expert";
  List<SPClassExpertListExpertList> spProExpertList =[];
  List spProTabSchemeTitles = ["高胜率","最新",  "免费"];
  List spProTabSchemeKeys = ["recent_correct_rate","newest",  "free"];
  TabController ?spProTabSchemeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProTabSchemeController = TabController(
        length: spProTabSchemeTitles.length,
        vsync: this,
        initialIndex: 0);
    spFunGetHotMatch();
    spFunGetExpert();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Image.asset(
            SPClassImageUtil.spFunGetImagePath('pc_home_bg'),
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            children: [
              matchWidget(),
              expertWidget(),
              schemeWidget(),
            ],
          )

        ],
      ),
    );
  }

//  足球赛事
  Widget matchWidget(){
    return Container(
      margin: EdgeInsets.only(left: 456.w,right: 456.w,top: 6.w),
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

//  足球专家
  Widget expertWidget(){
    return
      Container(
        margin: EdgeInsets.symmetric(horizontal: 466.w),
        height: 541.w,
        child: Row(
          children: [
            Expanded(child: Container(
              padding: EdgeInsets.only(left: 16.w,top: 26.w,right: 16.w,),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        SPClassImageUtil.spFunGetImagePath('people'),
                        width: 16.w,
                      ),
                      SizedBox(width: 8.sp,),
                      Text('足球专家',style: TextStyle(fontSize: 20.sp,color: MyColors.grey_33),),

                    ],
                  ),
                  SizedBox(height: 24.w,),
                  GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 24,
                          childAspectRatio: 304/204
                      ),
                      shrinkWrap: true,
                      itemCount: spProExpertList.length,
                      itemBuilder: (context, index){
                        return PCExpertItem(data: spProExpertList[index],);
                      }
                  )
                ],
              ),
            )),
            Container(
              margin: EdgeInsets.only(left: 16.w),
              width: 320.w,
              height: 541.w,
              child: PCRankingList(isHomePage: true,),
            )
          ],
        ),
      );
  }

  Widget schemeWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 466.w,vertical: 36.w),
      color: Color(0xFFE1EAF7),
      child: Column(
        children: [
          Container(
            height: 48.w,
            color: Colors.white,
            child: Row(
              children: [
                // TabBar(
                //   controller:spProTabSchemeController,
                //   tabs: spProTabSchemeTitles.map((tab) {
                //     return Tab(
                //       text: tab,
                //     );
                //   }).toList(),
                // ),
                Expanded(child: SizedBox()),
                Image.asset(
                  SPClassImageUtil.spFunGetImagePath('pc_shaixuan'),
                  width: 32.w,
                ),
                SizedBox(width: 8.w,),
                Text('筛选',style: TextStyle(fontSize: 18.sp,color: MyColors.grey_66),),
                SizedBox(width: 24.w,),
              ],
            ),
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

  spFunGetExpert(){
    Map<String,dynamic> params = {
      'fetch_type':'hot',
      spProMatchType:1
    };
    SPClassApiManager.spFunGetInstance().spFunExpertList(queryParameters:params,spProCallBack: SPClassHttpCallBack<SPClassExpertListEntity>(
        spProOnSuccess: (list){
          if(list.spProExpertList!=null&&list.spProExpertList!.length>0){
            if(mounted){
              setState(() {
                spProExpertList=list.spProExpertList!.take(4).toList();
              });
            }
          }
        },onError: (v){},spProOnProgress: (v){}
    ));
  }




}
