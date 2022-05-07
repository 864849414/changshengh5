import 'package:changshengh5/pc_pages/expert/pc_expert_page.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///专家
class PCExpertHome extends StatefulWidget {
  const PCExpertHome({Key? key}) : super(key: key);

  @override
  _PCExpertHomeState createState() => _PCExpertHomeState();
}

class _PCExpertHomeState extends State<PCExpertHome> {
  List tabList=["足球","篮球"];
  PageController? controller;
  int spProIndex = 0;
  List<PCExpertPage> spProPages =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =PageController(initialPage: spProIndex);
    spProPages =tabList.map((e)=>PCExpertPage(spProHomeMatchType: e,)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children:spProPages ,
        ),
        Positioned(
            left: 368.w,
            top: MediaQuery.of(context).size.height / 2,
            child: Container(
              width: 80.w,
              height: 128.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Expanded(
                      child: GestureDetector(
                        onTap: () {
                          spProIndex=0;
                          controller?.jumpToPage(0);
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: spProIndex==0
                              ? MyColors.main1
                              : MyColors.white,
                          child: Text(
                            '足球',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: spProIndex==0
                                    ? MyColors.white
                                    : MyColors.grey_66),
                          ),
                        ),
                      )),
                  Expanded(
                      child: GestureDetector(
                        onTap: () {
                          spProIndex=1;
                          controller?.jumpToPage(1);
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: spProIndex==1
                              ? MyColors.main1
                              : MyColors.white,
                          child: Text(
                            '篮球',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: spProIndex==1
                                    ? MyColors.white
                                    : MyColors.main1),
                          ),
                        ),
                      )),
                ],
              ),
            ))
      ],
    );
  }
}
