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
    final payload = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;
    final rawData = payload['data'];
    final list = rawData is List ? rawData : const [];

    return PaginatedResponse(
      items: list.whereType<Map<String, dynamic>>().map(parser).toList(),
      currentPage: (payload['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (payload['last_page'] as num?)?.toInt() ?? 1,
      total: (payload['total'] as num?)?.toInt() ?? list.length,
    );
  }
}
