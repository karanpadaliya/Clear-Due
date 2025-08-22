class WeekOffItem {
  final String title;
  final String value;

  WeekOffItem({required this.title, required this.value});

  factory WeekOffItem.fromMap(Map<String, String> map) =>
      WeekOffItem(title: map['title'] ?? '', value: map['value'] ?? '');
}
