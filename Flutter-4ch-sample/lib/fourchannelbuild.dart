import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_4ch_sample/VideoPlayerScreen.dart';

import 'package:flutter_4ch_sample/repository/repository_service_video_state.dart';

class FourChannelBuild extends StatefulWidget {
  FourChannelBuild({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FourChannelBuildState createState() => _FourChannelBuildState();
}

class _FourChannelBuildState extends State<FourChannelBuild> {
  final _formKey = GlobalKey<FormState>();
  Future<VideoState> _videoState;

  SharedPreferences _sharedPreferencesState;

  bool _counter = true;
  int _selected_video = 0;
  double _width = 100;
  double _width_land = 100;
  double _height = 100;
  double _height_land = 100;

  double _width_1 = 0;
  double _width_2 = 0;
  double _width_3 = 0;
  double _width_4 = 0;
  double _height_1 = 0;
  double _height_2 = 0;
  double _height_3 = 0;
  double _height_4 = 0;

  double _left_1 = 0;
  double _left_2 = 0;
  double _left_3 = 0;
  double _left_4 = 0;
  double _top_1 = 0;
  double _top_2 = 0;
  double _top_3 = 0;
  double _top_4 = 0;

  bool _tap1 = true;
  bool _tap2 = true;
  bool _tap3 = true;
  bool _tap4 = true;
  bool _start = false;

  int _duration = 250;

  // nav == 1 -> Animation 미적용
  // nav == 2 -> Animation을 화면 터치로 적용
  // nav == 3 -> Animation을 버튼 터치로 조절
  // nav == 4 -> Animation을 화면과 버튼 터치 모두로 조절
  int nav = 3;

  // shar
  //  - true  일 때 sharedPreferences
  //  - false 일 때 SQFlite
  bool shar = false;

  @override
  void initState() {
    super.initState();
    _loadSelectedVideoState();
  }

  // 가로모드 상태 불러오기
  _loadSelectedVideoState() async {
    VideoState css;
    if(shar) {
      _sharedPreferencesState = await SharedPreferences.getInstance();
    } else {
      await RepositoryServiceVideoState.getVideoState().then((_videoState) {
        _selected_video = _videoState.mainScreen;
      });
    }
    setState(() {
      if(shar) {
        _selected_video = (_sharedPreferencesState.getInt('selected') ?? 0);
      }
      _selectedVideoState(_selected_video);
    });
  }

  _selectedVideoState(int videoState) {
    switch (videoState) {
      case 1:
        _tap1 = false;
        break;
      case 2:
        _tap2 = false;
        break;
      case 3:
        _tap3 = false;
        break;
      case 4:
        _tap4 = false;
        break;
      default:
        break;
    }
  }

  updatesState(int videoState) async {
    await RepositoryServiceVideoState.updateState(videoState);
    setState(() {
      _selectedVideoState(videoState);
    });
  }

//  String _video_1 = 'https://picsum.photos/250?image=9';
//  String _video_2 = 'https://picsum.photos/250?image=10';
//  String _video_3 = 'https://picsum.photos/250?image=21';
//  String _video_4 = 'https://picsum.photos/250?image=41';

  // Image data
  List<String> _video = ['https://picsum.photos/250?image=9','https://picsum.photos/250?image=10','https://picsum.photos/250?image=21','https://picsum.photos/250?image=41'];
  List<String> _videoUrl = ['https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4'];

  // 세로모드 UI
  Widget zeroVideoVertical(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-80,
      color: nav==2 ? Colors.black : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:4),
          ),
          Image.network(
            _video[0],
            width: _width,
            height: _height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top:4),
          ),
          Image.network(
            _video[1],
            width: _width,
            height: _height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top:4),
          ),
          Image.network(
            _video[2],
            width: _width,
            height: _height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top:4),
          ),
          Image.network(
            _video[3],
            width: _width,
            height: _height,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  // 가로모드 미선택 UI (행렬)
  Widget zeroVideoHorizontal_post(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:4),
              ),
              InkWell(
                onTap: () {
                  if (nav == 1) {
                    setState(() {
                      _selected_video = 1;
                    });
                  } else {
                    _selected_video = 1;
                  }
                },
                enableFeedback: false,
                child:Image.network(
                  _video[0],
                  width: _height*4,
                  height: _height_land,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:4),
              ),
              InkWell(
                onTap: () {
                  if (nav == 1) {
                    setState(() {
                      _selected_video = 2;
                    });
                  } else {
                    _selected_video = 2;
                  }
                },
                enableFeedback: false,
                child:Image.network(
                  _video[1],
                  width: _height*4,
                  height: _height_land,
                  fit: BoxFit.cover,
                ),
              ),
            ]
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:4),
              ),
              InkWell(
                onTap: () {
                  if (nav == 1) {
                    setState(() {
                      _selected_video = 3;
                    });
                  } else {
                    _selected_video = 3;
                  }
                },
                enableFeedback: false,
                child:Image.network(
                  _video[2],
                  width: _height*4,
                  height: _height_land,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:4),
              ),
              InkWell(
                onTap: () {
                  if (nav == 1) {
                    setState(() {
                      _selected_video = 4;
                    });
                  } else {
                    _selected_video = 4;
                  }
                },
                enableFeedback: false,
                child:Image.network(
                  _video[3],
                  width: _height*4,
                  height: _height_land,
                  fit: BoxFit.cover,
                ),
              ),
            ]
        )
      ],
    );
  }

  // 가로모드 선택 UI (행렬)
  Widget selectedVideo_post(BuildContext context, int selected) {

    List<String> _video_num = ['','','',''];

    if (selected == 1) {
      _video_num[0] = _video[0];
      _video_num[1] = _video[1];
      _video_num[2] = _video[2];
      _video_num[3] = _video[3];
    }
    else if (selected == 2) {
      _video_num[0] = _video[1];
      _video_num[1] = _video[0];
      _video_num[2] = _video[2];
      _video_num[3] = _video[3];
    }
    else if (selected == 3) {
      _video_num[0] = _video[2];
      _video_num[1] = _video[0];
      _video_num[2] = _video[1];
      _video_num[3] = _video[3];
    }
    else {
      _video_num[0] = _video[3];
      _video_num[1] = _video[0];
      _video_num[2] = _video[1];
      _video_num[3] = _video[2];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:4),
              ),
              InkWell(
                onTap: () {
                  if (nav == 1) {
                    setState(() {
                      _selected_video = 0;
                    });
                  } else {
                    _selected_video = 0;
                  }
                },
                enableFeedback: false,
                child:Image.network(
                  _video_num[0],
                  width: _height*6.5,
                  height: _height_land*2.06,
                  fit: BoxFit.cover,
                ),
              ),
            ]
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:4),
              ),
              InkWell(
                onTap: () {
                  if (nav == 1) {
                    setState(() {
                      _selected_video = selected == 1 ? 2 : 1;
                    });
                  } else {
                    _selected_video = selected == 1 ? 2 : 1;
                  }
                },
                enableFeedback: false,
                child:Image.network(
                  _video_num[1],
                  width: _height*2,
                  height: _height_land*2/3,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:4),
              ),
              InkWell(
                onTap: () {
                  if (nav == 1) {
                    setState(() {
                      _selected_video = selected < 3 ? 3 : 2;
                    });
                  } else {
                    _selected_video = selected < 3 ? 3 : 2;
                  }
                },
                enableFeedback: false,
                child:Image.network(
                  _video_num[2],
                  width: _height*2,
                  height: _height_land*2/3,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:4),
              ),
              InkWell(
                onTap: () {
                  if (nav == 1) {
                    setState(() {
                      _selected_video = selected == 4 ? 3 : 4;
                    });
                  } else {
                    _selected_video = selected == 4 ? 3 : 4;
                  }
                },
                enableFeedback: false,
                child:Image.network(
                  _video_num[3],
                  width: _height*2,
                  height: _height_land*2/3,
                  fit: BoxFit.cover,
                ),
              ),
            ]
        )
      ],
    );
  }

  // 가로모드 미선택 UI (Stack) // nav == 1 사용
  Widget zeroVideoHorizontal(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-80,
          color: Colors.white,
        ),
        Positioned(
          top: 10,
          left: 20,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = 1;
                });
              } else {
                _selected_video = 1;
              }
            },
            enableFeedback: false,
            child:Image.network(
              _video[0],
              width: _height*4,
              height: _height_land,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: _height_land+20,
          left: 20,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = 2;
                });
              } else {
                _selected_video = 2;
              }
            },
            enableFeedback: false,
            child:Image.network(
              _video[1],
              width: _height*4,
              height: _height_land,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: _height*4+40,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = 3;
                });
              } else {
                _selected_video = 3;
              }
            },
            enableFeedback: false,
            child:Image.network(
              _video[2],
              width: _height*4,
              height: _height_land,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: _height_land+20,
          left: _height*4+40,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = 4;
                });
              } else {
                _selected_video = 4;
              }
            },
            enableFeedback: false,
            child:Image.network(
              _video[3],
              width: _height*4,
              height: _height_land,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  // 가로모드 선택 UI (Stack) // nav == 1 사용
  Widget selectedVideo(BuildContext context, int selected) {

    List<String> _video_num = ['','','',''];

    if (selected == 1) {
      _video_num[0] = _video[0];
      _video_num[1] = _video[1];
      _video_num[2] = _video[2];
      _video_num[3] = _video[3];
    }
    else if (selected == 2) {
      _video_num[0] = _video[1];
      _video_num[1] = _video[0];
      _video_num[2] = _video[2];
      _video_num[3] = _video[3];
    }
    else if (selected == 3) {
      _video_num[0] = _video[2];
      _video_num[1] = _video[0];
      _video_num[2] = _video[1];
      _video_num[3] = _video[3];
    }
    else {
      _video_num[0] = _video[3];
      _video_num[1] = _video[0];
      _video_num[2] = _video[1];
      _video_num[3] = _video[2];
    }

    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-80,
          color: Colors.white,
        ),
        Positioned(
          top: 10,
          left: 10,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = 0;
                });
              } else {
                _selected_video = 0;
              }
            },
            enableFeedback: false,
            child:Image.network(
              _video_num[0],
              width: _height*6.35,
              height: _height_land*2.06,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: _height*6.35 + 20,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = selected == 1 ? 2 : 1;
                });
              } else {
                _selected_video = selected == 1 ? 2 : 1;
              }
            },
            enableFeedback: false,
            child:Image.network(
              _video_num[1],
              width: _height*2,
              height: _height_land*2/3,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: _height_land*2/3+14.5,
          left: _height*6.35+20,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = selected < 3 ? 3 : 2;
                });
              } else {
                _selected_video = selected < 3 ? 3 : 2;
              }
            },
            enableFeedback: false,
            child:Image.network(
              _video_num[2],
              width: _height*2,
              height: _height_land*2/3,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: _height_land*4/3+19,
          left: _height*6.35+20,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = selected == 4 ? 3 : 4;
                });
              } else {
                _selected_video = selected == 4 ? 3 : 4;
              }
            },
            enableFeedback: false,
            child:Image.network(
              _video_num[3],
              width: _height*2,
              height: _height_land*2/3,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  // 가로모드 UI (Stack & Animation)
  // nav == 2 : 화면 터치
  // nav == 3 : 버튼 터치
  Widget selectedVideoAnimate(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-80,
          color: Colors.black,
        ),
        Positioned(
          top : 10,
          left : _width_land * 2+20,
          width: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Icon(Icons.undo, color: Colors.green, size: _height_land*2/5,),
                  onTap: () {
                    if (nav == 3 || nav == 4) {
                      shar ? _sharedPreferencesState.setInt('selected', 0) : updatesState(0); // 가로모드 상태를 저장
                      setState(() {
                        _width_1 = _width_land;
                        _width_2 = _width_land;
                        _width_3 = _width_land;
                        _width_4 = _width_land;

                        _height_1 = _height_land;
                        _height_2 = _height_land;
                        _height_3 = _height_land;
                        _height_4 = _height_land;

                        _top_1 = 10;
                        _top_2 = _height_land + 20;
                        _top_3 = 10;
                        _top_4 = _height_land + 20;

                        _left_1 = 10;
                        _left_2 = 10;
                        _left_3 = _width_land + 20;
                        _left_4 = _width_land + 20;

                        _tap1 = true;
                        _tap2 = true;
                        _tap3 = true;
                        _tap4 = true;
                      });
                    }
                  },
                  enableFeedback: false,
              ),
              InkWell(
                child: Icon(Icons.looks_one, color: Colors.green, size: _height_land*2/5,),
                onTap: () {
                  if (nav == 3 || nav == 4) {
                    shar ? _sharedPreferencesState.setInt('selected', 1) : updatesState(1); // 가로모드 상태를 저장
                    setState(() {
                      _width_1 = _width_land * 3 / 2;
                      _width_2 = _width_land / 2;
                      _width_3 = _width_land / 2;
                      _width_4 = _width_land / 2;

                      _height_1 = _height_land * 2 + 10;
                      _height_2 = _height_land * 2 / 3;
                      _height_3 = _height_land * 2 / 3;
                      _height_4 = _height_land * 2 / 3;

                      _top_1 = 10;
                      _top_2 = 10;
                      _top_3 = _height_land * 2 / 3 + 15;
                      _top_4 = _height_land * 4 / 3 + 20;

                      _left_1 = 10;
                      _left_2 = _width_land * 3 / 2 + 20;
                      _left_3 = _width_land * 3 / 2 + 20;
                      _left_4 = _width_land * 3 / 2 + 20;

                      _tap1 = false;
                      _tap2 = true;
                      _tap3 = true;
                      _tap4 = true;
                    });
                  }
                },
                enableFeedback: false,
              ),
              InkWell( // 수정
                child: Icon(Icons.looks_two, color: Colors.green, size: _height_land*2/5,),
                onTap: () {
                  if (nav == 3 || nav == 4) {
                    shar ? _sharedPreferencesState.setInt('selected', 2) : updatesState(2); // 가로모드 상태를 저장
                    setState(() {
                      _width_1 = _width_land / 2;
                      _width_2 = _width_land * 3 / 2;
                      _width_3 = _width_land / 2;
                      _width_4 = _width_land / 2;

                      _height_1 = _height_land * 2 / 3;
                      _height_2 = _height_land * 2 + 10;
                      _height_3 = _height_land * 2 / 3;
                      _height_4 = _height_land * 2 / 3;

                      _top_1 = 10;
                      _top_2 = 10;
                      _top_3 = _height_land * 2 / 3 + 15;
                      _top_4 = _height_land * 4 / 3 + 20;

                      _left_1 = _width_land * 3 / 2 + 20;
                      _left_2 = 10;
                      _left_3 = _width_land * 3 / 2 + 20;
                      _left_4 = _width_land * 3 / 2 + 20;

                      _tap1 = true;
                      _tap2 = false;
                      _tap3 = true;
                      _tap4 = true;
                    });
                  }
                },
                enableFeedback: false,
              ),
              InkWell(
                child: Icon(Icons.looks_3, color: Colors.green, size: _height_land*2/5,),
                onTap: () {
                  if (nav == 3 || nav == 4) {
                    shar ? _sharedPreferencesState.setInt('selected', 3) : updatesState(3); // 가로모드 상태를 저장
                    setState(() {
                      _width_1 = _width_land / 2;
                      _width_2 = _width_land / 2;
                      _width_3 = _width_land * 3 / 2;
                      _width_4 = _width_land / 2;

                      _height_1 = _height_land * 2 / 3;
                      _height_2 = _height_land * 2 / 3;
                      _height_3 = _height_land * 2 + 10;
                      _height_4 = _height_land * 2 / 3;

                      _top_1 = 10;
                      _top_2 = _height_land * 2 / 3 + 15;
                      _top_3 = 10;
                      _top_4 = _height_land * 4 / 3 + 20;

                      _left_1 = _width_land * 3 / 2 + 20;
                      _left_2 = _width_land * 3 / 2 + 20;
                      _left_3 = 10;
                      _left_4 = _width_land * 3 / 2 + 20;

                      _tap1 = true;
                      _tap2 = true;
                      _tap3 = false;
                      _tap4 = true;
                    });
                  }
                },
                enableFeedback: false,
              ),
              InkWell(
                child: Icon(Icons.looks_4, color: Colors.green, size: _height_land*2/5,),
                onTap: () {
                  if (nav == 3 || nav == 4) {
                    shar ? _sharedPreferencesState.setInt('selected', 4) : updatesState(4); // 가로모드 상태를 저장
                    setState(() {
                      _width_1 = _width_land / 2;
                      _width_2 = _width_land / 2;
                      _width_3 = _width_land / 2;
                      _width_4 = _width_land * 3 / 2;

                      _height_1 = _height_land * 2 / 3;
                      _height_2 = _height_land * 2 / 3;
                      _height_3 = _height_land * 2 / 3;
                      _height_4 = _height_land * 2 + 10;

                      _top_1 = 10;
                      _top_2 = _height_land * 2 / 3 + 15;
                      _top_3 = _height_land * 4 / 3 + 20;
                      _top_4 = 10;

                      _left_1 = _width_land * 3 / 2 + 20;
                      _left_2 = _width_land * 3 / 2 + 20;
                      _left_3 = _width_land * 3 / 2 + 20;
                      _left_4 = 10;

                      _tap1 = true;
                      _tap2 = true;
                      _tap3 = true;
                      _tap4 = false;
                    });
                  }
                },
                enableFeedback: false,
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: _duration),
          /*******************************************************************************
           *    _start 가 false 일 때, 시작 시점에서 각 뷰의 위치를 지정                 *
           *    _tap1 ~ _tap4 모두 true 일때는 기본(4화면 균등분할)으로 시작함           *
           *    _tap 의 번호가 false 인 경우, 그 번호의 Video 화면이 메인 화면으로 지정  *
           *******************************************************************************/
          top:    _start ? _top_4    : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _height_land+20 : 10                : _height_land*4/3+20 : _height_land*4/3+20 : _height_land*4/3+20,
          left:   _start ? _left_4   : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _width_land+20  : 10                : _width_land*3/2+20  : _width_land*3/2+20  : _width_land*3/2+20,
          width:  _start ? _width_4  : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _width_land     : _width_land*3/2   : _width_land/2       : _width_land/2       : _width_land/2,
          height: _start ? _height_4 : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _height_land    : _height_land*2+10 : _height_land*2/3    : _height_land*2/3    : _height_land*2/3,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = 4;
                });
              } else if (nav == 2 || nav == 4) {
                _selected_video = _tap4 ? 4 : 0;
                shar?_sharedPreferencesState.setInt('selected', _selected_video):updatesState(_selected_video); // 가로모드 상태를 저장
                setState(() {
                  _width_1  = _tap4 ? _width_land/2       : _width_land;
                  _width_2  = _tap4 ? _width_land/2       : _width_land;
                  _width_3  = _tap4 ? _width_land/2       : _width_land;
                  _width_4  = _tap4 ? _width_land*3/2     : _width_land;

                  _height_1 = _tap4 ? _height_land*2/3    : _height_land;
                  _height_2 = _tap4 ? _height_land*2/3    : _height_land;
                  _height_3 = _tap4 ? _height_land*2/3    : _height_land;
                  _height_4 = _tap4 ? _height_land*2+10   : _height_land;

                  _top_1    = _tap4 ? 10                  : 10;
                  _top_2    = _tap4 ? _height_land*2/3+15 : _height_land+20;
                  _top_3    = _tap4 ? _height_land*4/3+20 : 10;
                  _top_4    = _tap4 ? 10                  : _height_land+20;

                  _left_1   = _tap4 ? _width_land*3/2+20  : 10;
                  _left_2   = _tap4 ? _width_land*3/2+20  : 10;
                  _left_3   = _tap4 ? _width_land*3/2+20  : _width_land+20;
                  _left_4   = _tap4 ? 10                  : _width_land+20;

                  _tap1 = true;
                  _tap2 = true;
                  _tap3 = true;
                  _tap4 = !_tap4;

                  _start = true;
                });
              } else if (nav == 3) {
              } else {
                _selected_video = 4;
              }
            },
            enableFeedback: false,
            child:VideoPlayerScreen(
              url: _videoUrl[3],
              //url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
              // joel_1
              aspectRatio:(_start ? _width_4  : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _width_land     : _width_land*3/2   : _width_land/2       : _width_land/2       : _width_land/2     )
                        / (_start ? _height_4 : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _height_land    : _height_land*2+10 : _height_land*2/3    : _height_land*2/3    : _height_land*2/3  ),
              mainScreen: !_tap4,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: _duration),
          /*******************************************************************************
           *    _start 가 false 일 때, 시작 시점에서 각 뷰의 위치를 지정                 *
           *    _tap1 ~ _tap4 모두 true 일때는 기본(4화면 균등분할)으로 시작함           *
           *    _tap 의 번호가 false 인 경우, 그 번호의 Video 화면이 메인 화면으로 지정  *
           *******************************************************************************/
          top:    _start ? _top_3    : _tap1 ? _tap2 ? _tap3 ? _tap4 ? 10             : _height_land*4/3+20 : 10                 : _height_land*2/3+15 : _height_land*2/3+15,
          left:   _start ? _left_3   : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _width_land+20 : _width_land*3/2+20  : 10                 : _width_land*3/2+20  : _width_land*3/2+20,
          width:  _start ? _width_3  : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _width_land    : _width_land/2       : _width_land*3/2    : _width_land/2       : _width_land/2,
          height: _start ? _height_3 : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _height_land   : _height_land*2/3    : _height_land*2+10  : _height_land*2/3    : _height_land*2/3,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = 3;
                });
              } else if (nav == 2 || nav == 4) {
                _selected_video = _tap3 ? 3 : 0;
                shar?_sharedPreferencesState.setInt('selected', _selected_video):updatesState(_selected_video); // 가로모드 상태를 저장
                setState(() {
                  _width_1  = _tap3 ? _width_land/2       : _width_land;
                  _width_2  = _tap3 ? _width_land/2       : _width_land;
                  _width_3  = _tap3 ? _width_land*3/2     : _width_land;
                  _width_4  = _tap3 ? _width_land/2       : _width_land;

                  _height_1 = _tap3 ? _height_land*2/3    : _height_land;
                  _height_2 = _tap3 ? _height_land*2/3    : _height_land;
                  _height_3 = _tap3 ? _height_land*2+10   : _height_land;
                  _height_4 = _tap3 ? _height_land*2/3    : _height_land;

                  _top_1    = _tap3 ? 10                  : 10;
                  _top_2    = _tap3 ? _height_land*2/3+15 : _height_land+20;
                  _top_3    = _tap3 ? 10                  : 10;
                  _top_4    = _tap3 ? _height_land*4/3+20 : _height_land+20;

                  _left_1   = _tap3 ? _width_land*3/2+20  : 10;
                  _left_2   = _tap3 ? _width_land*3/2+20  : 10;
                  _left_3   = _tap3 ? 10                  : _width_land+20;
                  _left_4   = _tap3 ? _width_land*3/2+20  : _width_land+20;

                  _tap1 = true;
                  _tap2 = true;
                  _tap3 = !_tap3;
                  _tap4 = true;

                  _start = true;
                });
              } else if (nav == 3) {
              } else {
                _selected_video = 3;
              }
            },
            enableFeedback: false,
              child:VideoPlayerScreen(
                url: _videoUrl[2],
                //url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                // joel_2

                aspectRatio:(_start ? _width_3  : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _width_land    : _width_land/2       : _width_land*3/2    : _width_land/2       : _width_land/2    )
                          / (_start ? _height_3 : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _height_land   : _height_land*2/3    : _height_land*2+10  : _height_land*2/3    : _height_land*2/3 ),
                mainScreen: !_tap3,

              ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: _duration),
          /*******************************************************************************
           *    _start 가 false 일 때, 시작 시점에서 각 뷰의 위치를 지정                 *
           *    _tap1 ~ _tap4 모두 true 일때는 기본(4화면 균등분할)으로 시작함           *
           *    _tap 의 번호가 false 인 경우, 그 번호의 Video 화면이 메인 화면으로 지정  *
           *******************************************************************************/
          top:    _start ? _top_2    : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _height_land+20 : _height_land*2/3+15 : _height_land*2/3+15 : 10                 : 10,
          left:   _start ? _left_2   : _tap1 ? _tap2 ? _tap3 ? _tap4 ? 10              : _width_land*3/2+20  : _width_land*3/2+20  : 10                 : _width_land*3/2+20,
          width:  _start ? _width_2  : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _width_land     : _width_land/2       : _width_land/2       : _width_land*3/2    : _width_land/2,
          height: _start ? _height_2 : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _height_land    : _height_land*2/3    : _height_land*2/3    : _height_land*2+10  : _height_land*2/3,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = 2;
                });
              } else if (nav == 2 || nav == 4) {
                _selected_video = _tap2 ? 2 : 0;
                shar?_sharedPreferencesState.setInt('selected', _selected_video):updatesState(_selected_video); // 가로모드 상태를 저장
                setState(() {
                  _width_1  = _tap2 ? _width_land/2       : _width_land;
                  _width_2  = _tap2 ? _width_land*3/2     : _width_land;
                  _width_3  = _tap2 ? _width_land/2       : _width_land;
                  _width_4  = _tap2 ? _width_land/2       : _width_land;

                  _height_1 = _tap2 ? _height_land*2/3    : _height_land;
                  _height_2 = _tap2 ? _height_land*2+10   : _height_land;
                  _height_3 = _tap2 ? _height_land*2/3    : _height_land;
                  _height_4 = _tap2 ? _height_land*2/3    : _height_land;

                  _top_1    = _tap2 ? 10                  : 10;
                  _top_2    = _tap2 ? 10                  : _height_land+20;
                  _top_3    = _tap2 ? _height_land*2/3+15 : 10;
                  _top_4    = _tap2 ? _height_land*4/3+20 : _height_land+20;

                  _left_1   = _tap2 ? _width_land*3/2+20  : 10;
                  _left_2   = _tap2 ? 10                  : 10;
                  _left_3   = _tap2 ? _width_land*3/2+20  : _width_land+20;
                  _left_4   = _tap2 ? _width_land*3/2+20  : _width_land+20;

                  _tap1 = true;
                  _tap2 = !_tap2;
                  _tap3 = true;
                  _tap4 = true;

                  _start = true;
                });
              } else if (nav == 3) {
              } else {
                _selected_video = 2;
              }
            },
            enableFeedback: false,
            child:VideoPlayerScreen(
              url: _videoUrl[1],
              // joel_3
              //url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',

              aspectRatio:(_start ? _width_2  : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _width_land     : _width_land/2       : _width_land/2       : _width_land*3/2    : _width_land/2    )
                        / (_start ? _height_2 : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _height_land    : _height_land*2/3    : _height_land*2/3    : _height_land*2+10  : _height_land*2/3 ),
              mainScreen: !_tap2,

            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: _duration),
          /*******************************************************************************
           *    _start 가 false 일 때, 시작 시점에서 각 뷰의 위치를 지정                 *
           *    _tap1 ~ _tap4 모두 true 일때는 기본(4화면 균등분할)으로 시작함           *
           *    _tap 의 번호가 false 인 경우, 그 번호의 Video 화면이 메인 화면으로 지정  *
           *******************************************************************************/
          top:    _start ? _top_1    : _tap1 ? _tap2 ? _tap3 ? _tap4 ? 10           : 10                 : 10                 : 10                 : 10,
          left:   _start ? _left_1   : _tap1 ? _tap2 ? _tap3 ? _tap4 ? 10           : _width_land*3/2+20 : _width_land*3/2+20 : _width_land*3/2+20 : 10,
          width:  _start ? _width_1  : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _width_land  : _width_land/2      : _width_land/2      : _width_land/2      : _width_land*3/2,
          height: _start ? _height_1 : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _height_land : _height_land*2/3   : _height_land*2/3   : _height_land*2/3   : _height_land*2+10,
          child: InkWell(
            onTap: () {
              if (nav == 1) {
                setState(() {
                  _selected_video = 1;
                });
              } else if (nav == 2 || nav == 4) {
                _selected_video = _tap1 ? 1 : 0;
                shar?_sharedPreferencesState.setInt('selected', _selected_video):updatesState(_selected_video); // 가로모드 상태를 저장
                setState(() {
                  _width_1  = _tap1 ? _width_land*3/2     : _width_land;
                  _width_2  = _tap1 ? _width_land/2       : _width_land;
                  _width_3  = _tap1 ? _width_land/2       : _width_land;
                  _width_4  = _tap1 ? _width_land/2       : _width_land;

                  _height_1 = _tap1 ? _height_land*2+10   : _height_land;
                  _height_2 = _tap1 ? _height_land*2/3    : _height_land;
                  _height_3 = _tap1 ? _height_land*2/3    : _height_land;
                  _height_4 = _tap1 ? _height_land*2/3    : _height_land;

                  _top_1    = _tap1 ? 10                  : 10;
                  _top_2    = _tap1 ? 10                  : _height_land+20;
                  _top_3    = _tap1 ? _height_land*2/3+15 : 10;
                  _top_4    = _tap1 ? _height_land*4/3+20 : _height_land+20;

                  _left_1   = _tap1 ? 10                  : 10;
                  _left_2   = _tap1 ? _width_land*3/2+20  : 10;
                  _left_3   = _tap1 ? _width_land*3/2+20  : _width_land+20;
                  _left_4   = _tap1 ? _width_land*3/2+20  : _width_land+20;

                  _tap1 = !_tap1;
                  _tap2 = true;
                  _tap3 = true;
                  _tap4 = true;

                  _start = true;
                });
              } else if (nav == 3) {
              } else {
                _selected_video = 1;
              }
            },
            enableFeedback: false,
            child:VideoPlayerScreen(
              url: _videoUrl[0],
              aspectRatio:(_start ? _width_1  : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _width_land  : _width_land/2      : _width_land/2      : _width_land/2      : _width_land*3/2   )
                        / (_start ? _height_1 : _tap1 ? _tap2 ? _tap3 ? _tap4 ? _height_land : _height_land*2/3   : _height_land*2/3   : _height_land*2/3   : _height_land*2+10 ),
              mainScreen: !_tap1,

            ),
          ),
        ),
      ],
    );
  }

  // 가로-세로 모드 체크 및 빌드
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
      body:SingleChildScrollView(
        child: OrientationBuilder(
          builder: (context, orientation) {
            print(MediaQuery.of(context).orientation);
            //print(MediaQuery.of(context).size.width.toInt().toString());
            //print(MediaQuery.of(context).size.height.toInt().toString());

            _counter = MediaQuery.of(context).orientation == Orientation.portrait ? true : false;
            _width = MediaQuery.of(context).size.width.toInt() / 1 - 30;
            _width_land = MediaQuery.of(context).size.width.toInt() / 2 - 55;
            _height = MediaQuery.of(context).size.height.toInt() / 4 - 25;
            _height_land = MediaQuery.of(context).size.height.toInt() / 2 - 60;

            if (_counter) { // 세로모드
              return Center(
                  child: zeroVideoVertical()
              );
            }
            else { // 가로모드
              if(nav > 1 && nav < 5) {
                return Center(
                  child: selectedVideoAnimate(context), // 영상 미선택
                );
              }
              else {
                if (_selected_video == 1) {
                  return selectedVideo(context, 1); // 첫번째 영상 선택
                }
                else if(_selected_video == 2) {
                  return selectedVideo(context, 2); // 두번째 영상 선택
                }
                else if(_selected_video == 3) {
                  return selectedVideo(context, 3); // 세번째 영상 선택
                }
                else if(_selected_video == 4) {
                  return selectedVideo(context, 4); // 네번째 영상 선택
                }
                else {
                  return zeroVideoHorizontal(context); // 영상 미선택
                }
              }
            }
          }, // builder
        ),
      ),
    );
  }
}