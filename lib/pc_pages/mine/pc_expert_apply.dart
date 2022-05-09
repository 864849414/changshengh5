import 'dart:async';
import 'dart:io';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PCExpertApply extends StatefulWidget {
  const PCExpertApply({Key? key}) : super(key: key);

  @override
  _PCExpertApplyState createState() => _PCExpertApplyState();
}

class _PCExpertApplyState extends State<PCExpertApply> {
  String spProExpertType = "足球";
  String spProRealName = "";
  String spProIdNumber = "";
  File? spProFrontFile;
  File? spProBackFile;
  String spProIdFrontUrl = "";
  String spProIdBackUrl = "";
  String spProPhoneNumber = "";
  String spProPhoneCode = "";
  int spProCurrentSecond = 0;
  var spProTimer;
  String spProExpertVerifyStatus='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spProExpertVerifyStatus = SPClassApplicaion.spProUserLoginInfo!.spProExpertVerifyStatus!;
    print('哈哈哈：${spProExpertVerifyStatus}');
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(992),
      margin: EdgeInsets.only(top: width(24), right: width(464)),
      padding: EdgeInsets.only(left: width(30),top: width(48),bottom: width(48)),
      color: Colors.white,
      child:spProExpertVerifyStatus=='0'?
      Text('您的申请正在审核中，请留意系统消息'):
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '申请专家',
                style: TextStyle(fontSize: sp(24)),
              ),
              Text(
                '为了提供你更好的服务，请务必填写真实信息',
                style: TextStyle(fontSize: sp(14), color: MyColors.main2),
              ),
            ],
          ),
          SizedBox(height: width(43),),
          /// 专家类型
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    SPClassImageUtil.spFunGetImagePath("ic_edit_content"),
                    fit: BoxFit.contain,
                    width: width(24),
                  ),
                  SizedBox(
                    width: width(5),
                  ),
                  Text(
                    "专家类型",
                    style:
                        TextStyle(fontSize: sp(20), color: Color(0xFF333333)),
                  ),
                  SizedBox(
                    width: width(5),
                  ),
                  Text(
                    "*",
                    style: TextStyle(fontSize: sp(14), color: MyColors.main2),
                  )
                ],
              ),
              SizedBox(
                height: width(10),
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      spProExpertType = '足球';
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: width(236),
                      height: width(48),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: spProExpertType == '足球'
                              ? MyColors.main1
                              : Color(0xFFF5F6F7)),
                      child: Text(
                        '足球',
                        style: TextStyle(
                            fontSize: sp(18),
                            color: spProExpertType == '足球'
                                ? Colors.white
                                : MyColors.grey_99),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width(16),
                  ),
                  GestureDetector(
                    onTap: () {
                      spProExpertType = '篮球';
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: width(236),
                      height: width(48),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: spProExpertType == '篮球'
                              ? MyColors.main1
                              : Color(0xFFF5F6F7)),
                      child: Text(
                        '篮球',
                        style: TextStyle(
                            fontSize: sp(18),
                            color: spProExpertType == '篮球'
                                ? Colors.white
                                : MyColors.grey_99),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: width(25),),
          /// 实名认证
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    SPClassImageUtil.spFunGetImagePath("ic_login_account"),
                    fit: BoxFit.contain,
                    width: width(24),
                  ),
                  SizedBox(
                    width: width(5),
                  ),
                  Text(
                    "实名认证",
                    style:
                        TextStyle(fontSize: sp(20), color: Color(0xFF333333)),
                  ),
                  SizedBox(
                    width: width(5),
                  ),
                  Text(
                    "*",
                    style: TextStyle(fontSize: sp(12), color: MyColors.main2),
                  )
                ],
              ),
              Container(
                width: width(488),
                padding: EdgeInsets.symmetric(
                  horizontal: width(15),
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFF0F1F2),
                    borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  maxLines: 1,
                  style: TextStyle(fontSize: sp(18), color: Color(0xFF333333)),
                  decoration: InputDecoration(
                    hintText: "请填写真实姓名，用于结算与认证",
                    hintStyle:
                        TextStyle(fontSize: sp(18), color: Color(0xFFC6C6C6)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    spProRealName = value;
                  },
                ),
              ),
              SizedBox(height: width(10),),
              Container(
                width: width(488),
                padding: EdgeInsets.symmetric(
                  horizontal: width(15),
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFF0F1F2),
                    borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  maxLines: 1,
                  style: TextStyle(fontSize: sp(18), color: Color(0xFF333333)),
                  decoration: InputDecoration(
                    hintText: "请填写真实身份证号，用于结算与认证",
                    hintStyle:
                        TextStyle(fontSize: sp(18), color: Color(0xFFC6C6C6)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    spProIdNumber = value;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: width(25),),
          ///平台分析
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    SPClassImageUtil.spFunGetImagePath("ic_user_id_num"),
                    fit: BoxFit.contain,
                    width: width(24),
                  ),
                  SizedBox(
                    width: width(5),
                  ),
                  Text(
                    "比赛分析",
                    style:
                    TextStyle(fontSize: sp(20), color: Color(0xFF333333)),
                  ),
                  Text(
                    "(截图在其他平台的分析)",
                    style:
                    TextStyle(fontSize: sp(20), color: MyColors.grey_99),
                  ),
                  SizedBox(
                    width: width(5),
                  ),
                  Text(
                    "*",
                    style: TextStyle(fontSize: sp(12), color: MyColors.main2),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: width(22)),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: height(10),
                                right: width(10),
                                bottom: width(10)),
                            width: width(207),
                            height: height(134),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                border: Border.all(
                                    width: 0.4, color: Colors.grey[300]!)),
                            alignment: Alignment.center,
                            child: spProFrontFile == null
                                ? Image.asset(
                              SPClassImageUtil.spFunGetImagePath(
                                  "ic_add_pic"),
                              fit: BoxFit.contain,
                              width: width(36),
                            )
                                : Image.file(
                              spProFrontFile!,
                              width: width(207),
                              height: height(134),
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            XFile? xImage = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (xImage == null) {
                              return;
                            }
                            File image = File(xImage.path);
                            if (mounted) {
                              setState(() {
                                spProIdFrontUrl = "";
                                spProFrontFile = image;
                              });
                            }
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: height(10),
                                right: width(10),
                                bottom: width(10)),
                            width: width(207),
                            height: height(134),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                border: Border.all(
                                    width: 0.4, color: Colors.grey[300]!)),
                            alignment: Alignment.center,
                            child: spProBackFile == null
                                ? Image.asset(
                              SPClassImageUtil.spFunGetImagePath(
                                  "ic_add_pic"),
                              fit: BoxFit.contain,
                              width: width(36),
                            )
                                : Image.file(
                              spProBackFile!,
                              width: width(207),
                              height: height(134),
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            XFile? xImage = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (xImage == null) {
                              return;
                            }
                            if (mounted) {
                              File image = File(xImage.path);
                              setState(() {
                                spProIdBackUrl = "";
                                spProBackFile = image;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: width(25),),
          ///手机号码
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    SPClassImageUtil.spFunGetImagePath("ic_login_account"),
                    fit: BoxFit.contain,
                    width: width(24),
                  ),
                  SizedBox(
                    width: width(5),
                  ),
                  Text(
                    "手机验证",
                    style:
                        TextStyle(fontSize: sp(20), color: Color(0xFF333333)),
                  ),
                  SizedBox(
                    width: width(5),
                  ),
                  Text(
                    "*",
                    style: TextStyle(fontSize: sp(12), color: MyColors.main2),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width(15),
                ),
                width: width(488),
                decoration: BoxDecoration(
                    color: Color(0xFFF0F1F2),
                    borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  maxLines: 1,
                  style: TextStyle(fontSize: sp(18), color: Color(0xFF333333)),
                  decoration: InputDecoration(
                    hintText: "请填写手机号码",
                    hintStyle:
                        TextStyle(fontSize: sp(18), color: Color(0xFFC6C6C6)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        spProPhoneNumber = value;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: width(10),),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width(15),
                    ),
                    margin: EdgeInsets.only(right: width(89)),
                    width: width(178),
                    decoration: BoxDecoration(
                        color: Color(0xFFF0F1F2),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: sp(18), color: Color(0xFF333333)),
                      decoration: InputDecoration(
                        hintText: "输入验证码",
                        hintStyle: TextStyle(
                            fontSize: sp(18), color: Color(0xFFC6C6C6)),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        spProPhoneCode = value;
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (spProPhoneNumber.length != 11 ||
                          spProCurrentSecond > 0) {
                        return;
                      }
                      spFunDoSendCode();
                    },
                    child: Container(
                      width: width(152),
                      height: width(48),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE6E6E6), width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        spProCurrentSecond > 0
                            ? "已发送" + spProCurrentSecond.toString() + "s"
                            : "获取验证码",
                        style: TextStyle(
                            fontSize: sp(16), color: MyColors.grey_99),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: width(25),),
          ///提交
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              width: width(236),
              height: width(48),
              color: MyColors.main1,
              child: Text(
                "提交认证",
                style: TextStyle(
                    fontSize: sp(18),
                    color: Colors.white,),
              ),
            ),
            onTap: () async {
              spFunCommit();
            },
          ),
        ],
      ),
    );
  }

  void spFunDoSendCode() {
    SPClassApiManager.spFunGetInstance().spFunSendCode(
        spProPhoneNumber: spProPhoneNumber,
        context: context,
        spProCodeType: "apply_expert",
        spProCallBack: SPClassHttpCallBack(
            spProOnSuccess: (value) {
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
            },
            onError: (e) {},
            spProOnProgress: (v) {}));
  }

  void spFunCommit() {
    if (spProRealName.isEmpty) {
      SPClassToastUtils.spFunShowToast(msg: "请填写真实姓名");
      return;
    }
    // if(spProNickName.isEmpty){
    //   SPClassToastUtils.spFunShowToast(msg: "请填写真实姓名");
    //   return;
    // }
    if (spProIdNumber.isEmpty) {
      SPClassToastUtils.spFunShowToast(msg: "请填写身份证号码");
      return;
    }
    if (spProBackFile == null || spProFrontFile == null) {
      SPClassToastUtils.spFunShowToast(msg: "请上传比赛分析");
      return;
    }
    // if(spProApplyReason.isEmpty){
    //   SPClassToastUtils.spFunShowToast(msg: "请填写申请理由");
    //   return;
    // }
    // if(QQNumber.isEmpty){
    //   SPClassToastUtils.spFunShowToast(msg: "请填写QQ号码");
    //   return;
    // }
    if (spProPhoneNumber.isEmpty) {
      SPClassToastUtils.spFunShowToast(msg: "请填写手机号码");
      return;
    }
    if (spProPhoneCode.isEmpty) {
      SPClassToastUtils.spFunShowToast(msg: "请填写验证码");
      return;
    }

    if (spProIdFrontUrl.isEmpty) {
      SPClassApiManager.spFunGetInstance().spFunUploadFiles(
          context: context,
          files: [spProFrontFile!, spProBackFile!],
          params: {"is_multi": "1", "is_private": "1"},
          spProCallBack: SPClassHttpCallBack<SPClassBaseModelEntity>(
              spProOnSuccess: (result) {
                var images = [];
                result.data.forEach((pic) {
                  images.add(pic);
                });
                spProIdFrontUrl = images[0];
                spProIdBackUrl = images[1];
                spFunCommitInfo();
              },
              onError: (e) {},
              spProOnProgress: (v) {}));
    } else {
      spFunCommitInfo();
    }
  }

  void spFunCommitInfo() {
    var paramKey = "";
    if (spProExpertType == "足球") {
      paramKey = "is_zq_expert";
    } else if (spProExpertType == "篮球") {
      paramKey = "is_lq_expert";
    } else if (spProExpertType == "电竞") {
      paramKey = "is_es_expert";
    }
    SPClassApiManager.spFunGetInstance().spFunExpertApply(
        spProBodyParameters: {
          "real_name": spProRealName,
          "id_number": spProIdNumber,
          "phone_number": spProPhoneNumber.trim(),
          "phone_code": spProPhoneCode.trim(),
          "id_front_url": spProIdFrontUrl,
          "id_back_url": spProIdBackUrl,
          "apply_reason": '新版本不需要填写原因' /*spProApplyReason*/,
          "qq_number": '10000' /*QQNumber*/,
          "nick_name": SPClassApplicaion.spProUserInfo!.spProNickName,
          paramKey: "1"
        },
        context: context,
        spProCallBack: SPClassHttpCallBack<SPClassBaseModelEntity>(
            spProOnSuccess: (value) {
              SPClassApplicaion.spProUserLoginInfo!.spProExpertVerifyStatus =
                  "0";
              SPClassToastUtils.spFunShowToast(msg: "提交成功");
              setState(() {
              });
            },
            onError: (e) {},
            spProOnProgress: (v) {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (spProTimer != null) {
      spProTimer.cancel();
    }
  }
}
