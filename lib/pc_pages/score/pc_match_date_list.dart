import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/pages/competition/SPClassMatchDetailPage.dart';
import 'package:changshengh5/pc_pages/score/pc_match_basketball_view.dart';
import 'package:changshengh5/pc_pages/score/pc_match_football_view.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassDateUtils.dart';
import 'package:changshengh5/untils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:changshengh5/widgets/SPClassBallHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class PCMatchDateList extends StatefulWidget {
  String ?status;
  String ?spProMatchType;
  PCMatchDateListState? spProState;

  PCMatchDateList({Key? key,this.status,this.spProMatchType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return spProState=PCMatchDateListState();
  }

}

class PCMatchDateListState extends State<PCMatchDateList> {
  EasyRefreshController ?controller;
  ScrollController ?spProListScrollController;
  ScrollController ?spProScrollControllerDate;
  List<SPClassGuessMatchInfo> spProShowData =[];
  List<Widget> listView=[];
  int page=1;
  int spProDateIndex=0;
  var leagueMap={};
  var spProIsLottery ="";
  List<String> dates =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=EasyRefreshController();
    spProListScrollController=ScrollController();
    if(widget.status=="not_started"){
      dates =SPClassDateUtils.spFunAfterDays(7, SPClassDateUtils.dateFormatByDate(DateTime.now(), 'yyyy-MM-dd'));
    }else{
      dates =SPClassDateUtils.spFunBeforDays(7, SPClassDateUtils.dateFormatByDate(DateTime.now(), 'yyyy-MM-dd'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          (widget.status=="in_progress"||widget.status=="all"||widget.status=="my_collected"||widget.status=="hot")? SizedBox():
          Container(
            color: Colors.white,
            child:  ListView.builder(
                controller: spProScrollControllerDate,
                scrollDirection:Axis.horizontal ,
                itemCount: dates.length,
                itemBuilder: (c,index){
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      color: index==spProDateIndex?MyColors.main1:Colors.white,
                      width: width(84),
                      height: width(48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("周"+
                              "${SPClassDateUtils.spFunFormatWeekday(dates[index])}",style: TextStyle(fontSize: sp(12),color:index==spProDateIndex? Colors.white:MyColors.grey_66),),
                          Text(SPClassDateUtils.spFunDateFormatByString(dates[index],"MM-dd"),style: TextStyle(fontSize: sp(12),color: index==spProDateIndex? Colors.white:MyColors.grey_66),)

                        ],
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        spProDateIndex=index;
                      });
                      controller?.callRefresh();

                    },
                  );
                }),
            height: height(42),
          ),
          widget.spProMatchType=='足球'?Container(
            height: width(36),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: MyColors.grey_cc,width: 0.5))
            ),
            child: Row(
              children: [
                Expanded(
                    child: Text('联赛',style:TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  flex: 2,
                ),
                Expanded(
                  child: Text('时间',style:TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  flex: 1,
                ),
                Expanded(
                  child: Text('状态',style:TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  flex: 1,
                ),
                Expanded(
                  child: Text('球队',style:TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  flex: 4,
                ),
                Expanded(
                  child: Text('半场',style:TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  flex: 1,
                ),
                Expanded(
                  child: Text('角球',style:TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  flex: 1,
                ),
                Expanded(
                  child: Text('指数',style:TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  flex: 2,
                ),
                Expanded(
                  child: Text('观点',style:TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  flex: 2,
                ),
              ],
            ),
          ):Container(),
          Expanded(child: EasyRefresh.custom(
            firstRefresh: true,
            controller:controller ,
            scrollController: spProListScrollController,
            header:SPClassBallHeader(
                textColor: Color(0xFF666666)
            ),
            footer: SPClassBallFooter(
                textColor: Color(0xFF666666)
            ),
            onRefresh: spFunOnReFresh,
            onLoad: spFunOnLoad,
            emptyWidget: spProShowData.isEmpty ? SPClassNoDataView(): null,
            slivers: <Widget>[
              SliverList  (
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    var spProMatchItem =spProShowData[index];

                    if(listView.length-1<index){
                      var view=GestureDetector(
                        key: new GlobalKey(),
                        behavior: HitTestBehavior.opaque,
                        child:spProMatchItem.spProMatchType=="足球"?PCMatchFootballView(spProMatchItem: spProMatchItem,):PCMatchBasketballView(spProMatchItem: spProMatchItem,),
                        onTap: (){
                          SPClassApiManager.spFunGetInstance().spFunMatchClick(queryParameters: {"match_id":spProMatchItem.spProGuessMatchId});
                          SPClassNavigatorUtils.spFunPushRoute(context,  SPClassMatchDetailPage(spProMatchItem,spProMatchType:"guess_match_id",spProInitIndex: 1,));

                        },
                      );
                      listView.add(view);

                    }
                    return listView[index] ;
                  },
                  childCount: spProShowData.length,
                ),
              ),
            ],
          ),)
        ],
      ),
    );
  }

  Future<void> spFunOnReFresh({bool show:true}) async {

    page=1;

    if(show){
      await Future.delayed(Duration(milliseconds: 300));
    }

    await  SPClassApiManager.spFunGetInstance().spFunGuessMatchList<SPClassGuessMatchInfo>(queryParams: spFunGetMatchListParams(page),spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){
          controller?.finishRefresh(noMore: false,success: true);
          controller?.resetLoadState();
          spProShowData=list.spProDataList;
          listView.clear();
          setState(() {
          });
        },
        onError: (result){
          controller?.finishRefresh(success: false);
        },spProOnProgress: (v){}
    ));
  }

  Future<void> spFunOnLoad() async{
    await SPClassApiManager.spFunGetInstance().spFunGuessMatchList<SPClassGuessMatchInfo>(queryParams:  spFunGetMatchListParams(page+1),spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){
          if(list.spProDataList.isEmpty){
            controller?.finishLoad(noMore: true);
          }else{
            page++;
          }
          setState(() {
            spProShowData.addAll(list.spProDataList);
          });
        },
        onError: (result){
          controller?.finishLoad(success: false);
        },spProOnProgress: (v){}
    ));
  }

  Map<String,dynamic> spFunGetMatchListParams(int page) {

    return   {"page":page.toString(), "match_date":dates[spProDateIndex], "fetch_type":widget.status=='hot'?'all':widget.status,"match_type":widget.spProMatchType,"league_name":this.leagueMap[dates[spProDateIndex]],"is_lottery":spProIsLottery,"is_first_level":widget.status=='hot'?'1':'',};

  }

}
