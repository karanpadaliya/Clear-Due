// class AdminViewRemoteDataSourceImpl extends AdminViewRemoteDataSource {
//   @override
//   Future<AdminViewResponseModel> getAdminViewNew(
//     AdminViewRequest request,
//   ) async {
//     final encryptedBody = GzipUtil.encryptAES(jsonEncode(request));
//     final response = await GetIt.I<ApiClient>(
//       instanceName: VariableBag.employeeMobileApi,
//     ).postDynamic('admin_view_controller.php', encryptedBody);
//     return AdminViewResponseModel.fromJson(
//       json.decode(GzipUtil.decryptAES(response)),
//     );
//   }
// }

import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/features/gallery/data/datasources/gallery_remote_data_source.dart';
import 'package:myco_flutter/features/gallery/data/models/gallery_album_response_model.dart';
import 'package:myco_flutter/features/gallery/data/models/gallery_request.dart';
import 'package:myco_flutter/features/gallery/data/models/get_gallery_new_response_model.dart';

class GalleryRemoteDataSourceImpl extends GalleryRemoteDataSource {
  ApiClient apiClient;

  GalleryRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Either<Failure, GalleryAlbumResponseModel>> getGalleryAlbum(
    GalleryRequest request,
  ) async {
    // This method retrieves the gallery album data from the remote server.
    // It sends a request with the provided parameters and returns the response model.
    try {
      // final requestBody = jsonEncode(request);

      dev.log(
        'Request Body: ${request.toJson()}',
        name: 'GalleryAlbumRemoteDataSourceImpl.getGalleryAlbum',
      );
      // dev.log('URl: ${VariableBag.employeeMobileApi}');

      // Using the ApiClient to post the request to the server
      // and decode the response into a GalleryAlbumResponseModel.
      // The instanceName is set to VariableBag.employeeMobileApi to specify the API endpoint.
      final response = await apiClient.postFormDynamic(
        'get_event_gallery_controller.php',
        request.toJson(),
      );

      dev.log(
        'GalleryAlbumRemoteDataSourceImpl.getGalleryAlbum: ${response.toString()}',
        name: 'GalleryAlbumRemoteDataSourceImpl',
      );

      // Decoding the JSON response
      final model = GalleryAlbumResponseModel.fromJson(json.decode(response));
      return Right(model);
    } on Exception catch (e) {
      Left(throw Exception('Failed to fetch gallery albums: $e'));
    }
  }

  @override
  Future<Either<Failure, GetGalleryNewResponseModel>> getGalleryNew(
    GalleryRequest request,
  ) async {
    try {
      // This method retrieves the new gallery data from the remote server.
      // It sends a request with the provided parameters and returns the response model.
      dev.log(
        'Request Body: ${request.toJson()}',
        name: 'GetGalleryNewRemoteDataSourceImpl.getGalleryNew',
      );

      // This method retrieves the whole gallery data from the remote server.
      // It sends a request with the provided parameters and returns the response
      final response = await apiClient.postFormDynamic(
        'get_event_gallery_controller.php',
        request.toJson(),
      );

      dev.log(
        'GetGalleryNewRemoteDataSourceImpl.getGalleryNew: ${response.toString()}',
        name: 'GetGalleryNewRemoteDataSourceImpl',
      );

      // Decoding the JSON response
      final model = GetGalleryNewResponseModel.fromJson(json.decode(response));
      return Right(model);
    } on Exception catch (e) {
      return left(throw Exception('Failed to fetch get gallery new: $e'));
    }
  }
}
