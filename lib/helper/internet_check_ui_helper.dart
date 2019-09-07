import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

buildInternetChecking({Future<bool> internetOn, Widget body}) {
  return FutureBuilder<bool>(
    future: internetOn,
    builder: (context, snapshot) {
      if (snapshot.hasError) print(snapshot.error);
      if (snapshot.connectionState == ConnectionState.done) {
        print(snapshot.connectionState);
        if (snapshot.hasData == true) {
          if (snapshot.data == true) {
            return body;
          } else {
            return _buildNoInternet();
          }
        } else {
          return Center(
            child: Text("No Internet Connection"),
          );
        }
      } else {
        print(snapshot.connectionState);
        return Center(
          child: SpinKitRing(
            color: Colors.orangeAccent,
            size: 50.0,
          ),
        );
      }
    },
  );
}

_buildNoInternet() {
  return Container(
    alignment: Alignment.center,
    color: Colors.yellow,
    child: Container(
      height: 100.0,
      width: 500.0,
      child: Column(
        children: <Widget>[
          Text(
            "No Internet Connection",
            style: TextStyle(color: Colors.red, fontSize: 20.0),
          ),
//          RaisedButton(child: Text("Reconnect Internet"), onPressed: (){
//            setState(() {
//              _internetOn = checkInternet();
//            });
//          },),
        ],
      ),
    ),
  );
}
