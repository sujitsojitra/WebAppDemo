import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

import '../DrawerPage.dart';

class AudioPlayerPage extends StatefulWidget {
  @override
  _AudioPlayerPage createState() => _AudioPlayerPage();
}

class _AudioPlayerPage extends State<AudioPlayerPage>
    with WidgetsBindingObserver {
  AudioPlayer audioPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();
    WidgetsBinding.instance.addObserver(this);
    (() async {
      var baseDir = (await getApplicationDocumentsDirectory()).path +
          "/Demo/Audio/file_example_MP3_700KB.mp3";
      print(baseDir);
      var dir = File(baseDir);
      bool fileExist = await File(baseDir).exists();
      if (fileExist) {
        print(fileExist);
        Toast.show("File " + fileExist.toString(), context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        print(fileExist);
        Toast.show("File " + fileExist.toString(), context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    })();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        audioPlayer.stop();
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
  //String url = "https://www.rmp-streaming.com/media/big-buck-bunny-360p.mp4";
  bool isLoading = false;

  bool downloading = false;
  double download = 0.0;
  double downloadText = 0.0;

  var progress = "";
  String downloadingStr = "";
  var dio = Dio();
  String Profile = "";
  String email = "";
  String name = "";

  ShowDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Title of Dialog"),
              content: LinearPercentIndicator(
                lineHeight: 14.0,
                percent: download,
                center: Text(
                  downloadingStr,
                  style: new TextStyle(fontSize: 12.0),
                ),
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
                linearStrokeCap: LinearStrokeCap.butt,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showMyDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  animationDuration: 1000,
                  percent: download,
                  center: Text(downloadingStr),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Settings', textAlign: TextAlign.center),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.get_app,
              color: Colors.white,
            ),
            onPressed: () async {
              final status = await Permission.storage.status;
              if (status != PermissionStatus.granted) {
                final requestRes = await Permission.storage.request();
                ;
                if (!requestRes.isGranted) {
                  Toast.show("Please give permission from settings", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  await openAppSettings();
                  return;
                }
              }
              if (await Permission.storage.request().isGranted) {
                String baseDir = "";
                if (Platform.isAndroid) {
                  // baseDir = "/storage/emulated/0";
                  baseDir = (await getApplicationDocumentsDirectory()).path;
                } else {
                  baseDir = (await getApplicationDocumentsDirectory()).path;
                }

                String dirToBeCreated = "Demo";
                String finalDir = baseDir + "/" + dirToBeCreated;
                //download2(dio,url,);
                var dir = Directory(finalDir);
                bool dirExists = await dir.exists();
                if (!dirExists) {
                  dir.create(recursive: true)
                      // The created directory is returned as a Future.
                      .then((Directory directory) {
                    print(directory.path);
                  });
                  //dir.create(); //pass recursive as true if directory is recursive
                }
                String dirToBeCreatedDocument = "Audio";
                String finalDirDocument =
                    finalDir + "/" + dirToBeCreatedDocument;
                var dirDocument = Directory(finalDirDocument);
                bool dirExistsDocument = await dir.exists();
                if (!dirExistsDocument) {
                  dirDocument.create(recursive: true)
                      // The created directory is returned as a Future.
                      .then((Directory directory) {
                    print(directory.path);
                  });
                  //dir.create(); //pass recursive as true if directory is recursive
                }

                Dio dio = Dio();
                String fullPath = "${dirDocument.path}";
                File f = File("${dirDocument.path}");
                String fileName = url.substring(url.lastIndexOf("/") + 1);
                //DateTime now = DateTime.now();
                //String formattedDate = DateFormat('dd_MM_yyyy_kk_mm').format(now);
                download2(dio, url, fullPath + "/" + fileName, context);
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
        // LinearPercentIndicator(
        //     lineHeight: 14.0,
        //     percent: download,
        //     center: Text(
        //       downloadingStr,
        //       style: new TextStyle(fontSize: 12.0),
        //     ),
        //     backgroundColor: Colors.grey,
        //     progressColor: Colors.blue,
        //       linearStrokeCap: LinearStrokeCap.butt,
        //   ),
          Center(
            child: ElevatedButton(
                child: Text("Click To play sound"),
                onPressed: () async {
                  await audioPlayer.play(
                      "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3");
                  await audioPlayer.setReleaseMode(ReleaseMode.LOOP);
                }),
          ),
          Center(
            child: ElevatedButton(
                child: Text("Click To Pause sound"),
                onPressed: () async {
                  await audioPlayer.pause();
                }),
          ),
          Center(
            child: ElevatedButton(
                child: Text("Click To Resume sound"),
                onPressed: () async {
                  await audioPlayer.resume();
                }),
          ),
        ]
      ),
      drawer: DrawerPage(),
    );
  }

  static final Random random = Random();

  Future download2(
      Dio dio, String url, String fullPath, BuildContext context) async {
    pd = ProgressDialog(context: context);
    try {
      pd.show(max: 100, msg: 'File Downloading...');
      Response respo = await dio.get(url,
          onReceiveProgress: showDialogProgress,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));

      setState(() {
        downloading = false;
        progress = "Download Completed.";
        //path = dirloc + randid.toString() + ".jpg";
      });

      File file = File(fullPath);
      print(fullPath);
      OpenFile.open(fullPath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(respo.data);
      await raf.close();
      pd.close();
      Toast.show("Download completed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (ex) {
      setState(() {
        downloading = false;
        pd.close();
      });
      Toast.show("Download Not completed, Please try again.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      print(ex);
    }
  }
  ProgressDialog pd ;
  void showDialogProgress(int count, int total) {
    if (total != -1) {
      //ShowDialog();
      setState(() {
        downloading = true;
        int progres = (((count / total) * 100).toInt());
        pd.update(value: progres);
        progress = ((count / total) * 100).toStringAsFixed(0);
        download = (int.parse(progress) / 100);
        downloadingStr = (count / total * 100).toStringAsFixed(0) + "%";
      });
      print((count / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
