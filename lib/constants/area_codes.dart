/// Area code constants for phone number input
class AreaCodes {
  AreaCodes._();

  // Default area code
  static const String defaultCode = '+86';

  // Available area codes
  static const List<String> codes = [
    '+86',  // China
    '+852', // Hong Kong
    '+853', // Macau
    '+886', // Taiwan
  ];

  // Area code labels (for display)
  static const Map<String, String> codeLabels = {
    '+86': 'China (+86)',
    '+852': 'Hong Kong (+852)',
    '+853': 'Macau (+853)',
    '+886': 'Taiwan (+886)',
  };
}
