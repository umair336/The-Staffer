class ChangePasswordModel {
    final String status;

    ChangePasswordModel({
        required this.status,
    });

    ChangePasswordModel copyWith({
        String? status,
    }) => 
        ChangePasswordModel(
            status: status ?? this.status,
        );
}
