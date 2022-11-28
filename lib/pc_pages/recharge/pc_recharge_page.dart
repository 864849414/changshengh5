import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassCoupon.dart';
import 'package:changshengh5/pc_pages/recharge/pc_pay_page.dart';
import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/SPClassStringUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///充值中心
class PCRechargePage extends StatefulWidget {
  const PCRechargePage({Key? key}) : super(key: key);

  @override
  _PCRechargePageState createState() => _PCRechargePageState();
}

class _PCRechargePageState extends State<PCRechargePage> {
  int spProSelectIndex=0;
  List rechargeString=[
    {"value_diamond":"38","value":"38","in_put":false,"double":false,"limit":false},
    {"value_diamond":"88","value":"88","in_put":false,"double":false,"limit":false},
    {"value_diamond":"388","value":"388","in_put":false,"double":false,"limit":false},
    {"value_diamond":"988","value":"888","in_put":false,"double":false,"limit":false},
    {"value_diamond":"1888","value":"2128","in_put":false,"double":false,"limit":false},
    {"value_diamond":"2888","value":"3288","in_put":false,"double":false,"limit":false},
  ];
  List<SPClassCoupon> coupons=[];
  SPClassCoupon ?selectCoupon;
  String spProPayType="weixin";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SPClassApiManager.spFunGetInstance().spFunShowPConfig(spProCallBack: SPClassHttpCallBack(
        spProOnSuccess: (result){
          SPClassApplicaion.spProShowPListEntity=result;
          spFunInitConfig();
        },onError: (e){},spProOnProgress: (v){}
    ));
    spFunGetUseCouponList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE1EAF7),
      padding: EdgeInsets.only(left: 466.w,right: 466.w,top: 24.w),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 84.w,vertical: 48.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('充值中心',style: TextStyle(fontSize: sp(24),fontWeight: FontWeight.w500),),
                SizedBox(width: width(76),),
                Text('当前钻石：',style: TextStyle(fontSize: sp(14),),),
                Text('0',style: TextStyle(fontSize: sp(36),fontWeight: FontWeight.w500,color: MyColors.main1),),
                Image.asset(SPClassImageUtil.spFunGetImagePath('zhuanshi'),width: width(40),),
              ],
            ),
            SizedBox(height: 24.w,),
            Text('充值选择：',style: TextStyle(fontSize: sp(14),),),
            SizedBox(height: 24.w,),
            GridView.count(
              shrinkWrap:true,
              crossAxisCount: 4,
              scrollDirection: Axis.vertical,
              childAspectRatio:width(191)/width(96),
              mainAxisSpacing:  width(20),
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: width(20),
              children: rechargeString.map((rechargeItem){
                String rmb=rechargeItem["value"];
                bool isInput=rechargeItem["in_put"];
                bool canDouble=rechargeItem["double"];
                bool limit=rechargeItem["limit"];
                return FlatButton(
                  padding: EdgeInsets.zero,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: spProSelectIndex == rechargeString.indexOf(rechargeItem)
                                    ? Color(0xFFE36649)
                                    : Color(0xFFA8A8A8),
                                width:spProSelectIndex == rechargeString.indexOf(rechargeItem)?1: 0.5)),
                        child: Row(
                          children: [
                            Expanded(
                                flex:2,
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(rechargeItem["value_diamond"].toString(),style: TextStyle(fontSize: sp(24),color: MyColors.main2,fontWeight: FontWeight.w500),),
                                    Image.asset(SPClassImageUtil.spFunGetImagePath('zhuanshi'),width: width(24),),

                                  ],)
                            ),
                            Expanded(
                              flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:rmb,
                                            style: TextStyle(
                                                fontSize: sp(18),
                                                color: MyColors.grey_66),
                                          ),
                                          TextSpan(
                                            text:'元',
                                            style: TextStyle(
                                                fontSize: sp(14),
                                                color: MyColors.grey_66),
                                          )
                                        ]
                                    ),
                                  ),
                                  rechargeItem["value_diamond"].toString()!=rmb? RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:rechargeItem["value_diamond"].toString(),
                                            style: TextStyle(
                                                fontSize: sp(18),
                                                decoration: TextDecoration.lineThrough,
                                                color: MyColors.grey_99),
                                          ),
                                          TextSpan(
                                            text:'元',
                                            style: TextStyle(
                                                fontSize: sp(14),
                                                decoration: TextDecoration.lineThrough,
                                                color: MyColors.grey_99),
                                          )
                                        ]
                                    ),
                                  ):Container(),
                            ],))
                          ],
                        ),
                      ),
                      Positioned(
                        top: -4.w,
                        left:-4.w,
                        child:limit ? Image.asset(
                          SPClassImageUtil.spFunGetImagePath("remen"),
                          width: 57.w,
                        ):SizedBox(),
                      ),
                      Positioned(
                        top: -4.w,
                        left:-4.w,
                        child: canDouble ? Image.asset(SPClassImageUtil.spFunGetImagePath('shouchong'),width: 57.w,):SizedBox(),
                      ),
                    ],
                  ),
                  onPressed: (){
                    if(mounted){
                      setState(() {
                        selectCoupon=null;
                        spProSelectIndex=rechargeString.indexOf(rechargeItem);
                      });
                    }
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 24.w,),
            Text('充值选择：',style: TextStyle(fontSize: sp(14),),),
            SizedBox(height: 24.w,),
            Row(
              children: [
                GestureDetector(
                  onTap:(){
                    spProPayType="weixin";
                    setState(() {
                    });
                  },
                  child: Container(
                    width:191.w,
                    height: 60.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: spProPayType=="weixin"?MyColors.main2:MyColors.grey_cc,width: 1),
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(SPClassImageUtil.spFunGetImagePath('ic_pay_wx'),width: 36.w,),
                        SizedBox(width: 12.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('微信支付',style: TextStyle(fontSize: sp(14)),),
                            Text('支持微信用户使用',style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20.w,),
                GestureDetector(
                  onTap:(){
                    spProPayType="alipay";
                    setState(() {
                    });
                  },
                  child: Container(
                    width:191.w,
                    height: 60.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: spProPayType=="alipay"?MyColors.main2:MyColors.grey_cc,width: 1),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(SPClassImageUtil.spFunGetImagePath('ic_pay_alipay'),width: 36.w,),
                        SizedBox(width: 12.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('支付宝',style: TextStyle(fontSize: sp(14)),),
                            Text('支持支付宝用户使用',style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Column(
                  children: [
                    Text('应支付金额：${rechargeString[spProSelectIndex]["value"]}元',style: TextStyle(fontSize: sp(20),color: MyColors.grey_66),),
                    Text('钻石只能用于消费，不能提现',style: TextStyle(fontSize: sp(12),color: MyColors.grey_99),),
                  ],
                ),
                SizedBox(width: 16.w,),
                InkWell(
                  onTap: (){
                    String ?value=rechargeString[spProSelectIndex]["value"] as String?;
                    SPClassApiManager.spFunGetInstance().spFunCreateOrder(queryParameters: {
                      "pay_type_key":spProPayType,
                      "coupon_id":selectCoupon==null? "":selectCoupon!.spProCouponId,
                      "money":selectCoupon==null? value:(SPClassStringUtils.spFunSqlitZero((double.tryParse(value!)!-double.tryParse(selectCoupon!.spPromoney!)!).toStringAsFixed(2))),
                      "is_web":'1'},
                        context:context,
                        spProCallBack: SPClassHttpCallBack(
                          spProOnSuccess: (value){
                            // if(spProPayType=="weixin"){
                            //   // launch(value.url!);
                            // }else if(spProPayType=="alipay"){
                            //   // launch(value.url!);
                            // }

                            showDialog(context: context, builder: (context){
                              return PCPayPage(value.url!);
                            });


                          },onError: (e){},spProOnProgress: (v){},
                        )
                    );
                  },
                  child: Container(
                    color: MyColors.main1,
                    width: 152.w,
                    height: 60.w,
                    alignment: Alignment.center,
                    child: Text('立即支付',style: TextStyle(color: Colors.white,fontSize: sp(20)),),
                  ),
                )
              ],
            ),
            SizedBox(height: 24.w,),
            RichText(
              text: TextSpan(text: "温馨提示:"+
                  "\n\n",style: TextStyle(fontSize: sp(18),),
                  children: [
                    TextSpan(text: "1.辉讯体育",style: TextStyle(fontSize: sp(16),)),
                    TextSpan(text: "非购彩平台",style: TextStyle(fontSize: sp(16),color: Color(0xFFDE3C31))),
                    TextSpan(text: "，充值所得钻石只可用于购买专家推荐方案，",style: TextStyle(fontSize: sp(16),)),
                    TextSpan(text: "不支持提现、购彩等操作；"+
                        "\n\n",style: TextStyle(fontSize: sp(16),color: Color(0xFFDE3C31))),
                    TextSpan(text: "2.如在充值过程或购买方案过程中遇到问题，请及时联系辉讯体育客服。",style: TextStyle(fontSize: sp(16),)),
                    TextSpan(text: ")"+
                        "\n\n",style: TextStyle(fontSize: sp(16),)),
                    TextSpan(text: "3.提示若微信支付异常，请尝试支付宝支付",style: TextStyle(fontSize: sp(16),)),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<SPClassCoupon> spFunGetUseCouponList(){
    List<SPClassCoupon> list =[];
    double? spProMoney=0.0;
    String value;
    value=rechargeString[spProSelectIndex]["value"];

    if(value!=null&&value.isNotEmpty){
      spProMoney=double.tryParse(value);
    }

    coupons.forEach((item) {
      if(spProMoney!>=double.tryParse(item.spProMinMoney!)!){
        list.add(item);
      }
    });

    return list;
  }

  void spFunInitConfig() {
    if(SPClassApplicaion.spProShowPListEntity==null){
      return;
    }
    var result=SPClassApplicaion.spProShowPListEntity;
    rechargeString.clear();
    var spProExchangeRate=double.tryParse(result!.spProExchangeRate!);
    result.spProMoneyList!.forEach((item){

      // if(double.tryParse(item)==widget.spProMoneySelect){
      //   spProSelectIndex=result.spProMoneyList.indexOf(item);
      // }
      var doubleRate=1;
      if(result.spProDoubleMoneys!.contains(item)){
        doubleRate=2;
      }
      rechargeString.add({"value_diamond":SPClassStringUtils.spFunSqlitZero(((double.tryParse(item)!*spProExchangeRate!)+(doubleRate==2?8:0)).toString()), "value":item,"in_put":false,"double":doubleRate==2?true:false,"limit":false});

    });
    result.spProPayedMoneyList!.forEach((item){
      rechargeString.forEach((map){
        if(map["double"]&&double.tryParse(item)==double.tryParse(map["value"])){
          map["value_diamond"]=(double.parse(map["value_diamond"])/2).toStringAsFixed(0);
        }
      });
    });
    result.spProMoney2Diamond!.forEach((key,value){
      rechargeString.forEach((map){
        if(double.tryParse(key.toString())==double.tryParse(map["value"])){
          map["value_diamond"]=value.toString();
          map["limit"]=true;
        }
      });
    });

    if(SPClassApplicaion.spProDEBUG){
      rechargeString.add({"value_diamond":"0","value":"0","in_put":true,"double":false,"limit":false});
    }

    setState(() {});
  }


}
