import 'package:tractian_challenge/core/http_service.dart';
import 'package:tractian_challenge/data/dto/asset_dto.dart';
import 'package:tractian_challenge/data/dto/company_asset_dto.dart';
import 'package:tractian_challenge/data/dto/company_dto.dart';
import 'package:tractian_challenge/data/dto/location_dto.dart';

class AssetRepository {
  final HttpService _client;
  AssetRepository(this._client);

  Future<List<CompanyAssetDto>> getLocations(
      {required String companyId}) async {
    try {
      final url = '/companies/$companyId/locations';
      final response = await _client.get(url);
      final result = response.data;
      return List.from(result)
          .map((e) => LocationDto.fromMap(
              (e as Map<String, dynamic>)..addAll({'type': 'location'})))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CompanyAssetDto>> getAssets({required String companyId}) async {
    try {
      final url = '/companies/$companyId/assets';
      final response = await _client.get(url);
      final result = response.data;
      return List.from(result)
          .map((e) => AssetDto.fromMap(
              (e as Map<String, dynamic>)..addAll({'type': 'asset'})))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CompanyDto>> getCompanies() async {
    try {
      const url = '/companies';
      final response = await _client.get(url);
      final result = response.data;
      return List.from(result).map((e) => CompanyDto.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
