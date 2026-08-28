import 'package:sqflite/sqflite.dart';

import '../../core/database/database_helper.dart';
import '../../core/network/connectivity_service.dart';

import '../../data/datasources/visit_local_data_source.dart';
import '../../data/datasources/visit_remote_data_source.dart';
import '../../data/mappers/visit_mapper.dart';
import '../../data/repositories/visit_repository_impl.dart';

import '../../domain/repositories/visit_repository.dart';
import '../../domain/usecases/get_visits.dart';
import '../../domain/usecases/create_visit.dart';
import '../../domain/usecases/update_visit.dart';
import '../../domain/usecases/sync_visits.dart';

import '../../presentation/bloc/network/network_bloc.dart';
import '../../presentation/bloc/visit/visit_bloc.dart';

class Injection {
  Injection._();

  static late ConnectivityService connectivityService;

  static late Database database;

  static late VisitLocalDataSource localDataSource;
  static late VisitRemoteDataSource remoteDataSource;

  static late VisitMapper visitMapper;

  static late VisitRepository visitRepository;

  static late GetVisits getVisits;
  static late CreateVisit createVisit;
  static late UpdateVisit updateVisit;
  static late SyncVisits syncVisits;

  static Future<void> initialize() async {
    // Core
    connectivityService = ConnectivityService();

    // Database
    database = await DatabaseHelper.instance.database;

    // Data sources
    localDataSource = VisitLocalDataSource(database);
    remoteDataSource = VisitRemoteDataSource();

    // Mapper
    visitMapper = const VisitMapper();

    // Repository
    visitRepository = VisitRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
      mapper: visitMapper,
    );

    // Use cases
    getVisits = GetVisits(visitRepository);

    createVisit = CreateVisit(visitRepository);

    updateVisit = UpdateVisit(visitRepository);

    syncVisits = SyncVisits(visitRepository);
  }

  static VisitBloc createVisitBloc() {
    return VisitBloc(
      getVisits: getVisits,
      createVisit: createVisit,
      updateVisit: updateVisit,
      syncVisits: syncVisits,
    );
  }

  static NetworkBloc createNetworkBloc() {
    return NetworkBloc(service: connectivityService);
  }
}
