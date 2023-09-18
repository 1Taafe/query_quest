class Database {
  static String get Postgresql => "PostgreSQL";
  static String get Oracle => "Oracle Database";
  static String get SqlServer => "Microsoft SQL Server";
  static String get MySql => "MySQL";
  static String get Unknown => "unknown";

  final String name;

  Database(this.name);
}