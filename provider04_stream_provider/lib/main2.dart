import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// 1) 주문 모델 클래스(어떤 type이라도 가능)
class Order {
  final String orderId;
  final double amount;

  Order({required this.orderId, required this.amount});
}

// 2) 실시간으로 주문 목록이 업데이트되는 스트림
Stream<List<Order>> orderStream() {
  return Stream.periodic(
    const Duration(seconds: 2),
    (count) => List.generate(
      count + 1,
      (i) => Order(orderId: 'order_$i', amount: (i + 1) * 10.0),
    ),
  );
}

// 3) 앱 진입점에 StreamProvider<List<Order>> 등록
void main() {
  runApp(
    StreamProvider<List<Order>>(
      create: (_) => orderStream(),
      initialData: const [],
      catchError: (_, __) => const [],
      child: const MaterialApp(home: OrderListScreen()),
    ),
  );
}

// 4) 사용처
class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<List<Order>>();

    return Scaffold(
      appBar: AppBar(title: const Text('주문 목록')),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text('주문 ID: ${order.orderId}'),
            subtitle: Text('금액: \$${order.amount}'),
          );
        },
      ),
    );
  }
}
