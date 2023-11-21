//全局的 EventBus
import 'package:event_bus/event_bus.dart';

class EventBusManager {
  final EventBus _eventBus = EventBus();

  EventBusManager._privateConstructor();

  static final EventBusManager _busManager =
  EventBusManager._privateConstructor();

  factory EventBusManager() {
    return _busManager;
  }

  static EventBusManager get instance {
    return _busManager;
  }

  static EventBus get eventBus {
    return _busManager._eventBus;
  }

  static void onDestroy() {
    eventBus.destroy();
  }
}