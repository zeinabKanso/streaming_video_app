

class MovieDataModel{
  int? id;
  String? name;
  String? preview;
  String? video_name;
  String? video_url;
  String? thumbnail;
  int? video_id;
  int? duration;

  MovieDataModel(
  {
    this.id,
    this.name,
    this.preview,
    this.video_name,
    this.video_url,
    this.thumbnail,
    this.video_id,
    this.duration
  });

  MovieDataModel.fromJson(Map<String, dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    preview=json['preview'];
    video_id=json['videoid'];
    video_name=json['videoname'];
    video_url=json['videourl'];
    thumbnail=json['thumbnail'];
    duration=json['duration'];
  }

}