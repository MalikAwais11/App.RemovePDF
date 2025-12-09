class historyModel {
  int? id;
  String? toolName;
  String? date;

  String? filePath;

  String? fileSize;
  String? splitPaths;

  historyModel({
    this.id,
    this.toolName,
    this.date,
    this.filePath,
    this.fileSize,
    this.splitPaths,
  });

  historyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    toolName = json['toolName'];
    date = json['date'];
    filePath = json['filepath'];
    fileSize = json['fileSize'];
    splitPaths = json['splitPaths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['toolName'] = this.toolName;
    data['date'] = this.date;
    data['filepath'] = this.filePath;
    data['fileSize'] = this.fileSize;
    data['splitPaths'] = this.splitPaths;

    return data;
  }
}
