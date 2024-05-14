class Story {
  final String type;
  final String header;
  final String file;

  Story({
    required this.type,
    required this.header,
    required this.file,

  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      type: json['type'],
      header: json['header'],
      file: json['file']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'header': header,
      'file' : file,
    };
  }
}

