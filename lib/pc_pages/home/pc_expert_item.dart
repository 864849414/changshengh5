import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassExpertListEntity.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PCExpertItem extends StatefulWidget {
   SPClassExpertListExpertList ?data;
   PCExpertItem({Key? key,this.data}) : super(key: key);

  @override
  _PCExpertItemState createState() => _PCExpertItemState();
}

class _PCExpertItemState extends State<PCExpertItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16), blurRadius: 6,offset: Offset(0,3))],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 16.w,bottom: 8.w),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: MyColors.grey_cc,width: 0.4)),
                gradient:LinearGradient(
                    begin:  Alignment.topCenter,
                    end:  Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF0F3F7),
                      Colors.white
                    ]
                )
            ),
            child: Row(
              children: [
                ClipOval(
                  child: ( widget.data?.spProAvatarUrl==null||widget.data!.spProAvatarUrl!.isEmpty)? Image.asset(
                    SPClassImageUtil.spFunGetImagePath("ic_default_avater"),
                    width: 48.w,
                    height: 48.w,
                  ):Image.network(
                    widget.data?.spProAvatarUrl??'',
                    width: 48.w,
                    height: 48.w,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 4.w,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(SPClassStringUtils.spFunMaxLength(widget.data?.spProNickName??'',length: 6),style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 1,),
                    SizedBox(height: 6.w,),
                    Text('${SPClassStringUtils.spFunMaxLength(widget.data?.intro??'',length: 5)} 粉丝:${widget.data!.spProFollowerNum}',style: TextStyle(color: MyColors.grey_66,fontSize: 12.sp),),
                  ],
                )),
                SizedBox(width: 24.w,),
                GestureDetector(
                  onTap: (){
                    if(spFunIsLogin(context: context)){
                      SPClassApiManager.spFunGetInstance().spFunFollowExpert(isFollow: !widget.data!.spProIsFollowing!,spProExpertUid: widget.data!.spProUserId,context: context,spProCallBack: SPClassHttpCallBack(
                          spProOnSuccess: (result){
                            if(!widget.data!.spProIsFollowing!){
                              SPClassToastUtils.spFunShowToast(msg: "关注成功");
                              widget.data!.spProIsFollowing=true;
                            }else{
                              widget.data!.spProIsFollowing=false;
                            }
                            if(mounted){
                              setState(() {});
                            }
                          },onError: (e){},spProOnProgress: (v){}
                      ));
                    }
                  },
                  child: Image.asset(
                    SPClassImageUtil.spFunGetImagePath(widget.data!.spProIsFollowing!?'pc_follow':'pc_unfollow'),
                    width: 64.w,
                  ),
                )
              ],
            ),
          ),
          // 擅长联赛
          Container(
            margin: EdgeInsets.only(left: 16.w,right: 16.w,top: 21.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('擅长联赛:',style: TextStyle(fontSize: 12.sp,color: MyColors.grey_33),),
                    Container(
                      margin: EdgeInsets.only(left: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 1.w),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(27, 141, 224, 0.1),
                          border: Border.all(color: MyColors.main1,width: 0.4),
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child: Text('亚洲杯',style: TextStyle(fontSize: 12.sp,color: MyColors.main1),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 1.w),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(27, 141, 224, 0.1),
                          border: Border.all(color: MyColors.main1,width: 0.4),
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child: Text('亚洲杯',style: TextStyle(fontSize: 12.sp,color: MyColors.main1),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 1.w),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(27, 141, 224, 0.1),
                          border: Border.all(color: MyColors.main1,width: 0.4),
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child: Text('亚洲杯',style: TextStyle(fontSize: 12.sp,color: MyColors.main1),),
                    ),
                  ],
                ),
                SizedBox(height: 11.w,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 85.w,
                        height: 64.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xFFF0F4F7),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: '${widget.data?.spProCurrentRedNum}\n',
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: MyColors.main2,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '最近连红',
                                  style: TextStyle(color: MyColors.grey_99,fontSize: 12.sp,),
                                ),
                              ]
                          ),
                        ),
                      ),
                      Container(
                        width: 85.w,
                        height: 64.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xFFF0F4F7),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: '${widget.data?.spProMaxRedNum}\n',
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: MyColors.main2,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '历史最高连红',
                                  style: TextStyle(color: MyColors.grey_99,fontSize: 12.sp,),
                                ),
                              ]
                          ),
                        ),
                      ),
                      Container(
                        width: 85.w,
                        height: 64.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xFFF0F4F7),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: (double.tryParse(widget.data!.spProRecentProfitSum!)!*100).toStringAsFixed(0),
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: MyColors.main2,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '%\n',
                                  style: TextStyle(color: MyColors.main2,fontSize: 12.sp,),
                                ),
                                TextSpan(
                                  text: '最近回报率',
                                  style: TextStyle(color: MyColors.grey_99,fontSize: 12.sp,),
                                ),
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
