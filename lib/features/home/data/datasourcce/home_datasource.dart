abstract class HomeDatasource {
  Future<void> fetchHomeData();
}


class HomeDatasourceImpl implements HomeDatasource {
  @override
  Future<void> fetchHomeData() async {
    // Simulate a network call or data fetching
    await Future.delayed(const Duration(seconds: 2));
    // You can return actual data here if needed
  }
}