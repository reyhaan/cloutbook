import 'package:cloutbook/models/ProfileModel.dart';
import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final int? balanceNanos;
  final bool? canCreateProfile;
  final bool? hasPhoneNumber;
  final bool? isAdmin;
  final ProfileEntryResponse? profileEntryResponse;
  final String? publicKeyBase58Check;
  final List<String>? publicKeysBase58CheckFollowedByUser;
  final int? unminedBalanceNanos;
  final List<HODLer>? usersWhoHODLYou;
  final List<HODLer>? usersYouHODL;

  Wallet({
    this.balanceNanos,
    this.canCreateProfile,
    this.hasPhoneNumber,
    this.isAdmin,
    this.profileEntryResponse,
    this.publicKeyBase58Check,
    this.publicKeysBase58CheckFollowedByUser,
    this.unminedBalanceNanos,
    this.usersWhoHODLYou,
    this.usersYouHODL,
  });

  List<dynamic> get props => [
        balanceNanos,
        canCreateProfile,
        hasPhoneNumber,
        isAdmin,
        profileEntryResponse,
        publicKeyBase58Check,
        publicKeysBase58CheckFollowedByUser,
        unminedBalanceNanos,
        usersWhoHODLYou,
        usersYouHODL,
      ];

  factory Wallet.fromMap(Map<String, dynamic> map) {
    List<String> follows = [];
    List<HODLer> usersWhoHODLYou = [];
    List<HODLer> usersYouHODL = [];

    if (map['PublicKeysBase58CheckFollowedByUser'] != null) {
      List<dynamic> _follows = map['PublicKeysBase58CheckFollowedByUser'];
      _follows.forEach((publicKey) {
        follows.add(publicKey);
      });
    }

    if (map['UsersWhoHODLYou'] != null) {
      List<dynamic> _usersWhoHODLYou = map['UsersWhoHODLYou'];
      _usersWhoHODLYou.forEach((hodler) {
        usersWhoHODLYou.add((HODLer.fromMap(hodler)));
      });
    }

    if (map['UsersYouHODL'] != null) {
      List<dynamic> _usersYouHODL = map['UsersYouHODL'];
      _usersYouHODL.forEach((hodler) {
        usersYouHODL.add((HODLer.fromMap(hodler)));
      });
    }

    return Wallet(
      balanceNanos: map['BalanceNanos'],
      canCreateProfile: map['CanCreateProfile'] ?? null,
      hasPhoneNumber: map['HasPhoneNumber'] ?? null,
      isAdmin: map['IsAdmin'] ?? null,
      profileEntryResponse: ProfileEntryResponse.fromMap(
          map['ProfileEntryResponse'].cast<String, dynamic>() ?? {}),
      publicKeyBase58Check: map['PublicKeyBase58Check'],
      publicKeysBase58CheckFollowedByUser: follows,
      unminedBalanceNanos: map['UnminedBalanceNanos'],
      usersWhoHODLYou: usersWhoHODLYou,
      usersYouHODL: usersYouHODL,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "BalanceNanos": this.balanceNanos,
      "CanCreateProfile": this.canCreateProfile,
      "HasPhoneNumber": this.hasPhoneNumber,
      "IsAdmin": this.isAdmin,
      "ProfileEntryResponse": this.profileEntryResponse,
      "PublicKeyBase58Check": this.publicKeyBase58Check,
      "PublicKeysBase58CheckFollowedByUser":
          this.publicKeysBase58CheckFollowedByUser,
      "UnminedBalanceNanos": this.unminedBalanceNanos,
      "UsersWhoHODLYou": this.usersWhoHODLYou,
      "UsersYouHODL": this.usersYouHODL,
    };
  }
}

class HODLer extends Equatable {
  final int? balanceNanos;
  final String? creatorPublicKeyBase58Check;
  final String? hodlerPublicKeyBase58Check;
  final int? netBalanceInMempool;
  final ProfileEntryResponse? profileEntryResponse;

  HODLer({
    this.balanceNanos,
    this.creatorPublicKeyBase58Check,
    this.hodlerPublicKeyBase58Check,
    this.netBalanceInMempool,
    this.profileEntryResponse,
  });

  List<dynamic> get props => [
        balanceNanos,
        creatorPublicKeyBase58Check,
        hodlerPublicKeyBase58Check,
        netBalanceInMempool,
        profileEntryResponse,
      ];

  factory HODLer.fromMap(Map<String, dynamic> map) {
    ProfileEntryResponse? _profileEntryResponse =
        ProfileEntryResponse(posts: []);

    if (map['ProfileEntryResponse'] != null) {
      _profileEntryResponse =
          ProfileEntryResponse.fromMap(map['ProfileEntryResponse']);
    }

    return HODLer(
      balanceNanos: map['BalanceNanos'],
      creatorPublicKeyBase58Check: map['CreatorPublicKeyBase58Check'],
      hodlerPublicKeyBase58Check: map['HODLerPublicKeyBase58Check'],
      netBalanceInMempool: map['NetBalanceInMempool'],
      profileEntryResponse: _profileEntryResponse,
    );
  }

  Map<String, dynamic> toJson() => {
        "BalanceNanos": this.balanceNanos,
        "CreatorPublicKeyBase58Check": this.creatorPublicKeyBase58Check,
        "HODLerPublicKeyBase58Check": this.hodlerPublicKeyBase58Check,
        "NetBalanceInMempool": this.netBalanceInMempool,
        "ProfileEntryResponse": this.profileEntryResponse?.toJson(),
      };
}
