import 'dart:convert';

import 'package:changshengh5/utils/SPClassImageUtil.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PCHomeFilterMatchDialog extends StatefulWidget {
  String spProMatchType;
  ValueChanged<String> callback;
  PCHomeFilterMatchDialog( this.spProMatchType,this.callback,);

  @override
  _PCHomeFilterMatchDialogState createState() => _PCHomeFilterMatchDialogState();
}

class _PCHomeFilterMatchDialogState extends State<PCHomeFilterMatchDialog> {
  static var football = ["竞彩", "让球", "大小"];
  static var spProFootballSelects = [true, true, true];
  static var spProFootballValue = ["让球胜平负,胜平负", "让球胜负", "大小球"];

  static var basketball = ["让分", "大小"];
  static var spProBasketballSelects = [true, true];
  static var spProBasketballValue = ["让分胜负", "大小分"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: (widget.spProMatchType == "足球"?football:basketball).map((e) {
            int index =(widget.spProMatchType == "足球"?football:basketball).indexOf(e);
            return Container(
              margin: EdgeInsets.only(top: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap:(){
                      (widget.spProMatchType == "足球"?spProFootballSelects:spProBasketballSelects)[index]=!(widget.spProMatchType == "足球"?spProFootballSelects:spProBasketballSelects)[index];
                      setState(() {

                      });
                    },
                    child:Image.asset(
                      SPClassImageUtil.spFunGetImagePath((widget.spProMatchType == "足球"?spProFootballSelects:spProBasketballSelects)[index]?'ic_select':'ic_seleect_un'),
                      width: 16.w,) ,
                  ),
                  SizedBox(width: 16.w,),
                  Text(e,style: TextStyle(color: MyColors.grey_33,fontSize: 18.sp),)
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 30.w,),
        Row(
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                color:Color(0xFFF5F6F7),
                child: Text('取消',style: TextStyle(color: Color(0xFFCCCCCC),fontSize: 16.sp),),
                width: 64.w,
                height: 32.w,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(width: 12.w,),
            InkWell(
              onTap: (){
                var playWay = [];
                if (widget.spProMatchType == "足球") {
                  for (var i = 0;
                  i < spProFootballSelects.length;
                  i++) {
                    if (spProFootballSelects[i]) {
                      playWay.add(spProFootballValue[i]);
                    }
                  }
                } else {
                  for (var i = 0;
                  i < spProBasketballSelects.length;
                  i++) {
                    if (spProBasketballSelects[i]) {
                      playWay.add(spProBasketballValue[i]);
                    }
                  }
                }
                var result = JsonEncoder()
                    .convert(playWay)
                    .replaceAll("[", "")
                    .replaceAll("]", "")
                    .replaceAll(",", ";")
                    .replaceAll("\"", "");
                widget.callback(result);
                Navigator.of(context).pop();
              },
              child: Container(
                color:MyColors.main1,
                child: Text('确认',style: TextStyle(color: Colors.white,fontSize: 16.sp),),
                width: 64.w,
                height: 32.w,
                alignment: Alignment.center,
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ],
    );
  }
}
