class DataUtil {
  static DateTime converteParaDataLocal(String value) {
    return (DateTime.tryParse(value) != null
        ? (value.toString().length >= 30
            ? DateTime.parse(value.toString().substring(0, value.toString().length - 6))
            : DateTime.parse(value.toString()))
        : DateTime.now());
  }
}
