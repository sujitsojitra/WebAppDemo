

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, OK,Cancle;
  final Image img;
  final Function onPress;
  const CustomDialogBox({Key key, this.title, this.descriptions,
    this.OK,this.Cancle, this.img,this.onPress}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool authenticated = false;
  Future<void> _authenticate() async {

    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'For open application authentication required',
          useErrorDialogs: true,
          stickyAuth: true);

    } on PlatformException catch (e) {
      print(e);
      return;
    }
    if (!mounted) return;
    setState(() {
      authenticated= authenticated ? true :false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black,
                    blurRadius: 100
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: Icon(Icons.lock),),
              SizedBox(height: 15,),
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomRight,
                child:
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                          setState(() {
                            authenticated=false;
                          });
                          //exit(0);
                        },
                        child: Text(widget.Cancle,style: TextStyle(fontSize: 16),)),
                    TextButton(
                        onPressed:(){
                          _authenticate();
                          Navigator.of(context).pop();
                        },
                        child: Text(widget.OK,style: TextStyle(fontSize: 16),)),
                  ],
                )
              ),
            ],
          ),
        ),
        // Positioned(
        //   left: 15,
        //   right: 15,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.transparent,
        //     radius: 45,
        //     child: ClipRRect(
        //         borderRadius: BorderRadius.all(Radius.circular(45)),
        //         child: Image.asset("assets/imgs/jasminprofile.jpg")
        //     ),
        //   ),
        // ),
      ],
    );
  }
}