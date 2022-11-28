import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/SPClassToolBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BindInvitePhonePage extends StatefulWidget {
  const BindInvitePhonePage({Key? key}) : super(key: key);

  @override
  State<BindInvitePhonePage> createState() => _BindInvitePhonePageState();
}

class _BindInvitePhonePageState extends State<BindInvitePhonePage> {
  String phone ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SPClassToolBar(
        context,
        title:"绑定邀请手机号",
      ),
      body: Column(
        children: [
          SizedBox(height: 12.w),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 18.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  SPClassImageUtil.spFunGetImagePath('password_1'),
                  fit: BoxFit.contain,
                  width: 24.w,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: TextField(
                    obscureText: false,
                    style: TextStyle(fontSize: 16, color: Color(0xFF333333),textBaseline: TextBaseline.alphabetic),
                    decoration: InputDecoration(
                      hintText: "请输入绑定人手机号",
                      hintStyle: TextStyle(fontSize: 16, color: Color(0xFF999999),textBaseline: TextBaseline.alphabetic),

                    ),
                    onChanged: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 100.w),
          GestureDetector(
        child:  Container(
          margin: EdgeInsets.only(top: 10.w),
          height: 53.w,
          alignment: Alignment.center,
          child:Container(
            alignment: Alignment.center,
            height: 46.w,
            width: 276.w,
            decoration: BoxDecoration(
              color: MyColors.main1,
              borderRadius: BorderRadius.circular(150),
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text("确定",style: TextStyle(fontSize: 15.sp,color: Colors.white),)
              ],
            ),
          ) ,
        ),
        onTap: () async {
          if(phone.isEmpty){
            SPClassToastUtils.spFunShowToast(msg: '手机号不能为空');
            return;
          }
          SPClassApiManager.spFunGetInstance().saveInvitePhone(context: context,invitePhone: phone,hcProCallBack: SPClassHttpCallBack(
            spProOnSuccess: (result) async{
              SPClassToastUtils.spFunShowToast(msg: '绑定成功');
            },
          ));

        },
      ),
        ],
      ),
    );
  }
}
