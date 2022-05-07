import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassExpertListEntity.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


///排行榜
class PCRankingList extends StatefulWidget {
  final String ?matchType;
  final bool isHomePage;
  const PCRankingList({Key? key,this.matchType,this.isHomePage = false}) : super(key: key);

  @override
  _PCRankingListState createState() => _PCRankingListState();
}

class _PCRankingListState extends State<PCRankingList> {
  String spProTimeKey="近30天";
  List spProTimeKeys=[
    ["近期", "近30天"],
    [ "近期", "全周期"],
    ["近期","近30天"],
  ];
  String matchType = 'is_zq_expert';

  String spProBoardKey="胜率榜";
  List spProBoardTitles=["胜率榜", "连红榜","回报率"];
  List spProBoardTopTitles=["胜率", "最高连红","回报率"];
  List spProOrderKeys=["correct_rate", "max_red_num","profit_sum"];
  int page=1;
  List<SPClassExpertListExpertList> spProExpertList=[];

  @override
  void initState() {
    onRefresh();
    matchType= widget.matchType??'is_zq_expert';
    // TODO: implement initState
    super.initState();
    SPClassApplicaion.spProEventBus.on<String>().listen((event) {
      if(event.startsWith('pc:home_refresh')){
        matchType = event.split(':').last;
        onRefresh();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 48.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Text('大神排行榜',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500),),
                SizedBox(width: 4.w,),
                Image.asset(
                  SPClassImageUtil.spFunGetImagePath('pc_paihang'),
                  width: 16.w,
                ),
                Expanded(child: SizedBox()),
                Image.asset(
                  SPClassImageUtil.spFunGetImagePath('pc_btn_right'),
                  width: 24.w,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: spProBoardTitles.map((e) {
                return GestureDetector(
                  onTap: (){
                    spProTimeKey="近期";

                    spProExpertList.clear();
                    setState(() {
                      spProBoardKey=e;
                    });
                    onRefresh();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 48.w,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: spProBoardKey==e?MyColors.main1:Colors.transparent,width: 2))
                    ),
                    child: Text(e,style: TextStyle(color:spProBoardKey==e?MyColors.main1:MyColors.grey_66 ,fontWeight: spProBoardKey==e?FontWeight.bold:FontWeight.w400,fontSize: 14.sp),),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: spProExpertList.map((e) {
                int index =  spProExpertList.indexOf(e);
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                    ),
                    height: 72.w,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 32.w,
                          height: 32.w,
                          alignment: Alignment.center,
                          child: (index<3&&index>=0) ?
                          buildMedal(index+1):Text((index+1).toString(),style: TextStyle(fontSize: 17.sp,color: MyColors.grey_33),),
                        ),
                        Expanded(
                          child: Container(
                            width: 110.w,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1,color: Colors.grey[200]!),
                                      borderRadius: BorderRadius.circular(150)),
                                  child:  ClipOval(
                                    child:( e.spProAvatarUrl==null||e.spProAvatarUrl!.isEmpty)? Image.asset(
                                      SPClassImageUtil.spFunGetImagePath("ic_default_avater"),
                                      width: 48.w,
                                      height: 48.w,
                                    ):Image.network(
                                      e.spProAvatarUrl!,
                                      width: 46.w,
                                      height: 46.w,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w,),
                                Expanded(
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(e.spProNickName!,style: TextStyle(fontSize: 18.sp,color: Color(0xFF333333),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                      SizedBox(height: 6.w,),
                                      Text(getboardTitleValue(e),style: TextStyle(fontSize: 14.sp,color: Color(0xFFE3494B)),maxLines: 1,),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: (){
                            if(spFunIsLogin(context: context)){
                              SPClassApiManager.spFunGetInstance().spFunFollowExpert(isFollow: !e.spProIsFollowing!,spProExpertUid: e.spProUserId,context: context,spProCallBack: SPClassHttpCallBack(
                                  spProOnSuccess: (result){
                                    if(!e.spProIsFollowing!){
                                      SPClassToastUtils.spFunShowToast(msg: "关注成功");
                                      e.spProIsFollowing=true;
                                    }else{
                                      e.spProIsFollowing=false;
                                    }
                                    setState(() {});
                                  },onError: (e){},spProOnProgress: (v){}
                              ));
                            }
                          },
                          child: Image.asset(
                            SPClassImageUtil.spFunGetImagePath(e.spProIsFollowing!?'pc_follow':'pc_unfollow'),
                            width: 64.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    // SPClassApiManager.spFunGetInstance().spFunExpertInfo(queryParameters: {"expert_uid":e.spProUserId},
                    //     context:context,spProCallBack: SPClassHttpCallBack(
                    //         spProOnSuccess: (info){
                    //           SPClassNavigatorUtils.spFunPushRoute(context,  SPClassExpertDetailPage(info));
                    //         },onError: (e){},spProOnProgress: (v){}
                    //     ));
                  },

                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }



  Future<void>  onRefresh() async{

    page=1;
    var params;
    var spProRankingType=spProTimeKey.toString();
    if(spProBoardKey=="胜率榜"||spProBoardKey=="回报率"){
      if(spProTimeKey=="近期"){
        spProRankingType="近10场";
      }
    }
    if(spProTimeKey=="近期"&&spProBoardKey=="连红榜"){
      params={
        "fetch_type":"current_red_num",
        "page":"1",
        "$matchType":"1"
      };
    }else{
      params= {"order_key":spProOrderKeys[spProBoardTitles.indexOf(spProBoardKey)],"page":"1","ranking_type":spProRankingType,"$matchType":"1"};
    }

    await Future.delayed(Duration(seconds: 1));
    await  SPClassApiManager.spFunGetInstance().spFunExpertList(queryParameters: params,spProCallBack: SPClassHttpCallBack<SPClassExpertListEntity>(
        spProOnSuccess: (list){
          if(mounted){
            setState(() {
              if(widget.isHomePage){
                spProExpertList=list.spProExpertList!.take(6).toList();
              }else{
                spProExpertList=list.spProExpertList!.take(10).toList();
              }
            });
          }
        },
        onError: (value){
        },spProOnProgress: (v){}
    ));
  }

  String getboardTitleValue(SPClassExpertListExpertList item) {

    if(spProOrderKeys[spProBoardTitles.indexOf(spProBoardKey)]=="correct_rate"){

      try{
        return "胜率${(double.tryParse(item.spProCorrectRate!)!*100).toStringAsFixed(0)}%";
      }catch(e){
        return "";
      }
    }

    if(spProOrderKeys[spProBoardTitles.indexOf(spProBoardKey)]=="max_red_num"){
      if(spProTimeKey=="近期"){
        return '${item.spProCurrentRedNum}连红';
      }
      return '${item.spProMaxRedNum}连红';
    }

    if(spProOrderKeys[spProBoardTitles.indexOf(spProBoardKey)]=="profit_sum"){

      try{
        return "${(double.tryParse(item.spProProfitSum!)!*100).toStringAsFixed(0)}%";
      }catch(e){
        return "";
      }
    }

    return "";
  }

  buildMedal(int ranking) {
    return Image.asset(
      SPClassImageUtil.spFunGetImagePath(ranking==1? "ic_leaderbord_one":(ranking==2? "ic_leaderbord_two":"ic_leaderbord_three")),
      width: 24.w,
    );

  }

}
