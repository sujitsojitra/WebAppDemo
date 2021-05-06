
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../DrawerPage.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _profilePage();
  }

}

class _profilePage extends State<ProfilePage>{
  File _image;

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle=Theme.of(context).textTheme.subtitle1;

    return Scaffold(
        appBar: AppBar(
          title: Center( child: Text('Settings',textAlign: TextAlign.center),),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.transparent,
              ),
            )
          ],
        ),
        drawer: DrawerPage(),
        body:
        SingleChildScrollView(
          child:
          Column(
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
              Center(
                child:  Container(
                  width: 200,
                  height: 200,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child:PhotoView(
                        imageProvider: AssetImage("assets/imgs/bg-profile.png"),
                      )
                  ),
                ),
              ),

              new Form(
                  child:

                  new Container(
                    padding: const EdgeInsets.all(20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(

                          validator: (String value){
                            if(value.isEmpty){
                              return "Please enter First Name";
                            }
                            else
                              return null;
                          },
                          style: textstyle,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              labelText: "Enter First Name",
                              labelStyle: textstyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              )
                          ),
                          keyboardType: TextInputType.name,
                          onChanged: (titleValue){

                          },
                        ),

                        new Padding(padding: const EdgeInsets.only(top:10.0)),
                        TextFormField(

                          validator: (String value){
                            if(value.isEmpty){
                              return "Please enter Last Name";
                            }
                            else
                              return null;
                          },
                          style: textstyle,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              labelText: "Enter Last Name",
                              labelStyle: textstyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              )
                          ),
                          keyboardType: TextInputType.name,
                          onChanged: (titleValue){

                          },
                        ),
                        new Padding(padding: const EdgeInsets.only(top:10.0)),
                        TextFormField(

                          validator: (String value){
                            if(value.isEmpty){
                              return "Please Enter Email";
                            }
                            else
                              return null;
                          },
                          style: textstyle,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              labelText: "Enter Email",
                              labelStyle: textstyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              )
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (titleValue){

                          },
                        ),

                        new Padding(padding: const EdgeInsets.only(top:20.0)),
                        ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: double.infinity),
                          child: MaterialButton(onPressed: ()=>{},
                            height: 40,
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                            child: new Text("Update",style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                        )

                      ],
                    ),
                  )
              )


            ],

          ),)
    );
  }
  void back() {
    Navigator.pop(context,true);
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {


                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {

                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  bool get wantKeepAlive => true;

}