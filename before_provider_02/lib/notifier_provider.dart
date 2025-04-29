import 'package:flutter/material.dart';


// 1. Notifier 정의 (본질은 Listenable 객체)
// ChangeNotifier를 상속한 클래스 정의
// ==> 상태 저장 + 알림 기능 포함
//
// *참고* Listenable이란?
// - 자신의 값의 변하면, 등록된 모든 리스너 객체(Widget뿐 아니라 일반 콜백도 포함)에 notification을 보낼 수 있다.
// - abstract class라서 implement해야 한다.
// - addListener / removeListener로 콜백을 붙일 수 있다.
class NameChangeNotifier extends ChangeNotifier {
  String _name = '이름 없음';
  String get name => _name;

  void changeName(String newName) {
    _name = newName;
    notifyListeners();
  }
}

// 2. Provider 정의 (본질은 InheritedWidget)
// - 아까 만든 ChangeNotifier(NameChangeNotifier)를 내부에 갖고 있으면서,
// - 위젯 트리 최상단에 위치하여 하위의 모든 자식들이 내부 ChangeNotifier를 참조할 수 있게 해 주는 InheritedNotifier(InheritedWidget을 상속)
// ==> 이것을 Provider라 부른다.
class NameNotifierProvider extends InheritedNotifier<NameChangeNotifier> {
  const NameNotifierProvider({
    super.key,
    required NameChangeNotifier super.notifier,   // NameChangeNotifier를 내부 notifier로 등록하는 부분
    required super.child,
  });

  // 하위 위젯에서 NameChangeProvider.of(context)를 호출하면,
  // NameChangeProvider의 내부 notifier(NameChangeNotifier) 인스턴스를 가져올 수 있다.
  //
  // NameChangeProvider.of(context) 의 의미 = (1) + (2)
  // (1) 위젯 트리에 의존성(dependency)을 등록하는 과정이다.
  //    = Provider(=가장 가까운 NameNotifierProvider)를 찾고 + 그 Provider의 Element 내부 _dependents라는 Set에 현재 context(=Element)를 등록
  // (2) Provider의 내부에 있는 notifier(=NameChangeNotifier)를 리턴함. ==> 받아서 NameChangeNotifier의 속성/메소드에 접근 가능
  static NameChangeNotifier of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<NameNotifierProvider>();
    assert(provider != null, 'No NameNotifierProvider found in context');
    return provider!.notifier!;
  }
}
