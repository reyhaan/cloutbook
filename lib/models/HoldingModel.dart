import 'package:equatable/equatable.dart';

class Holding extends Equatable {
  final String username;
  final String profilePic;
  final String publicKey;
  final double price;
  final double amount;
  final double marketValue;
  double percentShare;

  Holding({
    required this.username,
    required this.profilePic,
    required this.publicKey,
    required this.price,
    required this.amount,
    required this.marketValue,
    required this.percentShare,
  });

  List<dynamic> get props => [
        username,
        profilePic,
        publicKey,
        price,
        amount,
        marketValue,
        percentShare,
      ];

  factory Holding.fromMap(Map<String, dynamic> map) {
    return Holding(
      username: map['Username'] ?? '',
      profilePic: map['ProfilePic'] ?? '',
      publicKey: map['PublicKey'] ?? '',
      price: map['Price'] ?? 0,
      amount: map['Amount'] ?? 0,
      marketValue: map['MarketValue'] ?? 0,
      percentShare: map['PercentShare'] ?? 0,
    );
  }
}
