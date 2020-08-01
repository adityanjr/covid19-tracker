import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class AboutCovid extends StatefulWidget {
  static const routeName = '/info-screen';
  @override
  _AboutCovidState createState() => _AboutCovidState();
}

class _AboutCovidState extends State<AboutCovid> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  VideoPlayerController _controller2;

  @override
  void initState() {
    _controller2 = VideoPlayerController.asset("assets/videos/covid.mkv");
    _controller2.initialize().then((_) => setState(() {}));
    getData();
    super.initState();
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/info/info.txt');
  }

  String info;
  void getData() async {
    info = await loadAsset();
  }

  @override
  void dispose() {
    // _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("About COVID-19"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                action: SnackBarAction(
                    textColor: Colors.greenAccent,
                    label: 'Open Website',
                    onPressed: () => launch(
                        'https://www.who.int/emergencies/diseases/novel-coronavirus-2019')),
                content: Text(
                  'Video Source: https://www.who.int/emergencies/diseases/novel-coronavirus-2019',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'About the Virus',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.lightBlueAccent),
              textAlign: TextAlign.center,
            ),
            playVideo(_controller2),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                info ?? 'Loading...',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Container playVideo(VideoPlayerController controller) {
    return Container(
      padding: EdgeInsets.all(15),
      child: AspectRatio(
        aspectRatio: _controller2.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(controller),
            ClosedCaption(text: controller.value.caption.text),
            _PlayPauseOverlay(controller: controller),
            VideoProgressIndicator(controller, allowScrubbing: true),
          ],
        ),
      ),
    );
  }
}

class _PlayPauseOverlay extends StatefulWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  __PlayPauseOverlayState createState() => __PlayPauseOverlayState();
}

class __PlayPauseOverlayState extends State<_PlayPauseOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.value.isPlaying
                  ? widget.controller.pause()
                  : widget.controller.play();
            });
          },
        ),
      ],
    );
  }
}
