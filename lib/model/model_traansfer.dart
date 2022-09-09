class TransferList{
  final String keys;
  final int id;
  final String wallet_from;
  final String wallet_to;
  final String fio;
  final int amount;
  final String title;
  final String type;
  final String comment;
  final String status;
  final String date;
  final int timestamp;
  TransferList({
    required this.keys,
    required this.id,
    required this.wallet_from,
    required this.wallet_to,
    required this.fio,
    required this.amount,
    required this.title,
    required this.type,
    required this.comment,
    required this.status,
    required this.date,
    required this.timestamp,
  });
}