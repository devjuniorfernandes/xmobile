class PaginatedResponse<T> {
  PaginatedResponse({
    required this.items,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<T> items;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  factory PaginatedResponse.fromLaravel(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) parser,
  ) {
    final rawData = json['data'];
    final list = rawData is List ? rawData : const [];
    final meta = json['meta'] is Map<String, dynamic> ? json['meta'] as Map<String, dynamic> : null;

    final currentPage = (meta?['current_page'] as num?)?.toInt() ?? (json['current_page'] as num?)?.toInt() ?? 1;
    final lastPage = (meta?['last_page'] as num?)?.toInt() ?? (json['last_page'] as num?)?.toInt() ?? 1;
    final total = (meta?['total'] as num?)?.toInt() ?? (json['total'] as num?)?.toInt() ?? list.length;

    return PaginatedResponse(
      items: list.whereType<Map<String, dynamic>>().map(parser).toList(),
      currentPage: currentPage,
      lastPage: lastPage,
      total: total,
    );
  }
}
