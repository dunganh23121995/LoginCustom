import 'package:dien_luc/view/public/curve_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPage();
  }
}

class _LoginPage extends State with TickerProviderStateMixin {
  AnimationController _controllerWave, _controllerLightning;
  Animation _animationWave, _animationLightning;
  Key _keyware = Key("keyware");
  bool _rememberme = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerWave = new AnimationController(vsync: this, duration: Duration(seconds: 1))..repeat(reverse: true);
    _animationWave = new Tween<double>(begin: 5.0, end: 15.0).animate(_controllerWave);

    _controllerLightning = new AnimationController(vsync: this, duration: Duration(milliseconds: 1));
    _controllerLightning.stop();
    _animationLightning = Tween<double>(begin: -1, end: 1).animate(_controllerLightning);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerWave.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              __bannerTop(),
              __bannerBottom(),
              __loginForm(),
            ],
          ),
        ),
      ),
    );
  }

  __loginForm() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 8, top: 10, bottom: 10, left: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(2, 2), blurRadius: 5.8)],
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(100.0), bottomRight: Radius.circular(100.0))),
                  child: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextFormField(
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            enabledBorder: InputBorder.none,
                            hintText: "Tài khoản",
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextFormField(
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            enabledBorder: InputBorder.none,
                            hintText: "Mật khẩu",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 2, child: Container()),
            ],
          ),
        ),
        Center(
            child: Container(
          margin: EdgeInsets.only(left: 158),
          child: RaisedButton(
            color: Colors.white,
            splashColor: Colors.white,
            highlightColor: Colors.white,
            elevation: 12,
            shape: CircleBorder(),
            onPressed: () {
              _controllerLightning.repeat(reverse: true);
              Future.delayed(Duration(milliseconds: 500)).whenComplete(() {
                _controllerLightning.stop();
                _controllerLightning.value = 1;
              });
            },
            child: AnimatedBuilder(
              animation: _animationLightning,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1)
                    ..translate(-_animationLightning.value * 2, _animationLightning.value * 2),
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/lightning" +
                            ((_animationLightning.value * 10 % 2).toInt()).toString() +
                            ".png")),
                  ),
                );
              },
            ),
          ),
        )),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 180),
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Nhớ mật khẩu"),
                  value: _rememberme,
                  onChanged: (value) {
                    print(value);
                    _rememberme = value;
                    setState(() {});
                  },
                ))),
        Center(
            child: Container(
                margin: EdgeInsets.only(top: 390),
                child: Text(
                  "Quên mật khẩu?",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.double,
                  ),
                ))),
      ],
    );
  }

  __bannerTop() {
    return Positioned(
      top: 0,
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          AnimatedBuilder(
            animation: _animationWave,
            builder: (context, child) {
              return Transform(
                transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, _animationWave.value, 1),
                child: CuverCrossAngle(
                  padding: _animationWave.value,
                  color: Colors.red,
                  gradient: [Color(0xfff11a18), Colors.orange],
                ),
              );
            },
          ),
          Image.asset("assets/images/logo.png"),
        ],
      ),
    );
  }

  __bannerBottom() {
    return Positioned(
      bottom: 0,
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: Transform.rotate(
        angle: 3.14,
        child: AnimatedBuilder(
          animation: _animationWave,
          builder: (context, child) {
            return Transform(
              transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, _animationWave.value, 1),
              child: CuverCrossAngle(
                padding: _animationWave.value,
                color: Colors.blue,
                gradient: [Color(0xff29317b), Colors.blueAccent],
              ),
            );
          },
        ),
      ),
    );
  }
}
