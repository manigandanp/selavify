import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:selavify/models/dao.dart';
import 'package:selavify/services/dashboard_service.dart';

import '../resources/mock_objects.dart';

class MockTransactionDao extends Mock implements TransactionDao {}

void main() {
  test('Some basic test', () async {
    var mockTransactionDao = MockTransactionDao();

    when(mockTransactionDao.watchTransactions())
        .thenAnswer((_) => Stream.fromIterable([joinedTables]));
    var dashboardService = DashboardService(mockTransactionDao);

    var x = dashboardService.watchSummary();
    x.listen((event) {
      print(event);
    });
    
  });
}
