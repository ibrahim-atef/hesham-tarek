// ignore_for_file: non_constant_identifier_names

class NewUser {
  late int Id;
  late String Username;
  late String Password;
  late String Name;
  late String Phone1;
  late String SchoolName;
  String? IMEI;
  String? IMEIDesktopOnline;

  NewUser(
      {required this.Id,
      required this.Username,
      required this.Password,
      required this.Name,
      required this.Phone1,
      required this.IMEI,
      required this.IMEIDesktopOnline,
      required this.SchoolName});

  factory NewUser.fromJson(Map<String, dynamic> json) {
    return NewUser(
      Id: json['Id'],
      Username: json['Username'],
      Password: json['Password'],
      Name: json['Name'],
      Phone1: json['Phone1'],
      SchoolName: json['SchoolName'],
      IMEI: json['IMEI'],
      IMEIDesktopOnline: json['IMEIDesktopOnline'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Username': Name,
        'Password': Password,
        'Name': Name,
        'Phone1': Phone1,
        'Phone2': "",
        'StudentID': "",
        'Country': "",
        'Government': 0,
        'Address': "",
        'SchoolName': SchoolName,
        'UserType': 0,
        'NationalId': "",
        'Balance': 0,
        'Status': 0,
        'ExpireDate': "2040-01-01",
        'IMEI': IMEI,
      };
}
