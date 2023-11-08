class AppwriteConstants {
  static const String projectId = '654ae3dc800d2b5aaa84';
  static const String databaseId = '654aea149b4517177a96';
  static const String endPoint = 'http://localhost:8500/v1';

  static const String schoolCollection = '654aea2e89de6f8e03ce';

  static const String xxxBucket = '';

  static String appwriteImageUrl({
    required String bucketId,
    required String imageId,
  }) {
    return '$endPoint/storage/buckets/$bucketId/files/$imageId/view?project=$projectId&mode=admin';
  }

  static String transactionImageUrl({required String imageId}) {
    return appwriteImageUrl(bucketId: xxxBucket, imageId: imageId);
  }
}
