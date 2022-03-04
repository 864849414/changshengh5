import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home/pc_home_page.dart';

class PCLead extends StatefulWidget {
  const PCLead({Key? key}) : super(key: key);

  @override
  _PCLeadState createState() => _PCLeadState();
}

class _PCLeadState extends State<PCLead> {
 String  text ='测试';
 List tabBarList = ['首页','赛事','专家','APP下载','充值中心'];

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
                      tabs: tabBarList.map((e){
                        return Tab(text: e,);
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 88.w),
                    child: Row(
                      children: [
                        Text('登陆',style: TextStyle(fontSize: 18.sp,color: Colors.white),),
                        Container(
                          width: 1,
                          height: 18.w,
                          color: Color.fromRGBO(255, 255, 255, 0.4),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        Text('注册',style: TextStyle(fontSize: 18.sp,color: Colors.white),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(child:
            TabBarView(
                children: [
                  PCHomePage(),
                  Text('1111'),
                  Text('2222'),
                  Text('3333'),
                  Text('4444'),
                ]
            ))
          ],
        )
    );
  }
}
