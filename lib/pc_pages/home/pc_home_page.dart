import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassExpertListEntity.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/model/SPClassSchemeListEntity.dart';
import 'package:changshengh5/pc_pages/home/pc_expert_item.dart';
import 'package:changshengh5/pc_pages/home/pc_ranking_list.dart';
import 'package:changshengh5/pc_pages/home/pc_scheme_item.dart';
import 'package:changshengh5/pc_pages/pc_dialogs/pc_home_filter_matct_dialog.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:changshengh5/widgets/SPClassNestedScrollViewRefreshBallStyle.dart';
import 'package:changshengh5/widgets/pc_match_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
  String selectedTabScheme = '高胜率';
  List spProTabSchemeKeys = ["recent_correct_rate","newest",  "free"];
  TabController ?spProTabSchemeController;
  List<SPClassSchemeListSchemeList> spProSchemeList=[];//方案
  int page =1;
  String spProFetchType = 'recent_correct_rate';
  String spProFootballPlayWay = '';
  String spProBasketballPlayWay = '';
  GlobalKey _filterkey = GlobalKey();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProTabSchemeController = TabController(
        length: spProTabSchemeTitles.length,
        vsync: this,
        initialIndex: 0);
    spFunRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SPClassNestedScrollViewRefreshBallStyle(
          onRefresh: () async{

          },
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
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
                        ],
                      )
                    ],
                  ),
                ),

              ];
            },
            body: schemeWidget(),
          ),

        ),
        Positioned(
            left: 368.w,
            top: MediaQuery.of(context).size.height/2,
            child: Container(
              width: 80.w,
              height: 128.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Expanded(child: GestureDetector(
                    onTap:(){
                      spProHomeMatchType='足球';
                      spProMatchType = "is_zq_expert";
                      spFunRefresh();
                      SPClassApplicaion.spProEventBus.fire("pc:home_refresh:$spProMatchType");
                      setState(() {
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color:spProHomeMatchType=='足球'? MyColors.main1:MyColors.white,
                      child: Text('足球',style: TextStyle(fontSize: 18.sp,color:spProHomeMatchType=='足球'?MyColors.white: MyColors.grey_66),
                      ),
                    ),
                  )),
                  Expanded(child: GestureDetector(
                    onTap:(){
                      spProHomeMatchType='篮球';
                      spProMatchType = "is_lq_expert";
                      spFunRefresh();
                      SPClassApplicaion.spProEventBus.fire("pc:home_refresh:$spProMatchType");
                      setState(() {
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color:spProHomeMatchType=='篮球'? MyColors.main1:MyColors.white,
                      child: Text('篮球',style: TextStyle(fontSize: 18.sp,color:spProHomeMatchType=='篮球'? MyColors.white:MyColors.main1),),
                    ),
                  )),
                ],
              ),
            )
        )

      ],
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
                        SPClassImageUtil.spFunGetImagePath(spProHomeMatchType=='足球'?'zuqiu':'pc_basketball'),
                        width: 16.w,
                      ),
                      SizedBox(width: 4.w,),
                      Text('$spProHomeMatchType赛事',style: TextStyle(fontSize: 18.sp,color: MyColors.grey_66),)
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
                      Text('$spProHomeMatchType专家',style: TextStyle(fontSize: 20.sp,color: MyColors.grey_33),),

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
              child: PCRankingList(isHomePage: true,matchType: spProMatchType,),
            )
          ],
        ),
      );
  }

//  方案
  Widget schemeWidget(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 36.w),
      color: Color(0xFFE1EAF7),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){

            },
            child: Container(
              height: 48.w,
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 466.w),
              child: Row(
                children: [
                  Expanded(
                      child:Row(
                        children: spProTabSchemeTitles.map((e) {
                          return GestureDetector(
                            onTap: (){
                              selectedTabScheme =e;
                              spProFetchType = spProTabSchemeKeys[spProTabSchemeTitles.indexOf(e)];
                              getScheme();
                              setState(() {
                              });
                            },
                            child: Container(
                              height: 48.w,
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              alignment: Alignment.center,
                              color: selectedTabScheme==e?MyColors.main1:Colors.transparent,
                              child: Text(e,style: TextStyle(fontSize: 18.sp,color: selectedTabScheme==e?Colors.white:MyColors.grey_66),),
                            ),
                          );
                        }).toList(),
                      )
                  ),
                  Image.asset(
                    SPClassImageUtil.spFunGetImagePath('pc_shaixuan'),
                    width: 32.w,
                  ),
                  SizedBox(width: 8.w,),
                  InkWell(
                    onTap: (){
                      RenderBox ? renderBox = _filterkey.currentContext?.findRenderObject() as RenderBox?;
                      var offset = renderBox?.localToGlobal(Offset.zero);
                      double topY = offset!.dy+1;
                      showMenu<int>(
                        context: context,
                        position: RelativeRect.fromLTRB(1000.0, topY+30.w, 470.w, 0.0),
                        items: <PopupMenuItem<int>>[
                          PopupMenuItem<int>(
                              child:PCHomeFilterMatchDialog(spProHomeMatchType,(value){
                                if(spProHomeMatchType == "足球"){
                                  spProFootballPlayWay = value;
                                }else{
                                  spProBasketballPlayWay = value;
                                }
                                getScheme();
                              }),
                              enabled: false,
                              padding:EdgeInsets.zero
                          ),
                        ],
                        elevation: 0,
                      );
                    },
                    child:Text(
                      '筛选',style: TextStyle(fontSize: 18.sp,color: MyColors.grey_66),key: _filterkey,),
                  ),
                  SizedBox(width: 24.w,),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.w,),
          Expanded(child: EasyRefresh(
            footer: SPClassBallFooter(
              textColor: Color(0xFF8F8F8F),
            ),
            onLoad: ()async{
              getMoreScheme();
            },
            child:  Container(
              margin: EdgeInsets.symmetric(horizontal: 466.w,),
              child: GridView.builder(
                  shrinkWrap:true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 24,
                      childAspectRatio: 488/264
                  ),
                  itemCount: spProSchemeList.length,
                  itemBuilder: (context,index){
                    return PCSchemeItem(data: spProSchemeList[index],);
                  }),
            )
            ,)),

          // GridView.builder(
          //     shrinkWrap:true,
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount:2,
          //         crossAxisSpacing: 16,
          //         mainAxisSpacing: 24,
          //         childAspectRatio: 488/264
          //     ),
          //     itemCount: spProSchemeList.length,
          //     itemBuilder: (context,index){
          //       return PCSchemeItem(data: spProSchemeList[index],);
          //     })
        ],
      ),
    );
  }


  spFunRefresh(){
    spFunGetHotMatch();
    spFunGetExpert();
    getScheme();
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

  Future<void>  getScheme() async {
    page=1;
    return  SPClassApiManager.spFunGetInstance().spFunSchemeList(queryParameters: {"fetch_type":spProFetchType,"page":page.toString(),"playing_way":spProHomeMatchType == "足球"?spProFootballPlayWay:spProBasketballPlayWay,"match_type":spProHomeMatchType},spProCallBack: SPClassHttpCallBack(
      spProOnSuccess: (list){
        if(mounted){
          setState(() {
            spProSchemeList=list.spProSchemeList!;
          });
        }
      },
      onError: (value){
      },spProOnProgress: (v){},
    ));
  }

  Future<void>  getMoreScheme() async {
    await  SPClassApiManager.spFunGetInstance().spFunSchemeList(queryParameters: {"fetch_type":spProFetchType,"page":(page+1).toString(),"playing_way":spProHomeMatchType == "足球"?spProFootballPlayWay:spProBasketballPlayWay,"match_type":spProHomeMatchType},spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (list){
          if(list.spProSchemeList!.isNotEmpty){
            page++;
          }
          if(mounted){
            setState(() {
              spProSchemeList.addAll(list.spProSchemeList!);
            });
          }
        },
        onError: (value){
        },spProOnProgress: (v){}
    ));

  }




}
