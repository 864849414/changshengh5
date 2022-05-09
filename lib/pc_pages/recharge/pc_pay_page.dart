import 'package:changshengh5/utils/SPClassCommonMethods.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PCPayPage extends StatefulWidget {
  String url;
  PCPayPage(this.url);

  @override
  _PCPayPageState createState() => _PCPayPageState();
}

class _PCPayPageState extends State<PCPayPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            width: 484.w,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 60.w,
                      color: MyColors.main1,
                      alignment: Alignment.center,
                      child: Text('支付',style: TextStyle(color: Colors.white,fontSize: sp(24),),),
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
                SizedBox(height: width(20),),
                Text('请使用浏览器扫描下方二维码进行支付,充值完成刷新页面即可。',style: TextStyle(fontSize: sp(14)),),
                SizedBox(height: width(20),),
                Container(
                  color: Colors.white,
                  child: QrImage(
                    data: widget.url,
                    version: QrVersions.auto,
                    size: 200.w,
                  ),
                ),
                SizedBox(height: width(20),),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
