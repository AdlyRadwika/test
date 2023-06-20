import 'package:practical_test/data/model/university/university.dart';
import 'package:practical_test/data/repository/university/university.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import '../../../helpers/dio_test_helper.dart';
import '../../../helpers/test_helper.mocks.dart';
import '../../dummy_data/university/mock_university.dart';

void main() {
  const String path = 'http://universities.hipolabs.com/search?country=indonesia';
  late DioAdapter mockDioAdapter;
  late MockDio mockDioClient;
  late UniversityRepository dataSource;

  setUpAll(() async {
    mockDioClient = MockDioHelper.getClient();
    mockDioAdapter = MockDioHelper.getDioAdapter(path, mockDioClient);
    when(mockDioClient.httpClientAdapter)
        .thenAnswer((_) => mockDioClient.httpClientAdapter = mockDioAdapter);
    dataSource = UniversityRepository(client: mockDioClient);
  });

  group('University Api Test (repository)', () {
    const String diffPath =  "$path&limit=10&offset=0";

    group("Get University", () {
      test('Should throw error when fetch process is failed',
          () async {
        //arrange
        final dioError = MockDioHelper.getUnknownError(path: diffPath);
        when(mockDioClient.get(diffPath)).thenThrow(dioError);

        //act
        final call = dataSource.getUniversityList();

        //assert
        expect(call, throwsException);
      });

      test(
        'Should returns a Future<List<UniversityModel>> when fetch process is success',
        () {
          //arrange
          final mockResponseData = MockUniversity.expectedResponseModel;
          final responseBody = MockDioHelper.getSuccessResponse( data: mockResponseData, path: diffPath );
          when(mockDioClient.get(diffPath)).thenAnswer((_) async => responseBody);

          //act
          final call = dataSource.getUniversityList();

          //assert
          expect(call, isA<Future<List<UniversityModel>>>());
        },
      );
    });
  });
}
