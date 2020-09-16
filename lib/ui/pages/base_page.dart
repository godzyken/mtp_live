
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BasePage<T extends ChangeNotifier> extends StatefulWidget {

  final Widget Function(
      BuildContext context,
      T model,
      Widget child
      ) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;

  BasePage({
    Key key,
    this.builder,
    this.model,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  @override
  _BasePageState<T> createState() => _BasePageState<T>();
}

class _BasePageState<T extends ChangeNotifier> extends State<BasePage<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => model,
        child: Consumer<T>(
            builder: widget.builder,
          child: widget.child,
        ),
    );
  }
}
