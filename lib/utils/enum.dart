
enum AyatiLogoType {
  transparent(path: "assets/images/icon_no_bg.png"),
  withBg(path: "assets/images/full_bg_icon.png");

  const AyatiLogoType({required this.path});

  final String path;
}
