import 'dart:developer';

import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';
import 'package:bangli_service_center_bloc/src/data/model/token_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource {
  ///Buat nyimpen token dan refresh token di local storage

  // LocalDataSource._();
  // static final LocalDataSource db = LocalDataSource._();
  static Database? _database;
  final databaseName = 'smart_city_app.db';
  final authTable = 'auth';

  Future<Database> get database async {
    if (_database != null) {
      _database = await initDB();
      return _database!;
    } else {
      _database = await initDB();
      return _database!;
    }
  }

  initDB() async {
    return await openDatabase(
      join(
        await getDatabasesPath(),
        databaseName,
      ),
      onCreate: (db, version) async {
        await db.execute("""
        CREATE TABLE $authTable 
        (
        token TEXT,
        refresh_token TEXT,
        profile_picture TEXT
        )
        """);
      },
      version: 1,
    );
  }

  Future<ReturnResponseModel> auth(String token, String refreshToken) async {
    final db = await database;
    var dbCheckToken = await db.query('auth');
    if (dbCheckToken.isEmpty) {
      await db.insert(
        authTable,
        {
          "token": token,
          "refresh_token": refreshToken,
          "profile_picture": "assets/avatar/boy.png",
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return ReturnResponseModel.success("Sukses simpan token");
    } else {
      await db.update(
        'auth',
        {
          "token": token,
          "refresh_token": refreshToken,
        },
      );
      return ReturnResponseModel.success("Sukses Update Token");
    }

    // var dbprint = await db.query('auth');
    // log("isi auth :  ${dbprint.toString()}");
  }

  Future<ReturnResponseModel> updateAccesToken(
      String accesToken, String refreshToken, String refreshTokenNew) async {
    try {
      final db = await database;
      await db.update(
        authTable,
        {
          'token': accesToken,
          'refresh_token': refreshTokenNew,
        },
        where: "refresh_token = ?",
        whereArgs: [
          refreshToken,
        ],
      );

      return ReturnResponseModel.success("Token Updated");
    } catch (e) {
      log("message error update acces token : $e");
      return ReturnResponseModel.failed(
          "Terjadi kesalahan, error catch update token : $e");
    }
  }

  Future<ReturnResponseModel<TokenModel>> getUserToken() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        authTable,
      );
      // log("mapnya : $maps");
      if (maps.isNotEmpty) {
        return ReturnResponseModel.success("Load Success",
            data: TokenModel.fromJson(maps.first));
      } else {
        return ReturnResponseModel.failed("No Data");
      }
    } catch (e) {
      log('message error sqlite : $e');
      return ReturnResponseModel.failed("No data : $e");
    }
  }

  resetSQLite() async {
    try {
      final db = await database;
      await db.rawDelete('delete from $authTable');
    } catch (e) {
      log('message error sqlite : $e');
    }
  }

  Future<Map<String, dynamic>> updatePic(String path, String token) async {
    final db = await database;
    try {
      await db.rawUpdate(
        "UPDATE $authTable SET profile_picture = ? WHERE token = ?",
        [path, token],
      );
      return {
        'status': true,
      };
    } catch (e) {
      log('error update pic : $e');
      return {
        'status': false,
      };
    }
  }

  Future updateStatusUserActive(String token) async {
    final db = await database;
    await db.rawUpdate(
      "UPDATE $authTable SET status = ? WHERE token = ?",
      [
        2,
        token,
      ],
    );
  }
}
