import 'dart:async';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/app/SPClassGlobalNotification.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/model/SPClassUserLoginInfo.dart';
import 'package:changshengh5/pages/dialogs/agreement_page.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassNavigatorUtils.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PCLoginPage extends StatefulWidget {
  const PCLoginPage({Key? key}) : super(key: key);

  @override
  _PCLoginPageState createState() => _PCLoginPageState();
}

class _PCLoginPageState extends State<PCLoginPage> {
  TextEditingController _textEditingController = new TextEditingController();
  String spProPhoneNum = "";
  int spProLoginType = 0; //0--验证码登录 1--密码登录 2==一键登录
  String spProVerCode = "";
  int spProCurrentSecond = 0;
  Timer ?spProTimer;
  String spProPhonePwd = "";
  bool isAgree = false; //是否同意协议
  bool spProIsShowPassWord = false;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          child: Container(
            width: 484.w,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 60.w,
                      color: MyColors.main1,
                      alignment: Alignment.center,
                      child: Text('登录/注册',style: TextStyle(color: Colors.white,fontSize: sp(24),),),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width(36),
                            height: width(36),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFFE6E6E6).withOpacity(0.4),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))
                            ),
                            child: Text('x',style: TextStyle(color: Colors.white,fontSize: sp(20)),),
                          ),
                        )
                    )
                  ],
                ),
                SizedBox(height: width(36),),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: width(48)),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFE6E6E6), width: 1)),
                        height: width(54),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              SPClassImageUtil.spFunGetImagePath(
                                  "phone"),
                              width: width(36),
                              color: MyColors.grey_66,
                            ),
                            SizedBox(
                              width: width(8),
                            ),
                            Expanded(
                                child: TextField(
                                  controller: _textEditingController,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                    textBaseline:
                                    TextBaseline.alphabetic,
                                    fontSize: sp(18),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "请输入手机号",
                                    hintStyle: TextStyle(
                                        color: Color(0xFFC6C6C6),
                                        fontSize: sp(14)),
                                    border: InputBorder.none,
                                  ),
                                  inputFormatters: <
                                      TextInputFormatter>[
                                    FilteringTextInputFormatter
                                        .digitsOnly, //只输入数字
                                    LengthLimitingTextInputFormatter(
                                        11), //限制长度
                                  ],
                                  onChanged: (value) {
                                    spProPhoneNum = value;
                                  },
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: width(24),),
                      spProLoginType == 1
                          ? SizedBox()
                          : Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: width(10)),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFE6E6E6), width: 1)),
                              child: TextField(
                                textAlign:
                                TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: sp(18),
                                    textBaseline:
                                    TextBaseline
                                        .alphabetic),
                                decoration:
                                InputDecoration(
                                  hintText: "请输入验证码",
                                  hintStyle: TextStyle(
                                      color: Color(
                                          0xFFC6C6C6),
                                      fontSize:
                                      sp(14)),
                                  border: InputBorder
                                      .none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    spProVerCode =
                                        value;
                                  });
                                },
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              spFunDoSendCode();
                            },
                            child: Container(
                              width: width(138),
                              height: width(54),
                              margin: EdgeInsets.only(
                                  left: width(31)),
                              decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(2),),
                              alignment: Alignment.center,
                              child: Text(
                                spProCurrentSecond > 0
                                    ? "已发送" +
                                    spProCurrentSecond
                                        .toString() +
                                    "s"
                                    : "获取验证码",
                                style: TextStyle(
                                    color: MyColors.grey_66),
                              ),
                            ),
                          )
                        ],
                      ),
                      spProLoginType == 0
                          ? SizedBox():Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFE6E6E6), width: 1)),
                        height: width(54),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              SPClassImageUtil.spFunGetImagePath(
                                  "password"),
                              width: width(36),
                              color: MyColors.grey_66,
                            ),
                            SizedBox(
                              width: width(8),
                            ),
                            Expanded(
                                child: TextField(
                                  obscureText:
                                  !spProIsShowPassWord,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                    textBaseline:
                                    TextBaseline.alphabetic,
                                    fontSize: sp(18),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "请输入密码",
                                    hintStyle: TextStyle(
                                        color: Color(0xFFC6C6C6),
                                        fontSize: sp(14)),
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      padding: EdgeInsets.only(
                                          right: width(24)),
                                      icon: Image
                                          .asset(
                                        !spProIsShowPassWord
                                            ? SPClassImageUtil
                                            .spFunGetImagePath(
                                            'ic_login_uneye')
                                            : SPClassImageUtil
                                            .spFunGetImagePath(
                                            'ic_eye_pwd'),
                                        fit: BoxFit.contain,
                                        color: Colors.white,
                                        width: width(18),
                                        height: width(18),
                                      ),
                                      onPressed: () =>
                                          setState(() {
                                            spProIsShowPassWord =
                                            !spProIsShowPassWord;
                                          }),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      spProPhonePwd = value;
                                    });
                                  },
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: width(24),),
                      /// 登录按钮
                      InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                color:
                                spProPhoneNum.length == 11 &&
                                    (spProVerCode
                                        .isNotEmpty ||
                                        spProPhonePwd
                                            .isNotEmpty)
                                    ? MyColors.main1
                                    : Colors.transparent,
                                border: Border.all(
                                    color: spProPhoneNum.length ==
                                        11 &&
                                        (spProVerCode
                                            .isNotEmpty ||
                                            spProPhonePwd
                                                .isNotEmpty)
                                        ? MyColors.main1
                                        : MyColors.grey_66,
                                    width: 0.5),
                                borderRadius:
                                BorderRadius.circular(2)),
                            height: width(54),
                            alignment: Alignment.center,
                            child: Text(
                              "登录",
                              style: TextStyle(
                                  color: spProPhoneNum.length ==
                                      11 &&
                                      (spProVerCode
                                          .isNotEmpty ||
                                          spProPhonePwd
                                              .isNotEmpty)
                                      ? MyColors.white
                                      : MyColors.grey_66,
                                  fontSize: sp(16)),
                            ),
                          ),
                          onTap: () {
                            if (spProPhoneNum.length != 11) {
                              SPClassToastUtils.spFunShowToast(
                                  msg: "请输入正确11位手机号码!");
                              return;
                            }
                            if (spProLoginType == 0 &&
                                spProVerCode.isEmpty) {
                              SPClassToastUtils.spFunShowToast(
                                  msg: "请输入验证码");
                              return;
                            }
                            if (spProLoginType == 1 &&
                                spProPhonePwd.isEmpty) {
                              SPClassToastUtils.spFunShowToast(
                                  msg: "请输入密码");
                              return;
                            }
                            if (!isAgree) {
                              SPClassToastUtils.spFunShowToast(
                                  msg: "请阅读并勾选 用户协议 和 隐私政策 ");
                              return;
                            }
                            if (spProLoginType == 0) {
                              if (spProVerCode.length == 0) {
                                SPClassToastUtils.spFunShowToast(
                                    msg: "请输入验证码");
                                return;
                              }
                              SPClassApiManager.spFunGetInstance()
                                  .spFunLoginByCode(
                                  spProPhoneNumber:
                                  spProPhoneNum,
                                  spProPhoneCode:
                                  spProVerCode,
                                  spProInviteCode: "",
                                  context: context,
                                  spProCallBack:
                                  SPClassHttpCallBack<
                                      SPClassUserLoginInfo>(
                                    spProOnSuccess:
                                        (loginInfo) {
                                      SPClassApplicaion
                                          .spProUserLoginInfo =
                                          loginInfo;
                                      SPClassApplicaion
                                          .spFunSaveUserState();
                                      SPClassApplicaion
                                          .spFunInitUserState();
                                      SPClassApplicaion
                                          .spFunGetUserInfo();
                                      SPClassGlobalNotification
                                          .spFunGetInstance()
                                          ?.spFunInitWebSocket();
                                      SPClassApplicaion
                                          .spProEventBus
                                          .fire(
                                          "login:gamelist");
                                      Navigator.of(context)
                                          .pop();
                                    },onError: (v){},spProOnProgress: (v){},
                                  ));
                            } else if (spProLoginType == 1) {
                              SPClassApiManager().spFunUserLogin(
                                  queryParameters: {
                                    "username": spProPhoneNum
                                  },
                                  spProBodyParameters: {
                                    "pwd": spProPhonePwd
                                  },
                                  context: context,
                                  spProCallBack:
                                  SPClassHttpCallBack<
                                      SPClassUserLoginInfo>(
                                      spProOnSuccess:
                                          (loginInfo) {
                                        SPClassApplicaion
                                            .spProUserLoginInfo =
                                            loginInfo;
                                        SPClassApplicaion
                                            .spFunSaveUserState();
                                        SPClassApplicaion
                                            .spFunInitUserState();
                                        SPClassApplicaion
                                            .spFunGetUserInfo();
                                        SPClassGlobalNotification
                                            .spFunGetInstance()
                                            ?.spFunInitWebSocket();
                                        SPClassApplicaion
                                            .spProEventBus
                                            .fire("login:gamelist");
                                        Navigator.of(context).pop();
                                      },onError: (e){},spProOnProgress: (v){}
                                  ));
                            }
                          }
                      ),
                      SizedBox(height: width(17),),
                      // 切换验证码 密码
                      Row(
                        children: [
                          InkWell(
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  spProLoginType == 1
                                      ? SPClassImageUtil
                                      .spFunGetImagePath(
                                      'ic_code_login')
                                      : SPClassImageUtil
                                      .spFunGetImagePath(
                                      'ic_pwd_login'),
                                  fit: BoxFit.contain,
                                  color: MyColors.grey_99,
                                  width: width(16),
                                ),
                                Text(
                                  spProLoginType == 0
                                      ? "密码登录"
                                      : "验证码登录",
                                  style: TextStyle(
                                      fontSize: sp(14),
                                      color: MyColors.grey_99),
                                ),
                              ],
                            ),
                            onTap: () {
                              if(spProLoginType==0){
                                spProLoginType=1;
                              }else{
                                spProLoginType=0;
                              }
                              setState(() {
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(height: width(24),),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                isAgree = !isAgree;
                              });
                            },
                            child: Image.asset(
                              SPClassImageUtil
                                  .spFunGetImagePath(isAgree
                                  ? 'ic_select'
                                  : 'ic_seleect_un'),
                              fit: BoxFit.contain,
                              width: width(13),
                            ),
                          ),
                          SizedBox(width: width(8),),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: sp(14),
                                      color: MyColors.grey_99),
                                  text: "登录即代表同意" +
                                      SPClassApplicaion
                                          .spProAppName,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "《用户协议》",
                                        style: TextStyle(
                                            fontSize: sp(14),
                                            color: MyColors.main1),
                                        recognizer:
                                        new TapGestureRecognizer()
                                          ..onTap = () {
                                            SPClassNavigatorUtils.spFunPushRoute(context,  AgreementPage(title:"用户协议",url:"../../assets/html/useragreement.html"));
                                          }),
                                    TextSpan(text: "和"),
                                    TextSpan(
                                        text: "《隐私政策》",
                                        style: TextStyle(
                                            fontSize: sp(14),
                                            color: MyColors.main1),
                                        recognizer:
                                        new TapGestureRecognizer()
                                          ..onTap = () {
                                            SPClassNavigatorUtils.spFunPushRoute(context,  AgreementPage(title:"隐私协议",url:"../../assets/html/privacy_score.html"));
                                          }),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: width(24),),
                    ],
                  ),
                ),

              ],
            ),
          ),
        )
      ],
    ),);
  }

  void spFunDoSendCode() async {
    if (spProPhoneNum.length != 11) {
      SPClassToastUtils.spFunShowToast(msg: "请输入11位正确手机号");
      return;
    } else if (spProCurrentSecond > 0) {
      return;
    }

    SPClassApiManager.spFunGetInstance().spFunSendCode(
      context: context,
      spProPhoneNumber: spProPhoneNum,
      spProCodeType: "login",
      spProCallBack: SPClassHttpCallBack<SPClassBaseModelEntity>(
          spProOnSuccess: (result) {
            SPClassToastUtils.spFunShowToast(msg: "发送成功");
            setState(() {
              spProCurrentSecond = 60;
            });
            spProTimer = Timer.periodic(Duration(seconds: 1), (second) {
              setState(() {
                if (spProCurrentSecond > 0) {
                  setState(() {
                    spProCurrentSecond = spProCurrentSecond - 1;
                  });
                } else {
                  second.cancel();
                }
              });
            });
          },onError: (v){},spProOnProgress: (v){}
      ),

    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (spProTimer != null) {
      spProTimer?.cancel();
    }
  }

}
