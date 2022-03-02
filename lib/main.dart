import 'dart:convert';

import 'package:changshengh5/pages/competition/SPClassMatchListSettingPage.dart';
import 'package:changshengh5/splash_screen.dart';
import 'package:changshengh5/untils/LocalStorage.dart';
import 'package:changshengh5/untils/SPClassSharedPreferencesKeys.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/SPClassApplicaion.dart';
import 'model/SPClassLogInfoEntity.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();

}


class MyAppState extends State<MyApp> {
  int spProThemeColor = 0xFF1B8DE0;
  var spProPopTimer= DateTime.now();

  @override
  void initState() {
    spFunInitUserData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: SPClassApplicaion.spProAppName,
        theme: ThemeData(
          fontFamily: '',
          brightness: Brightness.light,
          primaryColor: Color(spProThemeColor),
          backgroundColor: Colors.white,
          unselectedWidgetColor: Colors.white70,
          accentColor: Color(0xFF888888),
          // textTheme: GoogleFonts.notoSansSCTextTheme(),
          iconTheme: IconThemeData(
            color: Color(spProThemeColor),
            size: 35.0,
          ),
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
        home: WillPopScope(
          child:  Scaffold(body:SplashScreen()),
          onWillPop: () async{
            if(DateTime.now().difference(spProPopTimer).inSeconds>3){
              SPClassToastUtils.spFunShowToast(msg: "再按一次退出");
            }else{
              return true;
            }
            spProPopTimer=DateTime.now();
            return false;
          },
        )
    );
  }


  Future<void> spFunInitUserData() async {
    await  SharedPreferences.getInstance().then((sp) {
      SPClassApplicaion.spProDEBUG=sp.getBool("test")??SPClassApplicaion.spProDEBUG;
      SPClassMatchListSettingPageState.SHOW_PANKOU=sp.getBool(SPClassSharedPreferencesKeys.KEY_MATCH_PAN_KOU)??SPClassMatchListSettingPageState.SHOW_PANKOU;
      var logInfoJson=sp.getString(SPClassSharedPreferencesKeys.KEY_LOG_JSON);
      if(logInfoJson!=null){
        var jsonData=json.decode(logInfoJson);
        SPClassApplicaion.spProLogOpenInfo= SPClassLogInfoEntity.fromJson(jsonData);
      }
    } );
    await SPClassApplicaion.spFunInitUserState();
    ///有欠缺
    ///
    return null;
  }

}
