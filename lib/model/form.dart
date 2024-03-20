class FeedbackForm {
  String rating;
  String fio;
  String count;

  FeedbackForm(this.rating, this.fio, this.count);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
      '${json['rating']}',
      '${json['fio']}',
      '${json['count']}',
    );
  }

  Map toJson() => {'rating': rating, 'fio': fio, 'count': count};
}
