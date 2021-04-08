extension ImageExtension on String {
  String get svg => "assets/images/svg/$this.svg";
  String get png => "assets/images/$this.png";
  String get jpg => "assets/images/$this.jpg";
  String get jpeg => "assets/images/jpeg/$this.jpeg";
}
