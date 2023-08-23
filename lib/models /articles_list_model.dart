class ArticlesListModel {
  ArticlesListModel({
    required this.value,
    required this.text,
    required this.disabled,
  });
  late final int value;
  late final String text;
  late final bool disabled;

  ArticlesListModel.fromJson(Map<String, dynamic> json){
    value = json['value'];
    text = json['text'];
    disabled = json['disabled'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['disabled'] = disabled;
    return data;
  }
}