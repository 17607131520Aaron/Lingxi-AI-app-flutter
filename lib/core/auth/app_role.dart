enum AppRole {
  normalUser('normal_user', '普通用户'),
  warehouseKeeper('warehouse_keeper', '库管'),
  engineer('engineer', '工程师');

  const AppRole(this.value, this.label);

  final String value;
  final String label;

  static AppRole fromValue(String? value) {
    for (final role in AppRole.values) {
      if (role.value == value) {
        return role;
      }
    }
    return AppRole.normalUser;
  }
}
