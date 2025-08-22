import 'package:hive_flutter/hive_flutter.dart';
import 'package:myco_flutter/core/services/cache_service.dart';
import 'package:myco_flutter/features/dashboard/data/models/attendance_type_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/home_menu_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/my_unit_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/shift_data_response.dart';
import 'package:myco_flutter/features/dashboard/data/models/shift_list.dart';
import 'package:myco_flutter/features/dashboard/data/models/wfh_data_response.dart';
import 'package:myco_flutter/features/gallery/data/models/gallery_album_response_model.dart';
import 'package:myco_flutter/features/gallery/data/models/get_gallery_new_response_model.dart';

/// A caching service implementation that uses Hive for local storage.
class HiveCacheService implements CacheService {
  /// Initializes Hive for the application and registers all necessary adapters.
  /// This should be called once in main.dart before runApp().
  static Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();
  }

  /// Centralized function to register all Hive TypeAdapters.
  static void _registerAdapters() {
    // Check if adapters are already registered to avoid errors during hot reloads.
    if (!Hive.isAdapterRegistered(HomeMenuResponseAdapter().typeId)) {
      Hive.registerAdapter(HomeMenuResponseAdapter());
    }
    if (!Hive.isAdapterRegistered(AppmenuAdapter().typeId)) {
      Hive.registerAdapter(AppmenuAdapter());
    }
    if (!Hive.isAdapterRegistered(MenuCategoryAdapter().typeId)) {
      Hive.registerAdapter(MenuCategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(SliderAdapter().typeId)) {
      Hive.registerAdapter(SliderAdapter());
    }
    if (!Hive.isAdapterRegistered(MyUnitResponseAdapter().typeId)) {
      Hive.registerAdapter(MyUnitResponseAdapter());
    }
    if (!Hive.isAdapterRegistered(EventAlbumAdapter().typeId)) {
      Hive.registerAdapter(EventAlbumAdapter());
    }
    if (!Hive.isAdapterRegistered(MemberAdapter().typeId)) {
      Hive.registerAdapter(MemberAdapter());
    }
    if (!Hive.isAdapterRegistered(MyTeamAdapter().typeId)) {
      Hive.registerAdapter(MyTeamAdapter());
    }
    if (!Hive.isAdapterRegistered(TodayBirthDayAdapter().typeId)) {
      Hive.registerAdapter(TodayBirthDayAdapter());
    }
    if (!Hive.isAdapterRegistered(UserLocationListAdapter().typeId)) {
      Hive.registerAdapter(UserLocationListAdapter());
    }
    if (!Hive.isAdapterRegistered(GeoArrayAdapter().typeId)) {
      Hive.registerAdapter(GeoArrayAdapter());
    }
    if (!Hive.isAdapterRegistered(ShiftListAdapter().typeId)) {
      Hive.registerAdapter(ShiftListAdapter());
    }
    if (!Hive.isAdapterRegistered(WFHDataResponseAdapter().typeId)) {
      Hive.registerAdapter(WFHDataResponseAdapter());
    }
    if (!Hive.isAdapterRegistered(ShiftDataResponseAdapter().typeId)) {
      Hive.registerAdapter(ShiftDataResponseAdapter());
    }
    if (!Hive.isAdapterRegistered(AttendanceTypeResponseAdapter().typeId)) {
      Hive.registerAdapter(AttendanceTypeResponseAdapter());
    }
    if (!Hive.isAdapterRegistered(AttendanceTypeAdapter().typeId)) {
      Hive.registerAdapter(AttendanceTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(MultiPunchDataAdapter().typeId)) {
      Hive.registerAdapter(MultiPunchDataAdapter());
    }
    if (!Hive.isAdapterRegistered(TakenBreaksAdapter().typeId)) {
      Hive.registerAdapter(TakenBreaksAdapter());
    }
    if (!Hive.isAdapterRegistered(Break1Adapter().typeId)) {
      Hive.registerAdapter(Break1Adapter());
    }
    if (!Hive.isAdapterRegistered(MultiPunchDataViewAdapter().typeId)) {
      Hive.registerAdapter(MultiPunchDataViewAdapter());
    }
    if (!Hive.isAdapterRegistered(BreakAdapter().typeId)) {
      Hive.registerAdapter(BreakAdapter());
    }
    if (!Hive.isAdapterRegistered(GetGalleryNewResponseModelAdapter().typeId)) {
      Hive.registerAdapter(GetGalleryNewResponseModelAdapter());
    }
    if (!Hive.isAdapterRegistered(GalleryImageAdapter().typeId)) {
      Hive.registerAdapter(GalleryImageAdapter());
    }
    if (!Hive.isAdapterRegistered(GalleryAlbumResponseModelAdapter().typeId)) {
      Hive.registerAdapter(GalleryAlbumResponseModelAdapter());
    }
    if (!Hive.isAdapterRegistered(AlbumImageAdapter().typeId)) {
      Hive.registerAdapter(AlbumImageAdapter());
    }
  }

  /// Opens a Hive box. If the box is already open, it returns the existing instance.
  Future<Box> _openBox(String boxName) async => await Hive.openBox(boxName);

  @override
  Future<T?> get<T>(String boxName, String key) async {
    final box = await _openBox(boxName);
    return box.get(key) as T?;
  }

  @override
  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await _openBox(boxName);
    await box.put(key, value);
  }

  @override
  Future<void> delete(String boxName, String key) async {
    final box = await _openBox(boxName);
    await box.delete(key);
  }
}
