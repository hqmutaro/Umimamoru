import 'package:flutter/cupertino.dart';
import 'package:umimamoru/application/bloc/bloc_base.dart';

class BlocProvider<T extends BlocBase> extends StatefulWidget {

  final T bloc;
  final Widget child;

  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) :
      assert(child != null),
      assert(bloc != null),
      super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() async{
    // await widget.bloc.dispose(); 使わん
    super.dispose();
  }
}