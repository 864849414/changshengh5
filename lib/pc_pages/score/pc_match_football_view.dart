import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassDateUtils.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/utils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PCMatchFootballView extends StatefulWidget {
  SPClassGuessMatchInfo ?spProMatchItem;
  PCMatchFootballView({Key? key,this.spProMatchItem}) : super(key: key);

  @override
  _PCMatchFootballViewState createState() => _PCMatchFootballViewState();
}

class _PCMatchFootballViewState extends State<PCMatchFootballView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: width(10)),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: MyColors.grey_cc,width: 0.5))
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
              child: Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      width: width(45),
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
                  ),
                  Text(widget.spProMatchItem!.spProLeagueName!,style: TextStyle(fontSize: sp(14),color: SPClassMatchDataUtils.spFunLeagueNameColor(widget.spProMatchItem!.spProLeagueName!)),overflow: TextOverflow.ellipsis,)
                ],
              )
          ),
          Expanded(
              flex: 1,
              child: Text(
                SPClassDateUtils.spFunDateFormatByString(
                    widget.spProMatchItem!.spProStTime!,
                    "MM-dd\nHH:mm"),
                style: TextStyle(
                    fontSize: sp(12), color: Color(0xFF999999),),textAlign: TextAlign.center,
              ),
          ),
          Expanded(
              flex: 1,
              child: Text(
                  SPClassStringUtils.spFunMatchStatusString(widget.spProMatchItem?.spProIsOver=="1", widget.spProMatchItem!.spProStatusDesc!, widget.spProMatchItem!.spProStTime!,status:widget.spProMatchItem!.status!),
                style: TextStyle(fontSize: sp(14),color: DateTime.parse(widget.spProMatchItem!.spProStTime!).difference(DateTime.now()).inSeconds>0? Color(0xFF999999):Color(0xFFF15558)),
                textAlign: TextAlign.center,
              )
          ),
          Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child:Text(widget.spProMatchItem!.spProTeamOne!,
                      style: TextStyle(fontSize: sp(14),fontWeight: FontWeight.w500,),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(150)),
                    child:SPClassImageUtil.spFunNetWordImage(
                        placeholder: "ic_team_one",
                        url: widget.spProMatchItem!.spProIconUrlOne!,
                        width: width(18),
                        height:  width(18)),
                  ),
                  Container(
                    width: width(60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        !SPClassMatchDataUtils.spFunShowScore(widget.spProMatchItem!.status!)?
                        Text("VS",style: TextStyle(color: Color(0xFF999999),fontWeight: FontWeight.w500,fontSize: sp(14),)):
                        Text(widget.spProMatchItem!.spProScoreOne!+
                            " - "+
                            widget.spProMatchItem!.spProScoreTwo!,style: TextStyle(color: Color(0xFFDE3C31),fontWeight: FontWeight.w500,fontSize: sp(14),),)
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(150)),
                    child:SPClassImageUtil.spFunNetWordImage(
                        placeholder: "ic_team_two",
                        url: widget.spProMatchItem!.spProIconUrlTwo!,
                        width: width(18),
                        height:  width(18)),
                  ),
                  Expanded(child:Text(widget.spProMatchItem!.spProTeamTwo!,
                    style: TextStyle(fontSize: sp(14),fontWeight: FontWeight.w500,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  )

                ],
              )
          ),
          Expanded(
              flex: 1,
              child: Text(
                  widget.spProMatchItem?.spProHalfScore??'',
                style: TextStyle(fontSize: sp(14),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),

          ),
          Expanded(
              flex: 1,
              child: Text(
                widget.spProMatchItem?.corner??'',
                style: TextStyle(fontSize: sp(14),),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
          ),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  widget.spProMatchItem!.spProYaPan!=null?Text(SPClassStringUtils.spFunSqlitZero(widget.spProMatchItem!.spProYaPan!.spProWinOddsOne!)+
                      " / "+
                      widget.spProMatchItem!.spProYaPan!.spProAddScoreDesc!+
                      " /"+
                      SPClassStringUtils.spFunSqlitZero(widget.spProMatchItem!.spProYaPan!.spProWinOddsTwo!), style: TextStyle(fontSize: sp(12)),) :SizedBox(),

                  widget.spProMatchItem!.spProDaXiao!=null? Text(SPClassStringUtils.spFunSqlitZero(widget.spProMatchItem!.spProDaXiao!.spProWinOddsOne!)+
                      " /"+
                      SPClassStringUtils.spFunSqlitZero(widget.spProMatchItem!.spProMidScore!)+
                      "球 /"+
                      SPClassStringUtils.spFunSqlitZero(widget.spProMatchItem!.spProDaXiao!.spProWinOddsTwo!), style: TextStyle(fontSize: sp(12)),):SizedBox(),
                ],
              )
          ),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (widget.spProMatchItem?.spProSchemeNum==null||int.tryParse(widget.spProMatchItem!.spProSchemeNum!)==0)? SizedBox():
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: width(54),
                      height: width(20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.main1,width: 0.5)
                      ),
                      child: Text("${widget.spProMatchItem?.spProSchemeNum??'0'}观点",style: TextStyle(color: Color(0xFF24AAF0),fontSize: width(10)),),
                    ),
                    onTap: (){
                      SPClassApiManager.spFunGetInstance().spFunMatchClick(queryParameters: {"match_id":widget.spProMatchItem!.spProGuessMatchId!});
                      // SPClassNavigatorUtils.spFunPushRoute(context,  SPClassMatchDetailPage(widget.spProMatchItem,spProMatchType:"guess_match_id",spProInitIndex: 3,));
                    },
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}
