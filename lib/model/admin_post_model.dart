class AdminPostModel{
  String? post;
  String? time;

  AdminPostModel({this.post,this.time});

  factory AdminPostModel.fromMap(map){
    return AdminPostModel(
      post: map['post'],
      time: map['time'],

    );
  }

  Map<String , dynamic> toMap(){
    return {
      'post': post,
      'time': time
    };
  }

}