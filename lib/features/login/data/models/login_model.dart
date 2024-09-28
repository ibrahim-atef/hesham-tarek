import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final int? id;
  final String? username;
  final String? password;
  final String? name;
  final String? phone1;
  final dynamic phone2;
  final int? government;
  final dynamic address;
  final String? schoolName;
  final int? userType;
  final String? nationalId;
  final int? balance;
  final int? status;
  final DateTime? registerDate;
  final String? imei;
  final dynamic imeiDesktop;
  final dynamic imeiDesktopOnline;
  final dynamic country;
  final dynamic studentId;
  final String? expireDate;
  final int? points;
  final int? userStatus;

  const LoginModel({
    this.id,
    this.username,
    this.password,
    this.name,
    this.phone1,
    this.phone2,
    this.government,
    this.address,
    this.schoolName,
    this.userType,
    this.nationalId,
    this.balance,
    this.status,
    this.registerDate,
    this.imei,
    this.imeiDesktop,
    this.imeiDesktopOnline,
    this.country,
    this.studentId,
    this.expireDate,
    this.points,
    this.userStatus,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json['Id'] as int?,
        username: json['Username'] as String?,
        password: json['Password'] as String?,
        name: json['Name'] as String?,
        phone1: json['Phone1'] as String?,
        phone2: json['Phone2'] as dynamic,
        government: json['Government'] as int?,
        address: json['Address'] as dynamic,
        schoolName: json['SchoolName'] as String?,
        userType: json['UserType'] as int?,
        nationalId: json['NationalId'] as String?,
        balance: json['Balance'] as int?,
        status: json['Status'] as int?,
        registerDate: json['RegisterDate'] == null
            ? null
            : DateTime.parse(json['RegisterDate'] as String),
        imei: json['IMEI'] as String?,
        imeiDesktop: json['IMEIDesktop'] as dynamic,
        imeiDesktopOnline: json['IMEIDesktopOnline'] as dynamic,
        country: json['Country'] as dynamic,
        studentId: json['StudentID'] as dynamic,
        expireDate: json['ExpireDate'] as String?,
        points: json['Points'] as int?,
        userStatus: json['UserStatus'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Username': username,
        'Password': password,
        'Name': name,
        'Phone1': phone1,
        'Phone2': phone2,
        'Government': government,
        'Address': address,
        'SchoolName': schoolName,
        'UserType': userType,
        'NationalId': nationalId,
        'Balance': balance,
        'Status': status,
        'RegisterDate': registerDate?.toIso8601String(),
        'IMEI': imei,
        'IMEIDesktop': imeiDesktop,
        'IMEIDesktopOnline': imeiDesktopOnline,
        'Country': country,
        'StudentID': studentId,
        'ExpireDate': expireDate,
        'Points': points,
        'UserStatus': userStatus,
      };

  @override
  List<Object?> get props {
    return [
      id,
      username,
      password,
      name,
      phone1,
      phone2,
      government,
      address,
      schoolName,
      userType,
      nationalId,
      balance,
      status,
      registerDate,
      imei,
      imeiDesktop,
      imeiDesktopOnline,
      country,
      studentId,
      expireDate,
      points,
      userStatus,
    ];
  }
}
