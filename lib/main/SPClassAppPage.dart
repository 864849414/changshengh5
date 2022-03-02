import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/app/SPClassGlobalNotification.dart';
import 'package:changshengh5/pages/expert/SPClassExpertHomePage.dart';
import 'package:changshengh5/pages/home/HomePage.dart';
import 'package:changshengh5/pages/score/SPClassCompetitionHomePage.dart';
import 'package:changshengh5/pages/user/SPClassUserPage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:changshengh5/widgets/Qnav/SPClassQNavBar.dart';
import 'package:changshengh5/widgets/Qnav/SPClassQNavButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SPClassAppPage extends StatefulWidget
{
  @override

  SPClassAppPageState createState()=>SPClassAppPageState();

}

class SPClassAppPageState extends State<SPClassAppPage>
{
  List<Widget> spProPageList =  [];
  List<SPClassQNavTab> tabs= [];
  int spProIndex = 0;

  var spProExpertIndex=-1;
  late PageController controller;

  var spProLastPressedAt;
  var spProPopTimer= DateTime.now();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height),
        context: context, designSize: Size(360, 640));
    // TODO: implement build
    return WillPopScope(
      child:  Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children:spProPageList,
        ) ,
        bottomNavigationBar:SafeArea(
          bottom: true,
          child:
          SPClassQNavBar(spProNavTabs: tabs,spProPageChange: (value)=>spFunItemTapped(value),spProNavHeight: height(48),spProNavTextSize: width(10),spProSelectIndex: spProIndex,),
        ),
      ),
      onWillPop: () async{
        if(DateTime.now().difference(spProPopTimer).inSeconds>3){
          SPClassToastUtils.spFunShowToast(msg: "再按一次退出");
        }else{
          return true;
        }
        spProPopTimer=DateTime.now();
        return false;
      },
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=PageController();
    // SPClassGlobalNotification.spFunGetInstance(buildContext: context);
    // SPClassApplicaion.spFunSavePushToken();

    if(SPClassApplicaion.spProShowMenuList.contains("home")){
      // spProPageList.add(SPClassHomePage());
      spProPageList.add(HomePage());
      tabs.add(SPClassQNavTab( spProTabText: "推荐",spProTabImage:SPClassImageUtil.spFunGetImagePath("ic_homepage")));
    }
    if(SPClassApplicaion.spProShowMenuList.contains("match")){
      spProPageList.add(SPClassCompetitionHomePage());
      tabs.add(SPClassQNavTab( spProTabText: "比分",spProTabImage:SPClassImageUtil.spFunGetImagePath("ic_score")),);
    }
    //
    // if(SPClassApplicaion.spProShowMenuList.contains("circle")){
    //   spProPageList.add(Container());
    //   // spProPageList.add(SPClassHotHomePage());
    //   tabs.add(SPClassQNavTab( spProTabText: "热门",spProTabImage:SPClassImageUtil.spFunGetImagePath("ic_tab_hot")));
    // }
    if(SPClassApplicaion.spProShowMenuList.contains("expert")){
      spProPageList.add(SPClassExpertHomePage());
        tabs.add(SPClassQNavTab( spProTabText: "专家",spProTabImage:SPClassImageUtil.spFunGetImagePath("ic_match")));
        spProExpertIndex=spProPageList.length-1;
    }

    // if(SPClassApplicaion.spProShowMenuList.contains("game")&&SPClassApplicaion.spProDEBUG == true){
    //   spProPageList.add(Container());
    //   // spProPageList.add(SPClassGamePage());
    //   tabs.add(SPClassQNavTab(spProTabText: '游戏',spProTabImage:SPClassImageUtil.spFunGetImagePath("ic_game")));
    // }
       spProPageList.add(SPClassUserPage());
       tabs.add(SPClassQNavTab(spProTabText: "我的",spProTabImage:SPClassImageUtil.spFunGetImagePath("ic_tab_user"),badge:spFunIsLogin()? int.parse(SPClassApplicaion.spProUserLoginInfo!.spProUnreadMsgNum!):0));

      SPClassApplicaion.spProEventBus.on<String>().listen((event) {
      if(event=="tab:expert"){
        SPClassExpertHomePageState.index=1;
        if(spProExpertIndex>-1){
          spFunItemTapped(spProExpertIndex);
          //(spProPageList[spProExpertIndex] as ExpertHomePage).spProState.tapTopItem(1);
        }
      }
      if(event=="login:out"){
        SPClassGlobalNotification.spFunGetInstance()?.spFunCloseConnect();
        SPClassGlobalNotification.spFunGetInstance()?.spFunInitWebSocket();
        spFunItemTapped(0);
      }
      if(event=="tab:home"){
        spFunItemTapped(0);
      }
      if(event=="userInfo"){
        tabs[tabs.length-1].badge=spFunIsLogin()? int.parse(SPClassApplicaion.spProUserLoginInfo!.spProUnreadMsgNum!):0;
      }
    });

  }

  void spFunItemTapped(int index) {

    if((spProPageList[index] is SPClassUserPage)&&!spFunIsLogin(context: context)){
      setState(() {});
      return;
    }
    setState(() {
      spProIndex = index;
    });

    controller.jumpToPage(index);
    // if(spProPageList[index] is SPClassHomePage){( spProPageList[index] as SPClassHomePage).spProState.spFunTabReFresh();}
    if(spProPageList[index] is SPClassCompetitionHomePage){( spProPageList[index] as SPClassCompetitionHomePage).spProState?.spFunCurrentPage.spProState?.spFunRefreshTab();}

    if((spProPageList[index] is SPClassUserPage)&&spFunIsLogin()){
      SPClassApplicaion.spFunGetUserInfo();
    }

  }
}