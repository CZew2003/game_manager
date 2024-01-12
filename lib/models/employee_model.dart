class EmployeeModel {
  EmployeeModel(
      {required this.name,
      required this.username,
      required this.salary,
      required this.hoursMonthly,
      required this.expirationDate});

  final String name;
  final String username;
  final String salary;
  final int hoursMonthly;
  final String expirationDate;

  static List<Map<String, dynamic>> titles = <Map<String, dynamic>>[
    <String, dynamic>{
      'field': 'Name',
      'numeric': false,
    },
    <String, dynamic>{
      'field': 'Username',
      'numeric': false,
    },
    <String, dynamic>{
      'field': 'Salary',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Hours Monthly',
      'numeric': true,
    },
    <String, dynamic>{
      'field': 'Expiration Date',
      'numeric': true,
    },
  ];

  EmployeeModel copyWith({
    String? name,
    String? username,
    String? salary,
    int? hoursMonthly,
    String? expirationDate,
  }) {
    return EmployeeModel(
      name: name ?? this.name,
      username: username ?? this.username,
      salary: salary ?? this.salary,
      hoursMonthly: hoursMonthly ?? this.hoursMonthly,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }
}
