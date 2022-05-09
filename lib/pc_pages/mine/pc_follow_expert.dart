import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassExpertListEntity.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/pc_pages/home/pc_expert_item.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:changshengh5/widgets/SPClassBallHeader.dart';
import 'package:changshengh5/widgets/SPClassSkeletonList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class PCFollowExpert extends StatefulWidget {
  const PCFollowExpert({Key? key}) : super(key: key);

  @override
  _PCFollowExpertState createState() => _PCFollowExpertState();
}

class _PCFollowExpertState extends State<PCFollowExpert> {
  int page =1;
  List<SPClassExpertListExpertList> spProMyFollowingList = [];
  EasyRefreshController controller = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(656),
      margin: EdgeInsets.only(top: width(24),right: width(800)),
      child:  Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: width(24),left: width(16),),
            child: Row(
              children: [
              Text('关注专家',style: TextStyle(color: MyColors.grey_33,fontSize: sp(20)),),
              ],
            ),
          ),
          Expanded(child: EasyRefresh.custom(
            firstRefresh: true,
            controller: controller,
            header: SPClassBallHeader(textColor: Color(0xFF666666)),
            footer: SPClassBallFooter(textColor: Color(0xFF666666)),
            onRefresh: spFunOnReFresh,
            onLoad: spFunOnLoad,
            emptyWidget: spProMyFollowingList.isEmpty
                ? SPClassNoDataView(
              content: '你还没有关注的专家',
            ) : null,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(width(16)),
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 24,
                            childAspectRatio: 304/204
                        ),
                        shrinkWrap: true,
                        itemCount: spProMyFollowingList.length,
                        itemBuilder: (context, index){
                          return PCExpertItem(data: spProMyFollowingList[index],);
                        }
                    ),
                  )
                ]),
              ),
            ],
          ))
        ],
      ),
    );
  }


  Future<void> spFunOnReFresh() async {
    page = 1;
    await SPClassApiManager.spFunGetInstance().spFunExpertList(
        queryParameters: {"fetch_type": "my_following", "page": "1"},
        spProCallBack: SPClassHttpCallBack<SPClassExpertListEntity>(
            spProOnSuccess: (list) {
              setState(() {
                spProMyFollowingList = list.spProExpertList!;
              });

            }, onError: (result) {
        }, spProOnProgress: (v){

        }
        ));
  }

  Future<void> spFunOnLoad() async {
    await SPClassApiManager.spFunGetInstance().spFunExpertList(
        queryParameters: {"fetch_type": "my_following", "page": "${page + 1}"},
        spProCallBack: SPClassHttpCallBack<SPClassExpertListEntity>(
          spProOnSuccess: (list) {
            if (list.spProExpertList!.isEmpty) {
              controller.finishLoad(noMore: true);
            } else {
              page++;
            }
            setState(() {
              spProMyFollowingList.addAll(list.spProExpertList!);
            });
          },
          onError: (result) {},
          spProOnProgress: (v){},
        ));
  }
}
