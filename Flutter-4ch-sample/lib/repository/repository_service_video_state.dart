import 'package:flutter_4ch_sample/repository/database_creator.dart';


class RepositoryServiceVideoState {
  static Future<VideoState> getVideoState() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.videoStateTable} ''';
    VideoState videos;
    List<Map<String, dynamic>> data = await db.rawQuery(sql);

    if (data.length == 0) {
      addVideoState();
      data = await db.rawQuery(sql);
    }

    final video = VideoState.fromJson(data[0]);
    print ("Main Screen is ${video.mainScreen}");
    videos = video;

    return videos;
  }

  static Future<void> addVideoState() async {
    final sql = '''INSERT INTO ${DatabaseCreator.videoStateTable}
    ( ${DatabaseCreator.id}, ${DatabaseCreator.mainScreen} ) VALUES ( ${1}, ${0} )''';

    final result = await db.rawInsert(sql);
    DatabaseCreator.databaseLog('Add VideoState', sql);
  }

  static Future<void> updateState(int videoState) async {
    final sql = '''UPDATE ${DatabaseCreator.videoStateTable}
    SET ${DatabaseCreator.mainScreen} = ${videoState.toString()}
    WHERE ${DatabaseCreator.id} = 1 ''';

    final result = await db.rawUpdate(sql);
    DatabaseCreator.databaseLog('Upate VideoSate', sql);

    print ("Main Screen is ${videoState.toString()}");
  }
}



class VideoState {
  int id;
  int mainScreen;

  VideoState(this.id, this.mainScreen);

  VideoState.fromJson(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.id];
    this.mainScreen = json[DatabaseCreator.mainScreen];
  }
}