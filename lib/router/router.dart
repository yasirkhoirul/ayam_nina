enum MyRoute {
  home("/home"),
  login("/login"),
  signup("/signup"),
  detail("/detail"),
  adminCatalog("/admin/catalog");

  const MyRoute(this.path);
  final String path;
}
