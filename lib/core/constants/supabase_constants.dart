/// A class containing constants for Supabase configuration.
library;

/// Provides project ID and endpoint URL based on the current environment
/// (production or development).
class SupabaseConstants {
  // Flag indicating production mode (consider environment variables for flexibility)
  static const bool isProductionMode = true;

  // Retrieve project ID based on production mode
  static String get projectId {
    return isProductionMode ? prodProjectId : devProjectId;
  }

  // Retrieve endpoint URL based on production mode
  static String get endPoint {
    return isProductionMode ? prodEndPoint : devEndPoint;
  }

  /* cspell:disable */
  // Private constants to hold sensitive information
  static const String devProjectId =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';
  static const String prodProjectId =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJwa2ZqYWJoZHZ3Y3F5eWh1ZnJ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU4MDgzNTUsImV4cCI6MjAyMTM4NDM1NX0.2pTI9TY3s1Gb5WXn8f86mfq0l0-Ou-mPYlKJB56A5cA';
  static const String devEndPoint = 'http://192.168.10.106:54321';
  static const String prodEndPoint = 'https://bpkfjabhdvwcqyyhufrv.supabase.co';
  /* cspell:enable */
}
