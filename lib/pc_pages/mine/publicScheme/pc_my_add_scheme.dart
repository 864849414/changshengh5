import 'package:changshengh5/pc_pages/mine/publicScheme/pc_my_add_scheme_list.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PCMyAddScheme extends StatefulWidget {
  const PCMyAddScheme({Key? key}) : super(key: key);

  @override
  _PCMyAddSchemeState createState() => _PCMyAddSchemeState();
}

class _PCMyAddSchemeState extends State<PCMyAddScheme> with TickerProviderStateMixin{
  List spProTabTitle=["我的发布","我的收益"];
  TabController ?spProTabController;
  List<Widget> ?views;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProTabController=TabController(length: spProTabTitle.length,vsync: this);
    views=[PCMyAddSchemeList(),Container()];
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
            padding: EdgeInsets.only(right: width(24)),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!),top: BorderSide(width: 0.4,color: Colors.grey[300]!))
            ),
            child: Row(
              children: [
                Expanded(child: TabBar(
                    labelColor: MyColors.main1,
                    unselectedLabelColor: Color(0xFF333333),
                    isScrollable: true,
                    indicatorColor: MyColors.main1,
                    labelStyle: TextStyle(fontSize: sp(18),fontWeight: FontWeight.bold),
                    unselectedLabelStyle: TextStyle(fontSize: sp(18),fontWeight: FontWeight.w400),
                    controller: spProTabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs:spProTabTitle.map((e){
                      return Tab(text: e,);
                    }).toList()
                )),
                InkWell(
                  onTap: (){

                  },
                  child: Text('去发布',style: TextStyle(fontSize: sp(18),color: MyColors.grey_66),),
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: spProTabController,
              children:views!,
            ),
          )

        ],
      ),
    );
  }
}
