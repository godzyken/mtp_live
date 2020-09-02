import 'package:mtp_live/ui/models/base_model.dart';

import '../../service_locator.dart';

class BaseView<T extends Scope> extends StatefulWidget {
  final Scope _builder;
  final Function(T) onModelReady;

  BaseView({Scope builder, this.onModelReady})
      : _builder = builder;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Scope> extends State<BaseView<T>> {
  T _model = locator<T>();

  @override
  void initState() {
    if(widget.onModelReady != null) {
      widget.onModelReady(_model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
        model: _model,
        child: ScopedModelDescendant<T>(
            child: Container(color: Colors.red),
            builder: widget._builder));
  }
}