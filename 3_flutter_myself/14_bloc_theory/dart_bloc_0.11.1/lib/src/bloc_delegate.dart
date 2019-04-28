import 'package:bloc/bloc.dart';

/// 处理来自所有[Bloc]的事件, 由[BlocSupervisor]委托。
class BlocDelegate {
  
  /// 在任何[Bloc]中使用给定[Transition]发生转换时调用。
  /// 当 新的[Event]被分发(dispatched)并且执行`mapEventToState`时 发生 转换 [Transition]。
  /// `onTransition`在[Bloc]的状态更新之前被调用。 添加通用日志记录/分析的好地方。
  void onTransition(Transition transition) => null;

  /// 无论何时在任何一个bloc中的mapEventToState 抛出 Exception，onError都会被调用。
  /// 如果状态流在没有[StackTrace]的情况下收到错误，则stacktrace参数可以是“null”。 添加通用错误处理的好地方。
  void onError(Object error, StackTrace stacktrace) => null;
}
