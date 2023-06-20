import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';

import 'test_helper.mocks.dart';

class MockDioHelper {
  static MockDio getClient() {
    MockDio mockDioClient = MockDio();
    return mockDioClient;
  }

  static DioAdapter getDioAdapter(String baseUrl, MockDio dio) {
    return DioAdapter(
      dio: dio,
      matcher: const FullHttpRequestMatcher(),
    );
  }

  static MockDioError getUnknownError({required String path}) {
    return MockDioError(
      requestOptions: RequestOptions(path: path),
      error: "Error!",
      type: DioExceptionType.badResponse,
    );
  }

  static Response getSuccessResponse({required String path, required Map<String, dynamic> data}) {
    return Response(
      data: data,
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
    );
  }

}
