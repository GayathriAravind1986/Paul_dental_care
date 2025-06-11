class Testimonial {
  final int id;
  final String name;
  final int rating;
  final String review;
  final int status;
  final String? createdAt;
  final String? updatedAt;

  Testimonial({
    required this.id,
    required this.name,
    required this.rating,
    required this.review,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      id: json['id'],
      name: json['name'],
      rating: json['rating'],
      review: json['review'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
