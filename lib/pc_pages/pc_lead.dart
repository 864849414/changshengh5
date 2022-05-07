import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/pc_pages/recharge/pc_recharge_page.dart';
import 'package:changshengh5/pc_pages/score/pc_score_home.dart';
import 'package:changshengh5/pc_pages/score/pc_score_page.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'download/pc_download.dart';
import 'expert/pc_expert_home.dart';
import 'home/pc_home_page.dart';
import 'login/pc_login_page.dart';
import 'mine/pc_mine.dart';

class PCLead extends StatefulWidget {
  const PCLead({Key? key}) : super(key: key);

  @override
  _PCLeadState createState() => _PCLeadState();
}

class _PCLeadState extends State<PCLead> {
 String  text ='测试';
 List tabBarList = ['首页','赛事','专家','APP下载','充值中心'];
 PageController controller =new PageController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height),
        context: context, designSize: Size(1920, 1080));
    return  DefaultTabController(
        length: tabBarList.length,
        child: Column(
          children: [
            Container(
              color: Color(0xFF0A65B4),
              padding: EdgeInsets.symmetric(horizontal: 410.w),
              child: Row(
                children: [
                  Image.asset(
                    SPClassImageUtil.spFunGetImagePath('pc_lead_logo'),
                    width: 140.w,
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    width:(120*tabBarList.length).w,
                    child: TabBar(
                      indicatorColor: Colors.white,
                      unselectedLabelStyle: TextStyle(fontSize: 18.sp,color: Colors.white,),
                      labelStyle:TextStyle(fontSize: 18.sp,color: Colors.white,),
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (index){
                        controller.jumpToPage(index);
                      },
                      tabs: tabBarList.map((e){
                        return Tab(text: e,);
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 88.w),
                    child:spFunPcIsLogin()?
                    InkWell(
                      onTap: (){
                        controller.jumpToPage(tabBarList.length);
                      },
                      child: Row(
                        children: [
                          ClipOval(
                            child: SPClassImageUtil.spFunNetWordImage(
                                placeholder: "ic_default_avater",
                                url: SPClassApplicaion.spProUserInfo!.spProAvatarUrl,
                                width: width(36),
                                height:  width(36)),
                          ),
                          Text(
                            SPClassApplicaion
                                .spProUserInfo!.spProNickName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: sp(18)),
                          ),
                        ],
                      ),
                    )
                   :
                    InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (context){
                          return PCLoginPage();
                        });
                      },
                      child: Text('登陆',style: TextStyle(fontSize: 18.sp,color: Colors.white),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Expanded(child:
            PageView(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
                children: [
                  PCHomePage(),
                  PCScoreHome(),
                  PCExpertHome(),
                  PCDownload(),
                  PCRechargePage(),
                  PCMine(),
                ]
            ))
          ],
        )
    );
  }
}
