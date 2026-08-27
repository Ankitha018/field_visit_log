import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/connectivity_service.dart';
import 'network_event.dart';
import 'network_state.dart';

class NetworkBloc
    extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc({
    required ConnectivityService service,
  })  : _service = service,
        super(const NetworkInitial()) {
    on<NetworkStarted>(_onStarted);
    on<NetworkChanged>(_onChanged);
  }

  final ConnectivityService _service;

  StreamSubscription<bool>? _subscription;

  Future<void> _onStarted(
      NetworkStarted event,
      Emitter<NetworkState> emit,
      ) async {
    final connected =
    await _service.isConnected();

    _emitConnection(
      connected,
      emit,
    );

    await _subscription?.cancel();

    _subscription =
        _service.connectionStream.listen(
              (connected) {
            add(
              NetworkChanged(
                isConnected: connected,
              ),
            );
          },
        );
  }

  void _onChanged(
      NetworkChanged event,
      Emitter<NetworkState> emit,
      ) {
    _emitConnection(
      event.isConnected,
      emit,
    );
  }

  void _emitConnection(
      bool connected,
      Emitter<NetworkState> emit,
      ) {
    if (connected) {
      emit(const NetworkOnline());
    } else {
      emit(const NetworkOffline());
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}