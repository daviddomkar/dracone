import 'dart:collection';

import 'package:dracone/dracone.dart';
import 'package:dracone/ecs.dart';

class EventDispatcher with Resource<EventDispatcher> {
  final HashMap<Type, List<Event>> _events;
  final HashMap<Type, List<Event>> _lastFrameEvents;

  EventDispatcher()
      : _events = HashMap(),
        _lastFrameEvents = HashMap();

  void dispatch(Event event) {
    if (!_events.containsKey(event.type)) {
      _lastFrameEvents[event.type] = List();
      _events[event.type] = List();
    }
    _events[event.type].add(event);
  }

  void read<E extends Event>(Function(E event) readFunction) {
    if (_lastFrameEvents.containsKey(E)) {
      _lastFrameEvents[E].forEach((event) => readFunction(event));
    }
  }

  void readCurrent<E extends Event>(Function(E event) readFunction) {
    if (_events.containsKey(E)) {
      _events[E].forEach((event) => readFunction(event));
    }
  }

  void flush() {
    _events.entries.forEach((entry) {
      _lastFrameEvents[entry.key].clear();
      _lastFrameEvents[entry.key].addAll(entry.value);
      entry.value.clear();
    });
  }
}
