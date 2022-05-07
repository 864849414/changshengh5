import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/pc_pages/mine/pc_follow_expert.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassStringUtils.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PCMine extends StatefulWidget {
  const PCMine({Key? key}) : super(key: key);

  @override
  _PCMineState createState() => _PCMineState();
}

class _PCMineState extends State<PCMine> {
  List spProMyTitles = ["已购方案", "关注专家","关注方案", '专家入驻'];
  var spProMyTitleImages = ["bug","follow_expert", "follow",'expert_apply'];
  int selectIndex = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE1EAF7),
      child: Row(
        children: [
            Container(
              color: Colors.white,
              width: width(320),
              padding: EdgeInsets.symmetric(horizontal: width(24)),
              child: Column(
                children: [
                  SizedBox(height: width(24),),
                  ClipOval(
                    child: SPClassImageUtil.spFunNetWordImage(
                        placeholder: "ic_default_avater",
                        url: SPClassApplicaion.spProUserInfo!.spProAvatarUrl,
                        width: width(120),
                        height:  width(120)),
                  ),
                  SizedBox(height: width(24),),
                  Text(
                    SPClassApplicaion
                        .spProUserInfo!.spProNickName,
                    style: TextStyle(
                        color: MyColors.grey_66,
                        fontSize: sp(20)),
                  ),
                  SizedBox(height: width(24),),
                  Row(
                    children: [
                      Text('当前钻石:',
                        style:  TextStyle(color:MyColors.grey_33,fontSize: sp(14),),
                      ),
                      SizedBox(width: width(5),),
                      Text(SPClassApplicaion
                          .spFunIsExistUserInfo()
                          ? SPClassStringUtils
                          .spFunSqlitZero(
                          SPClassApplicaion
                              .spProUserInfo!
                              .spProDiamond)
                          : "-",
                        style: TextStyle(color:MyColors.main1,height: 0.8,fontSize: sp(36),fontWeight: FontWeight.w500,),
                      ),
                      Image.asset(
                        SPClassImageUtil.spFunGetImagePath("zhuanshi"),
                        width: width(24),
                      ),
                      Expanded(child: SizedBox()),
                      InkWell(
                        onTap: (){
                          if (spFunPcIsLogin(context: context)) {

                          }
                        },
                        child: Container(
                          width: width(83),
                          height: width(34),
                          alignment: Alignment.center,
                          child: Text('充值', style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500,fontSize: sp(14))),
                          decoration: BoxDecoration(
                            color: MyColors.main1,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      )


                    ],
                  ),
                  Column(
                    children: spProMyTitles.map((e){
                      int index = spProMyTitles.indexOf(e);
                      return Container(
                        margin: EdgeInsets.only(top: width(36)),
                        child: InkWell(
                          onTap: (){
                            selectIndex = index;
                            controller.jumpToPage(index);
                            setState(() {
                            });
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                  SPClassImageUtil.spFunGetImagePath(
                                      "ic_user_" +
                                          "${spProMyTitleImages[index]}"),
                                  width: width(36),
                                color: selectIndex==index?null:MyColors.grey_99,
                              ),
                              Text(
                                e,
                                style: TextStyle(
                                    color: selectIndex==index?MyColors.grey_33:MyColors.grey_99,
                                    fontSize: sp(20)),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          SizedBox(width: width(144),),
          Expanded(child: PageView(
            controller: controller,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Text('11111'),
              PCFollowExpert(),
              Text('33333'),
              Text('4444'),
            ],
          ))
        ],
      ),
    );
  }
}
