class JsonVo {
  final Map<String, dynamic> result;

  JsonVo({
    required this.result,
  });

  factory JsonVo.fromJson(Map<String, dynamic> json) => JsonVo(
        result: json,
      );
}
