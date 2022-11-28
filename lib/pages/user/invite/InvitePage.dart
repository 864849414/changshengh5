import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/utils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'BindInvitePhonePage.dart';

class InvitePage extends StatefulWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title:"邀请大礼",
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.w),
            color: Colors.white,
            child: Text('1.绑定邀请人手机号，该邀请人将获得200钻石。\n\n2.每个账号只能绑定一个邀请人。\n\n3.如发现软件的bug，或者有优化的建议，可以添加客服微信反馈，每个bug奖励50钻石\n\n4.该活动一切解释权归辉讯体育所有。'),
          ),
          SizedBox(height: 100.h,),
          SPClassApplicaion.spProUserInfo!.invitePhone!=''?SizedBox():GestureDetector(
            child:  Container(
              height: 46.w,
              alignment: Alignment.center,
              child:Container(
                alignment: Alignment.center,
                height: 46.w,
                width: 230.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: MyColors.main1
                ),
                child:Text("去绑定",style: TextStyle(fontSize: 19.sp,color: Colors.white),),
              ) ,
            ),
            onTap: () async {
              if(SPClassApplicaion.spProUserInfo!.invitePhone!=''){
                SPClassToastUtils.spFunShowToast(msg: '不能重复绑定');
                return;
              }
              SPClassNavigatorUtils.spFunPushRoute(context, BindInvitePhonePage());
            },
          ),
        ],
      ),

    );
  }
}
