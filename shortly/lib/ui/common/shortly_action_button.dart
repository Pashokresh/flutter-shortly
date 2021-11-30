import 'package:flutter/cupertino.dart';
import 'package:shortly/ui/theme/app_extended_theme.dart';

class ShortlyActionButton extends StatefulWidget {
  ShortlyActionButton({Key? key, required this.title, required this.onTap, this.actionDone = false}) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final bool actionDone;

  @override
  _ShortlyActionButtonState createState() => _ShortlyActionButtonState();
}

class _ShortlyActionButtonState extends State<ShortlyActionButton> {
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 49,
        decoration: BoxDecoration(
            color: widget.actionDone ? AppExtendedTheme.of(context).primaryActionDone : AppExtendedTheme.of(context).primaryAction,
            borderRadius: BorderRadius.circular(4)),
        child: Center(child: Text(widget.title, style: AppExtendedTheme.of(context).buttonTextStyle)),
      ));
}
