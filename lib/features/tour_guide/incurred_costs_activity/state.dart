class IncurredCostsActivityState {
  final String? id;
  final DateTime dateTime;
  final bool isLoading;
  final List<String> imagePaths;
  final String? activityId;
  final double amount;
  final String note;
  final bool isAmountValid;
  final bool isNoteValid;
  final String? preImagePath; // image path before edit

  static const int maxNoteLength = 100;
  static const int maxAmountLength = 15;

  IncurredCostsActivityState({
    required this.id,
    required this.dateTime,
    required this.isLoading,
    required this.imagePaths,
    required this.activityId,
    required this.amount,
    required this.note,
    required this.isAmountValid,
    required this.isNoteValid,
    required this.preImagePath,
  });

  factory IncurredCostsActivityState.initial() => IncurredCostsActivityState(
        id: null,
        dateTime: DateTime.now(),
        isLoading: false,
        imagePaths: [],
        activityId: null,
        amount: 0,
        note: '',
        isAmountValid: false,
        isNoteValid: false,
        preImagePath: null,
      );

  IncurredCostsActivityState copyWith({
    String? id,
    DateTime? dateTime,
    bool? isValid,
    bool? isLoading,
    List<String>? imagePaths,
    String? activityId,
    double? amount,
    String? note,
    bool? isAmountValid,
    bool? isNoteValid,
    String? preImagePath,
  }) =>
      IncurredCostsActivityState(
        id: id ?? this.id,
        dateTime: dateTime ?? this.dateTime,
        isLoading: isLoading ?? this.isLoading,
        imagePaths: imagePaths ?? this.imagePaths,
        activityId: activityId ?? this.activityId,
        amount: amount ?? this.amount,
        note: note ?? this.note,
        isAmountValid: isAmountValid ?? this.isAmountValid,
        isNoteValid: isNoteValid ?? this.isNoteValid,
        preImagePath: preImagePath ?? this.preImagePath,
      );
}
