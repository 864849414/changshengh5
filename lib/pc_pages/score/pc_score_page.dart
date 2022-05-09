import 'package:changshengh5/pc_pages/score/pc_match_date_list.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PCScorePage extends StatefulWidget {
  final String ?spProHomeMatchType;
  PCScorePage({Key? key,this.spProHomeMatchType}) : super(key: key);

  @override
  _PCScorePageState createState() => _PCScorePageState();
}

class _PCScorePageState extends State<PCScorePage>
    with TickerProviderStateMixin<PCScorePage> {
  List tabList = [
    '全部',
    '热门',
    '即时',
    '赛程',
    '赛果',
    '关注',
  ];
  TabController? _controller;
  List<PCMatchDateList> views = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        TabController(length: tabList.length, vsync: this, initialIndex: 0);
    views.add(PCMatchDateList(status: "all",spProMatchType:widget.spProHomeMatchType));
    views.add(PCMatchDateList(status: "hot",spProMatchType:widget.spProHomeMatchType));
    views.add(PCMatchDateList(status: "in_progress",spProMatchType:widget.spProHomeMatchType));
    views.add(PCMatchDateList(status: "not_started",spProMatchType:widget.spProHomeMatchType));
    views.add(PCMatchDateList(status: "over",spProMatchType:widget.spProHomeMatchType));
    views.add(PCMatchDateList(status: "my_collected",spProMatchType:widget.spProHomeMatchType));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE1EAF7),
      padding: EdgeInsets.symmetric(horizontal: 464.w),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: width(24), bottom: width(16)),
            color: Colors.white,
            child: Row(
              children: [
                TabBar(
                    indicator: BoxDecoration(color: MyColors.main1),
                    indicatorColor: MyColors.main1,
                    unselectedLabelStyle: TextStyle(
                      fontSize: 18.sp,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: MyColors.grey_66,
                    labelStyle: TextStyle(
                      fontSize: 18.sp,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _controller,
                    isScrollable: true,
                    tabs: tabList.map((e) {
                      return Tab(
                        text: e,
                      );
                    }).toList()),
                Expanded(child: SizedBox()),
                Image.asset(
                  SPClassImageUtil.spFunGetImagePath('pc_shaixuan'),
                  width: 32.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
                InkWell(
                  onTap: () {
                    // RenderBox ? renderBox = _filterkey.currentContext?.findRenderObject() as RenderBox?;
                    // var offset = renderBox?.localToGlobal(Offset.zero);
                    // double topY = offset!.dy+1;
                    // showMenu<int>(
                    //   context: context,
                    //   position: RelativeRect.fromLTRB(1000.0, topY+30.w, 470.w, 0.0),
                    //   items: <PopupMenuItem<int>>[
                    //     PopupMenuItem<int>(
                    //         child:PCHomeFilterMatchDialog(spProHomeMatchType,(value){
                    //           spProPlayWay = value;
                    //           getScheme();
                    //         }),
                    //         enabled: false,
                    //         padding:EdgeInsets.zero
                    //     ),
                    //   ],
                    //   elevation: 0,
                    // );
                  },
                  child: Text(
                    '筛选',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: MyColors.grey_66), /*key: _filterkey,*/
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                child: TabBarView(
                  controller: _controller,
                  children: views,
                ),
              )),
        ],
      ),
    );
  }
}
