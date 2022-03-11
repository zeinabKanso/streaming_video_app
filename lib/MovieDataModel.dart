
class MovieDataModel{
  int? id;
  String? name;
  String? preview;
  List<Videos>? videos;


  MovieDataModel(
  {
    this.id,
    this.name,
    this.preview,
    this.videos

  });

  MovieDataModel.fromJson(Map<String, dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    preview=json['preview'];
    if(json['videos']!=null){
      videos=<Videos>[];
      (json['videos'] as List).forEach((e) {
        videos!.add(Videos.fromJson(e));
      });
    }

  }

}

class Videos{
  String? video_name;
  String? video_url;
  String? thumbnail;
  int? video_id;
  int? duration;

  Videos(
  {
    this.video_name,
    this.video_url,
    this.thumbnail,
    this.video_id,
    this.duration
  });

  Videos.fromJson(Map<String, dynamic> json){
    video_id=json['videoid'];
    video_name=json['videoname'];
    video_url=json['videourl'];
    thumbnail=json['thumbnail'];
    duration=json['duration'];
  }
}