enum MyRoute {
  home("/home"),
  login("/login"),
  signup("/signup"),
  detail("/detail"),
  adminDashboard("/admin/dashboard"),
  adminOrders("/admin/orders"),
  adminAnalytics("/admin/analytics"),
  adminCatalog("/admin/catalog"),
  historyPage("/admin/history");

  const MyRoute(this.path);
  final String path;
}
