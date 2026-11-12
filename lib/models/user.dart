/// Model data untuk merepresentasikan Pengguna (User).
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String companyName;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.companyName,
  });

  /// Factory method untuk membuat object User dari JSON API.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Tidak ada nama',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
      // Data company pada JSONPlaceholder berbentuk nested object (object di dalam object)
      companyName: json['company'] != null ? json['company']['name'] ?? '' : '',
    );
  }
}