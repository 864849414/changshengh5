import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PCLead extends StatefulWidget {
  const PCLead({Key? key}) : super(key: key);

  @override
  _PCLeadState createState() => _PCLeadState();
}

class _PCLeadState extends State<PCLead> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height),
        context: context, designSize: Size(1920, 1080));
    return DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 360.w),
              child: TabBar(
                indicatorColor: Colors.transparent,
                tabs: [
                  Text('首页',style: TextStyle(color: Colors.black),),
                  Text('首页',style: TextStyle(color: Colors.black),),
                  Text('首页',style: TextStyle(color: Colors.black),),
                ],
              ),
            ),
            Expanded(child:TabBarView(
              children: [
                Text('111',style: TextStyle(color: Colors.black),),
                Text('222',style: TextStyle(color: Colors.black),),
                Text('333',style: TextStyle(color: Colors.black),),
              ],
            ))
          ],
        )
    );
  }
}
