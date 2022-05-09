import 'package:changshengh5/pc_pages/mine/scheme/follow/pc_follow_scheme_list.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PCMyFollowScheme extends StatefulWidget {
  const PCMyFollowScheme({Key? key}) : super(key: key);

  @override
  _PCMyFollowSchemeState createState() => _PCMyFollowSchemeState();
}

class _PCMyFollowSchemeState extends State<PCMyFollowScheme> with TickerProviderStateMixin{
  List csProTabTitle=["未结束","已结束"];
  TabController ?csProTabController;
  List<Widget> ?views;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    csProTabController=TabController(length: csProTabTitle.length,vsync: this);
    views=[PCFollowSchemeList("0"),PCFollowSchemeList("1")];

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(992),
      margin: EdgeInsets.only(top: width(24),right: width(464)),
      child: Column(
        children: [
          Container(
            width: width(992),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!),top: BorderSide(width: 0.4,color: Colors.grey[300]!))
            ),
            child: TabBar(
                labelColor: MyColors.main1,
                unselectedLabelColor: Color(0xFF333333),
                isScrollable: true,
                indicatorColor: MyColors.main1,
                labelStyle: TextStyle(fontSize: sp(18),fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: sp(18),fontWeight: FontWeight.w400),
                controller: csProTabController,
                indicatorSize: TabBarIndicatorSize.label,
                tabs:csProTabTitle.map((e){
                  return Tab(text: e,);
                }).toList()
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: csProTabController,
              children:views!,
            ),
          )

        ],
      ),
    );
  }

}
