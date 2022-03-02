import 'package:flutter/cupertino.dart';

class PCHomePage extends StatefulWidget {
  const PCHomePage({Key? key}) : super(key: key);

  @override
  _PCHomePageState createState() => _PCHomePageState();
}

class _PCHomePageState extends State<PCHomePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('我是PC端home'),
    );
  }
}
