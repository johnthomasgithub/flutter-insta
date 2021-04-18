import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
     final reelController =new TextEditingController();
     bool downloading = false;
       FlutterInsta flutterInsta = FlutterInsta();
void downloadReels(dwd) async {
    var s = await flutterInsta
        .downloadReels(dwd);
    print(s);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insta Reels"),
      ),
    body: Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 18),
            child: TextField(
              controller: reelController,
              decoration: InputDecoration(
                labelText: 'Reels Link',
                hintText: 'Paste Reel Link',
                labelStyle: TextStyle(color: Colors.white)
              ),
            ),
          ),     
        ),
        RaisedButton(onPressed: (){
            setState(() {
                          downloading = true;
                        });
                        download();
        },
        child: Text("Download"),),
        downloading
        ? Center(
          child: CircularProgressIndicator(),
        ):Container()
      ],
    ),
    );
  }
  void download() async {
    var myvideourl = await flutterInsta.downloadReels(reelController.text);
    final taskId = await FlutterDownloader.enqueue(
      url: '$myvideourl',
      savedDir: '/storage/emulated/0/Download/',
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    ).whenComplete(() {
      setState(() {
        downloading = false; // set to false to stop Progress indicator
      });
    });
  }
}