import 'package:web/utils/observer_interface/listener.dart';

abstract class Subject<T> {
  void addListener(Listener<T> listener);

  void deleteListener(Listener<T> listener);

  void notifyListeners(T event);
}
