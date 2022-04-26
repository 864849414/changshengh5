import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassDateUtils.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/untils/SPClassStringUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PCMatchBasketballView extends StatefulWidget {
  SPClassGuessMatchInfo? spProMatchItem;
  PCMatchBasketballView({Key? key,this.spProMatchItem}) : super(key: key);

  @override
  _PCMatchBasketballViewState createState() => _PCMatchBasketballViewState();
}

class _PCMatchBasketballViewState extends State<PCMatchBasketballView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('哈哈哈${widget.spProMatchItem!.spProSectionScore.length}');
    return Container(
      child: Column(
        children: [
          Container(
            color: MyColors.main1,
            height: width(30),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text('',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 1, child: Text('联赛',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 1, child: Text('时间',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 1, child: Text('状态',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 2, child: Text('球队',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 1, child: Text('一节',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 1, child: Text('两节',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 1, child: Text('三节',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 1, child: Text('四节',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 1, child: Text('加',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 1, child: Text('总分',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 1, child: Text('指数',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 2, child: Text('让分',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 2, child: Text('总分',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                Expanded(flex: 2, child: Text('观点',style: TextStyle(fontSize: sp(14),color: Colors.white),textAlign: TextAlign.center,),),
              ],
            ),
          ),
          Container(
            height: width(56),
            color: MyColors.white,
            child: Row(
              children: [
                //关注
                Expanded(flex: 1, child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    alignment: Alignment.center,
                    child:  Image.asset(
                      SPClassImageUtil.spFunGetImagePath('ic_btn_score_colloect'),
                      width: width(16),
                      color: widget.spProMatchItem!.collected=="1" ? null:Colors.grey[300],
                    ),
                  ),
                  onTap: (){
                    if(spFunIsLogin(context: context)){
                      if(!(widget.spProMatchItem?.collected=="1")){
                        SPClassApiManager.spFunGetInstance().spFunCollectMatch(matchId: widget.spProMatchItem!.spProGuessMatchId!,context: context,
                          spProCallBack: SPClassHttpCallBack(
                            spProOnSuccess: (result){
                              SPClassApplicaion.spProEventBus.fire("updateFollow");
                              if(mounted){
                                setState(() {
                                  widget.spProMatchItem?.collected="1";
                                });
                              }
                            },onError: (e){},spProOnProgress: (v){},
                          ),
                        );
                      }else{
                        SPClassApiManager.spFunGetInstance().spFunDelUserMatch(matchId: widget.spProMatchItem!.spProGuessMatchId!,context: context,
                            spProCallBack: SPClassHttpCallBack(
                                spProOnSuccess: (result){
                                  SPClassApplicaion.spProEventBus.fire("updateFollow");
                                  if(mounted){
                                    setState(() {
                                      widget.spProMatchItem?.collected="0";
                                    });
                                  }
                                },onError: (e){},spProOnProgress: (v){}
                            )
                        );
                      }

                    }

                  },
                ),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                //联赛
                Expanded(flex: 1, child:Text(widget.spProMatchItem!.spProLeagueName!,style: TextStyle(fontSize: sp(14),color: SPClassMatchDataUtils.spFunLeagueNameColor(widget.spProMatchItem!.spProLeagueName!)),overflow: TextOverflow.ellipsis,)),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                //时间
                Expanded(flex: 1, child: Text(
                  SPClassDateUtils.spFunDateFormatByString(
                      widget.spProMatchItem!.spProStTime!,
                      "MM-dd\nHH:mm"),
                  style: TextStyle(
                    fontSize: sp(12), color: Color(0xFF999999),),textAlign: TextAlign.center,
                ),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                //状态
                Expanded(flex: 1,
                  child: Text(
                    SPClassStringUtils.spFunMatchStatusString(widget.spProMatchItem?.spProIsOver=="1", widget.spProMatchItem!.spProStatusDesc!, widget.spProMatchItem!.spProStTime!,status:widget.spProMatchItem!.status!),
                    style: TextStyle(fontSize: sp(14),color: DateTime.parse(widget.spProMatchItem!.spProStTime!).difference(DateTime.now()).inSeconds>0? Color(0xFF999999):Color(0xFFF15558)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                //球队
                Expanded(flex: 2, child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.spProMatchItem!.spProTeamOne!,
                          style: TextStyle(fontSize: sp(14),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                        Text(widget.spProMatchItem!.spProTeamTwo!,
                          style: TextStyle(fontSize: sp(14),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                      ],
                    )
                  ),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                //一节
                Expanded(flex: 1, child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.spProMatchItem!.spProSectionScore.length>0?widget.spProMatchItem!.spProSectionScore[0].spProScoreOne!:'-',style: TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                    Text(widget.spProMatchItem!.spProSectionScore.length>0?widget.spProMatchItem!.spProSectionScore[0].spProScoreTwo!:'-',style: TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  ],
                ),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                //两节
                Expanded(flex: 1, child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.spProMatchItem!.spProSectionScore.length>1?widget.spProMatchItem!.spProSectionScore[1].spProScoreOne!:'-',style: TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                    Text(widget.spProMatchItem!.spProSectionScore.length>1?widget.spProMatchItem!.spProSectionScore[1].spProScoreTwo!:'-',style: TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  ],
                ),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                //三节
                Expanded(flex: 1, child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.spProMatchItem!.spProSectionScore.length>2?widget.spProMatchItem!.spProSectionScore[2].spProScoreOne!:'-',style: TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                    Text(widget.spProMatchItem!.spProSectionScore.length>2?widget.spProMatchItem!.spProSectionScore[2].spProScoreTwo!:'-',style: TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  ],
                ),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                //四节
                Expanded(flex: 1, child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.spProMatchItem!.spProSectionScore.length>3?widget.spProMatchItem!.spProSectionScore[3].spProScoreOne!:'-',style: TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                    Text(widget.spProMatchItem!.spProSectionScore.length>3?widget.spProMatchItem!.spProSectionScore[3].spProScoreTwo!:'-',style: TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  ],
                ),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                // 加
                Expanded(flex: 1, child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.spProMatchItem!.spProSectionScore.length>4?widget.spProMatchItem!.spProSectionScore[4].spProScoreOne!:'-',style: TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                    Text(widget.spProMatchItem!.spProSectionScore.length>4?widget.spProMatchItem!.spProSectionScore[4].spProScoreTwo!:'-',style: TextStyle(fontSize: sp(14),color: MyColors.grey_66),textAlign: TextAlign.center,),
                  ],
                ),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                // 总分
                Expanded(flex: 1, child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.spProMatchItem!.spProScoreOne!,
                      style: TextStyle(fontSize: sp(14),fontWeight: FontWeight.w500,color: MyColors.main2),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                    Text(widget.spProMatchItem!.spProScoreTwo!,
                      style: TextStyle(fontSize: sp(14),fontWeight: FontWeight.w500,color: MyColors.main2),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                  ],
                ),),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                // 指数
                Expanded(flex: 1, child:
                Text(((widget.spProMatchItem!.spProDaXiao!=null) ? SPClassStringUtils.spFunSqlitZero(widget.spProMatchItem!.spProDaXiao!.spProMidScore!):""),style: TextStyle(color: Color(0xFF666666),fontSize: sp(14)),textAlign: TextAlign.center,),
                ),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                // 让分
                Expanded(flex: 2,
                  child:Text((((widget.spProMatchItem?.spProYaPan!=null) ?  double.tryParse(widget.spProMatchItem!.spProYaPan!.spProAddScore!)!>=0 ? "+":"":"")+((widget.spProMatchItem?.spProYaPan!=null) ?  SPClassStringUtils.spFunSqlitZero(widget.spProMatchItem!.spProYaPan!.spProAddScore!):"")),style: TextStyle(color: Color(0xFF333333),fontSize: sp(14)),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                ),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                // 总分
                Expanded(flex: 2, child:
                  Text(SPClassStringUtils.spFunSqlitZero((double.tryParse(widget.spProMatchItem!.spProScoreOne!)!+double.tryParse(widget.spProMatchItem!.spProScoreTwo!)!).toString()),style: TextStyle(color: Color(0xFF666666),fontSize: sp(14)),textAlign: TextAlign.center,),
                ),
                Container(
                  height: width(30),
                  width: 0.5,
                  color: MyColors.grey_cc,
                ),
                // 观点
                Expanded(flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width:width(54),
                        height:width(20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.main1,width: 0.5),
                        ),
                        child:Text(widget.spProMatchItem!.spProSchemeNum!+"观点",style: TextStyle(color: Color(0xFF24AAF0),fontSize: sp(12)),),

                      ),
                      Container(
                        width:width(54),
                        height:width(20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFEB3E1C),width: 0.5),
                        ),
                        child:Text('发布',style: TextStyle(color: Color(0xFFEB3E1C),fontSize: sp(12)),),

                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
