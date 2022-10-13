import 'package:web/utils/observer_interface/listener.dart';
import 'package:web/utils/observer_interface/subject.dart';

class ScrollNotifier implements Subject<double> {
  final List<Listener> scrollListener = [];
  @override
  void addListener(Listener<double> listener) {
    scrollListener.add(listener);
  }

  @override
  void deleteListener(Listener<double> listener) {
    scrollListener.remove(listener);
  }

  @override
  void notifyListeners(double event) {
    for (var element in scrollListener) {
      element.update(event);
    }
  }
}
