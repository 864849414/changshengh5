import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/model/SPClassSchemeListEntity.dart';
import 'package:changshengh5/pages/common/SPClassNoDataView.dart';
import 'package:changshengh5/pc_pages/home/pc_scheme_item.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/widgets/SPClassBallFooter.dart';
import 'package:changshengh5/widgets/SPClassBallHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class PCMyAddSchemeList extends StatefulWidget {
  const PCMyAddSchemeList({Key? key}) : super(key: key);

  @override
  _PCMyAddSchemeListState createState() => _PCMyAddSchemeListState();
}

class _PCMyAddSchemeListState extends State<PCMyAddSchemeList> {
  List<SPClassSchemeListSchemeList> spProSchemeList= [];//全部
  EasyRefreshController ?spProRefreshController;
  int page=1;
  var spProNowDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.white,
            child: EasyRefresh.custom(
              firstRefresh: true,
              controller:spProRefreshController ,
              header: SPClassBallHeader(
                  textColor: Color(0xFF666666)
              ),
              footer: SPClassBallFooter(
                  textColor: Color(0xFF666666)
              ),
              emptyWidget:spProSchemeList.isEmpty?  SPClassNoDataView():null,
              onRefresh: spFunOnRefresh,
              onLoad: spFunOnMore,
              slivers: <Widget>[

                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(left: width(10),right: width(10),bottom: width(10)),
                    padding: EdgeInsets.only(top: width(5),bottom: width(5)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width(7))
                    ),
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
                          return Stack(
                            children: [
                              PCSchemeItem(data: spProSchemeList[index],),
                              Positioned(
                                top: 10,
                                right:  width(13) ,
                                child: Image.asset(
                                  (spProSchemeList[index].spProIsWin=="1")? SPClassImageUtil.spFunGetImagePath("ic_result_red"):
                                  (spProSchemeList[index].spProIsWin=="0")? SPClassImageUtil.spFunGetImagePath("ic_result_hei"):
                                  (spProSchemeList[index].spProIsWin=="2")? SPClassImageUtil.spFunGetImagePath("ic_result_zou"):"",
                                  width: width(64),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void>  spFunOnRefresh() async {
    page=1;
    return  SPClassApiManager.spFunGetInstance().spFunSchemeList(queryParameters: {"fetch_type":"mine","page":page.toString(),},spProCallBack: SPClassHttpCallBack<SPClassSchemeListEntity>(
        spProOnSuccess: (list){
          spProRefreshController?.finishRefresh(noMore: false,success: true);
          spProRefreshController?.resetLoadState();
          if(mounted){
            setState(() {
              spProSchemeList=list.spProSchemeList!;
            });
          }
        },
        onError: (value){
          spProRefreshController?.finishRefresh(success: false);
        },spProOnProgress: (v){}
    ));
  }

  Future<void>  spFunOnMore() async {
    await  SPClassApiManager.spFunGetInstance().spFunSchemeList(queryParameters: {"fetch_type":"mine","page":(page+1).toString(),},spProCallBack: SPClassHttpCallBack<SPClassSchemeListEntity>(
        spProOnSuccess: (list){
          if(list.spProSchemeList!.isEmpty){
            spProRefreshController?.finishLoad(noMore: true);
          }else{
            page++;
            spProRefreshController?.finishLoad(noMore: false);

          }

          if(mounted){
            setState(() {
              spProSchemeList.addAll(list.spProSchemeList!);
            });
          }
        },
        onError: (value){
          spProRefreshController?.finishLoad(success: false);

        },spProOnProgress: (v){}
    ));

  }

}
