
enum MyRoute {
  home("/home"),
  login("/login"),
  signup("/signup"),
  detail("/detail");

  
  const MyRoute(this.path);
  final String path;
}