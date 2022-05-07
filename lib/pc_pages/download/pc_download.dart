import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PCDownload extends StatefulWidget {
  const PCDownload({Key? key}) : super(key: key);

  @override
  _PCDownloadState createState() => _PCDownloadState();
}

class _PCDownloadState extends State<PCDownload> {
  bool isIos =false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 466.w,right: 466.w,),
        color: Color(0xFFE1EAF7),
        child: Stack(
          children: [
            Image.asset(
              SPClassImageUtil.spFunGetImagePath('bg'),
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
                top: 220.w,
                left: 200.w,
                child: qrImageWidget()
            )
          ],
        ),
      ),
    );
  }

  Widget qrImageWidget(){
    // String appid ='wx55c3416a14860147';
    // String redirect_uri= Uri.encodeComponent("https://api.gz583.com/hongsheng/");
    // final url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=${appid}&redirect_uri=${redirect_uri}&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect';

    return Row(
      children: [
        Container(
          color: Colors.white,
          child: QrImage(
            data: isIos?"https://www.pgyer.com/DKBk":"https://www.pgyer.com/9dgA",
            // data: url,
            version: QrVersions.auto,
            size: 100.w,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.w,),
          height: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  isIos=false;
                  setState(() {

                  });
                },
                child: Image.asset(
                  SPClassImageUtil.spFunGetImagePath(isIos?'android_download':'android_download_selected'),
                  width: 150.w,
                ),
              ),
              GestureDetector(
                onTap: (){
                  isIos=true;
                  setState(() {

                  });
                },
                child: Image.asset(
                  SPClassImageUtil.spFunGetImagePath(isIos?'ios_download_selected':'ios_download'),
                  width: 150.w,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

}
