import 'package:changshengh5/model/SPClassSchemeListEntity.dart';
import 'package:changshengh5/utils/SPClassDateUtils.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassMatchDataUtils.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PCSchemeItem extends StatefulWidget {
  SPClassSchemeListSchemeList ?data;
  bool spProShowRate;
  PCSchemeItem({Key? key,this.data,this.spProShowRate=true}) : super(key: key);

  @override
  _PCSchemeItemState createState() => _PCSchemeItemState();
}

class _PCSchemeItemState extends State<PCSchemeItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Container(
                height: 80.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey[300]!))
                ),
                child: Row(
                  children: [
                    Stack(
                      children: <Widget>[
                        GestureDetector(
                          child: ClipOval(
                            child: (widget.data?.expert?.spProAvatarUrl == null ||
                                widget.data!.expert!.spProAvatarUrl!.isEmpty)
                                ? Image.asset(
                              SPClassImageUtil.spFunGetImagePath(
                                  "ic_default_avater"),
                              width: 48.w,
                              height: 48.w,
                            )
                                : Image.network(
                              widget.data!.expert!.spProAvatarUrl!,
                              width: 48.w,
                              height: 48.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () {
                            // if (spProCanClick) {
                            //   SPClassApiManager.spFunGetInstance().spFunExpertInfo(
                            //       queryParameters: {"expert_uid": item.spProUserId},
                            //       context: context,
                            //       spProCallBack:
                            //       SPClassHttpCallBack(spProOnSuccess: (info) {
                            //         SPClassNavigatorUtils.spFunPushRoute(
                            //             context, SPClassExpertDetailPage(info));
                            //       },onError: (v){},spProOnProgress: (v){}
                            //       ));
                            // }
                          },
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: (widget.data!.expert!.spProNewSchemeNum != "null" &&
                              int.parse(widget.data!.expert!.spProNewSchemeNum!) > 0)
                              ? Container(
                            alignment: Alignment.center,
                            width: 13.w,
                            height: 13.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xFFE3494B),
                            ),
                            child: Text(
                              widget.data!.expert!.spProNewSchemeNum!,
                              style: TextStyle(
                                  fontSize: 8.sp, color: Colors.white),
                            ),
                          )
                              : Container(),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.data?.expert?.spProNickName??'',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: MyColors.grey_33),),
                        Row(
                          children: [
                            Visibility(
                              child: Container(
                                height: 18.w,
                                padding: EdgeInsets.only(
                                    left: 8.w,
                                    right: 8.w,
                                    ),
                                margin: EdgeInsets.only(right: 8.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    gradient: LinearGradient(colors: [
                                      Color(0xFFFF6A4C),
                                      Color(0xFFFF8D66),
                                    ])),
                                child: Text("近" +
                                    widget.data!.expert!.spProLast10Result!.length
                                        .toString() +
                                    "中" +
                                    "${widget.data!.expert!.spProLast10CorrectNum}",
                                style: TextStyle(fontSize: 12.sp,color: Colors.white),),
                              ),
                              visible: (widget.data!.expert!.spProSchemeNum !=
                                  null &&
                                  (double.tryParse(widget.data!.expert!
                                      .spProLast10CorrectNum!)! /
                                      double.tryParse(widget.data!.expert!
                                          .spProLast10Result!.length
                                          .toString())!) >=
                                      0.6),
                            ),
                            Visibility(
                              child: Container(
                                margin: EdgeInsets.only(right:8.w),
                                padding: EdgeInsets.only(
                                    left: 8.w,
                                    right: 8.w,
                                    ),
                                height: 18.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    gradient: LinearGradient(colors: [
                                      Color(0xFFFFA64D),
                                      Color(0xFFFFB44D),
                                    ])),
                                child: Text("${widget.data!.expert!.spProCurrentRedNum!}连红",
                                  style: TextStyle(fontSize: 12.sp,color: Colors.white),),
                              ),
                              visible: int.tryParse(
                                  widget.data!.expert!.spProCurrentRedNum!)! >
                                  2,
                            ),
                            Visibility(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 8.w,
                                    right: 8.w,
                                    ),
                                alignment: Alignment.center,
                                height: 18.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF1B8DE0), width: 0.5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "不中退",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xFF1B8DE0),
                                      letterSpacing: 1),
                                ),
                              ),
                              visible: widget.data!.spProCanReturn! &&
                                  widget.data!.spProDiamond != "0" &&
                                  widget.data!.spProIsOver == "0",
                            ),
                          ],
                        )
                      ],
                    )

                  ],
                ),
              ),
              Container(
                height: 98.w,
                padding: EdgeInsets.only(top: 32.w,left: 20.w,right: 20.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height:18.w,
                      padding: EdgeInsets.only(left: 4.w, right:4.w),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: SPClassMatchDataUtils.getFontColors(
                                  widget.data!.spProGuessType,
                                  widget.data!.spProMatchType,
                                  widget.data!.spProPlayingWay),
                              width: 0.5),
                          color: SPClassMatchDataUtils.getColors(
                              widget.data!.spProGuessType!,
                              widget.data!.spProMatchType!,
                              widget.data!.spProPlayingWay!),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        SPClassMatchDataUtils.spFunPayWayName(widget.data!.spProGuessType, widget.data!.spProMatchType, widget.data!.spProPlayingWay),
                        style: TextStyle(
                          color: SPClassMatchDataUtils.getFontColors(
                              widget.data!.spProGuessType,
                              widget.data!.spProMatchType,
                              widget.data!.spProPlayingWay),
                          fontSize:10.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w,),
                    Expanded(child:
                    RichText(
                      maxLines: 2,overflow: TextOverflow.ellipsis,
                      text:  TextSpan(
                        text: widget.data?.title??'',
                        style: TextStyle(fontSize: 20.sp,color: MyColors.grey_33,fontWeight: FontWeight.w500,height: 1.2),),
                    ))
                  ],
                ),
              ),
              Container(
                height: 36.w,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Color(0xFFF0F1F2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Text(
                      widget.data!.spProLeagueName!,
                      style: TextStyle(
                          fontSize: 14.sp, color: MyColors.grey_99),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:8.w, right: 8.w),
                      width: 1,
                      height: 14.w,
                      color: Color(0xFFB3B3B3),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            SPClassStringUtils.spFunMaxLength(widget.data!.spProTeamOne!,
                                length: 5),
                            style: TextStyle(
                                fontSize: 14.sp, color: MyColors.grey_66),
                            maxLines: 1,
                          ),
                          Text(
                            " VS ",
                            style: TextStyle(
                                fontSize: 10.sp, color: Color(0xFF999999),height: 1.6),
                            maxLines: 1,
                          ),
                          Text(
                            SPClassStringUtils.spFunMaxLength(widget.data!.spProTeamTwo!,
                                length: 5),
                            style: TextStyle(
                                fontSize: 14.sp, color: MyColors.grey_66),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      SPClassDateUtils.spFunDateFormatByString(
                          widget.data!.spProStTime!, "MM-dd HH:mm"),
                      style: TextStyle(
                          fontSize: 14.sp, color: MyColors.grey_99),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text('${getTime(widget.data!.spProAddTime!)}发布',style: TextStyle(fontSize: 12.sp,color: MyColors.grey_99),),
                    Expanded(child: SizedBox()),
                    Container(
                      child: (widget.data!.spProIsOver == "1" ||
                          widget.data!.spProDiamond == "0" ||
                          widget.data!.spProIsBought == "1")
                          ? Text(
                        '免费',
                        style: TextStyle(
                            color: Color(0xFF4D97FF), fontSize: 14.sp),
                      )
                          : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            SPClassImageUtil.spFunGetImagePath("zhuanshi"),
                            width: 18.w,
                          ),
                          Text(
                            '${widget.data!.spProDiamond}',
                            style: TextStyle(
                                color: MyColors.main1, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        )
      ],
    );
  }

  getTime(String spTime) {
    String time = '刚刚';
    DateTime nowTime = new DateTime.now();
    int sec = nowTime.difference(DateTime.parse(spTime)).inSeconds;
    if (sec < 180) {
      time = '刚刚';
    } else if (sec >= 180 && sec < 3600) {
      time = '${(sec / 60).floor()}分钟前';
    } else if (sec >= 3600 && sec < 86400) {
      time = '${(sec / 3600).floor()}小时前';
    } else {
      time = '${(sec / 86400).floor() > 7 ? 7 : (sec / 86400).floor()}天前';
    }
    return time;
  }

}
