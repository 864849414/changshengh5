import 'package:changshengh5/model/SPClassGuessMatchInfo.dart';
import 'package:changshengh5/untils/SPClassDateUtils.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:changshengh5/untils/SPClassStringUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PCMatchItemWidget extends StatefulWidget {
  final SPClassGuessMatchInfo ?data;
  const PCMatchItemWidget({Key? key,this.data}) : super(key: key);

  @override
  _PCMatchItemWidgetState createState() => _PCMatchItemWidgetState();
}

class _PCMatchItemWidgetState extends State<PCMatchItemWidget> {
  SPClassGuessMatchInfo ?data;

  @override
  void initState() {
    data =widget.data;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 228.w,
      height: 120.w,
      padding: EdgeInsets.only(left: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: [
                      SizedBox(height: 8.sp,),
                      ( data?.status=="in_progress" ) ? Text("进行中",style: TextStyle(fontSize: 14.sp,color: Color(0xFFFB5146),),):Text(SPClassDateUtils.spFunDateFormatByString(data?.spProStTime??'', "MM-dd HH:mm"),style: TextStyle(fontSize: 14.sp,color: Color(0xFF999999),),maxLines: 1,),
                      Text("「${SPClassStringUtils.spFunMaxLength(data?.spProLeagueName??'',length: 3)}」",style: TextStyle(fontSize: 14.sp,color: Color(0xFF999999),),maxLines: 1,),
                    ],
                  ),
                ),
                Container(
                  width: 52.w,
                  height: 26.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(2),topRight: Radius.circular(2)),
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFF1DBDF2),
                            Color(0xFF1D99F2),
                          ]
                      )
                  ),
                  child: Text('${data?.spProSchemeNum}观点',style: TextStyle(color: Colors.white,fontSize:14.sp),),
                ),
              ],
            ),
            Expanded(
              child: data?.status=="not_started" ?
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              (data!.spProIconUrlOne!.isNotEmpty)? CachedNetworkImage(imageUrl: data?.spProIconUrlOne??'',width: 22.w,):
                              Image.asset(
                                SPClassImageUtil.spFunGetImagePath("ic_team_one"),
                                width: 22.sp,
                              ),
                              SizedBox(width: 9.sp),
                              Expanded(
                                child:  Text(data?.spProTeamOne??'',style: TextStyle(fontSize:16.sp,),maxLines: 1,),
                              ),
                            ],
                          ),
                          SizedBox(height: 18.sp,),
                          Row(
                            children: <Widget>[
                              (data!.spProIconUrlTwo!.isNotEmpty)? CachedNetworkImage(imageUrl: data!.spProIconUrlTwo!,width:22.w,):
                              Image.asset(
                                SPClassImageUtil.spFunGetImagePath("ic_team_two"),
                                width: 22.w,
                              ),
                              SizedBox(width: 9.sp),
                              Expanded(
                                child:  Text(data?.spProTeamTwo??'',style: TextStyle(fontSize: 16.sp,),maxLines: 1,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '未',
                    style: TextStyle(
                        fontSize: 20.sp,
                        color:
                        MyColors.grey_99),
                  ),
                  SizedBox(width: 12,)
                ],
              ):
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      (data!.spProIconUrlOne!.isNotEmpty)? CachedNetworkImage(imageUrl: data?.spProIconUrlOne??'',width: 22.w,):
                      Image.asset(
                        SPClassImageUtil.spFunGetImagePath("ic_team_one"),
                        width: 22.w,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child:  Text(data?.spProTeamOne??'',style: TextStyle(fontSize: 16.sp,),maxLines: 1,),
                      ),
                      Text(data?.status=="not_started" ?  "-":data?.spProScoreOne??'',style: TextStyle(fontSize: 14.sp,color:data?.status=="in_progress" ? Color(0xFFFB5146): Color(0xFF999999))),
                    ],
                  ),
                  SizedBox(height: 18.w,),
                  Row(
                    children: <Widget>[
                      (data!.spProIconUrlTwo!.isNotEmpty)? CachedNetworkImage(imageUrl: data?.spProIconUrlTwo??'',width: 22.w,):
                      Image.asset(
                        SPClassImageUtil.spFunGetImagePath("ic_team_two"),
                        width:22.w,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child:  Text(data?.spProTeamTwo??'',style: TextStyle(fontSize: 16.sp,),maxLines: 1,),
                      ),
                      Text(data?.status=="not_started" ?  "-":data?.spProScoreTwo??'',style: TextStyle(fontSize: 16.sp,color:data?.status=="in_progress" ? Color(0xFFFB5146): Color(0xFF999999))),
                    ],
                  ),
                ],
              ),
            )

          ],
        ),
        onTap: (){

        },
      ),
    );
  }
}
