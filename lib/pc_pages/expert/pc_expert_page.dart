import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassExpertListEntity.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/pc_pages/home/pc_expert_item.dart';
import 'package:changshengh5/pc_pages/home/pc_ranking_list.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

  class PCExpertPage extends StatefulWidget {
  final String ?spProHomeMatchType;
  PCExpertPage({Key? key,this.spProHomeMatchType}) : super(key: key);

  @override
  _PCExpertPageState createState() => _PCExpertPageState();
}

class _PCExpertPageState extends State<PCExpertPage> {
  EasyRefreshController ?controller;
  List<SPClassExpertListExpertList> spProExpertList =[];
  ScrollController ?spProListScrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spFunOnReFresh();
    controller=EasyRefreshController();
    spProListScrollController=ScrollController();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: expertWidget(),
    );
  }

  Widget expertWidget(){
    return Container(
        padding: EdgeInsets.only(left: 466.w,right: 466.w,top: 24.w),
        color: Color(0xFFE1EAF7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container(
              padding: EdgeInsets.only(left: 16.w,top: 26.w,right: 16.w,bottom: 26.w),
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
                      Text('${widget.spProHomeMatchType}专家推荐',style: TextStyle(fontSize: 20.sp,color: MyColors.grey_33),),

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
              child: PCRankingList(isHomePage: false,matchType: widget.spProHomeMatchType,),
            )
          ],
        ),
      );
  }

  Future<void> spFunOnReFresh() async{
    Map<String,dynamic> params = {
      'fetch_type':'hot',
      widget.spProHomeMatchType=='足球'?'is_zq_expert':'is_lq_expert':1
    };
    SPClassApiManager.spFunGetInstance().spFunExpertList(queryParameters:params,spProCallBack: SPClassHttpCallBack<SPClassExpertListEntity>(
        spProOnSuccess: (list){
          spProExpertList=list.spProExpertList!;
          setState(() {

          });
        },onError: (v){},spProOnProgress: (v){}
    ));
  }

  Future<void> spFunOnLoad() async{
    // Map<String,dynamic> params = {
    //   'fetch_type':'hot',
    //   widget.spProHomeMatchType=='足球'?'is_zq_expert':'is_lq_expert':1
    // };
    // SPClassApiManager.spFunGetInstance().spFunExpertList(queryParameters:params,spProCallBack: SPClassHttpCallBack<SPClassExpertListEntity>(
    //     spProOnSuccess: (list){
    //       if(list.spProExpertList!=null&&list.spProExpertList!.length>0){
    //         if(mounted){
    //           setState(() {
    //             spProExpertList=list.spProExpertList!.take(4).toList();
    //           });
    //         }
    //       }
    //     },onError: (v){},spProOnProgress: (v){}
    // ));
  }


}
