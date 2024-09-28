// ignore_for_file: non_constant_identifier_names

class User {
  late int Id;
  late String Username;
  late String Password;
  late String Name;
  late String Phone1;
  late String SchoolName;
  String? IMEI; // Nullable
  String? IMEIDesktopOnline; // Nullable

  User({
    required this.Id,
    required this.Username,
    required this.Password,
    required this.Name,
    required this.Phone1,
    required this.SchoolName,
    this.IMEI,
    this.IMEIDesktopOnline,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      Id: json['Id'] ?? 0, // Provide a default value if null
      Username:
          json['Username'] ?? '', // Provide a default empty string if null
      Password:
          json['Password'] ?? '', // Provide a default empty string if null
      Name: json['Name'] ?? '', // Provide a default empty string if null
      Phone1: json['Phone1'] ?? '', // Provide a default empty string if null
      SchoolName:
          json['SchoolName'] ?? '', // Provide a default empty string if null
      IMEI: json['IMEI'] as String?, // Nullable handling
      IMEIDesktopOnline:
          json['IMEIDesktopOnline'] as String?, // Nullable handling
    );
  }

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Username': Username,
        'Password': Password,
        'Name': Name,
        'Phone1': Phone1,
        'SchoolName': SchoolName,
        if (IMEI != null) 'IMEI': IMEI, // Include only if not null
        if (IMEIDesktopOnline != null)
          'IMEIDesktopOnline': IMEIDesktopOnline, // Include only if not null
      };
}
