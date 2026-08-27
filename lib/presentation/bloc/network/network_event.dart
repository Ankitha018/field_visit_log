abstract class NetworkEvent {
  const NetworkEvent();
}

class NetworkStarted extends NetworkEvent {
  const NetworkStarted();
}

class NetworkChanged extends NetworkEvent {
  const NetworkChanged({
    required this.isConnected,
  });

  final bool isConnected;
}