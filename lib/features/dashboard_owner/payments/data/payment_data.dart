import 'package:digital_product/features/dashboard_owner/payments/data/models/customer_payment_model.dart';
import 'package:digital_product/features/dashboard_owner/payments/data/models/payment_transaction_model.dart';

const List<CustomerPaymentModel> customerPayments = [
  CustomerPaymentModel(
    name: 'سارة العتيبي',
    email: 'sara@platform.sa',
    totalPaid: 420,
    paidOrdersCount: 3,
  ),
  CustomerPaymentModel(
    name: 'منى الشهري',
    email: 'mona@platform.sa',
    totalPaid: 300,
    paidOrdersCount: 2,
  ),
  CustomerPaymentModel(
    name: 'أحمد الزهراني',
    email: 'ahmed@platform.sa',
    totalPaid: 250,
    paidOrdersCount: 2,
  ),
];

const List<PaymentTransactionModel> recentPayments = [
  PaymentTransactionModel(
    customerName: 'سارة العتيبي',
    serviceName: 'عروض PowerPoint',
    orderNumber: '#1041',
    amount: 120,
    date: '21 أغسطس',
  ),
  PaymentTransactionModel(
    customerName: 'منى الشهري',
    serviceName: 'كتابة تقرير',
    orderNumber: '#1062',
    amount: 150,
    date: '25 أغسطس',
  ),
  PaymentTransactionModel(
    customerName: 'أحمد الزهراني',
    serviceName: 'التدقيق اللغوي',
    orderNumber: '#1038',
    amount: 80,
    date: '18 أغسطس',
  ),
];

const List<PaymentTransactionModel> pendingPayments = [
  PaymentTransactionModel(
    customerName: 'خالد المطيري',
    serviceName: 'تلخيص الأبحاث',
    orderNumber: '#1070',
    amount: 180,
    date: 'بانتظار الدفع',
    isPending: true,
  ),
];

const int totalPaid = 4830;
