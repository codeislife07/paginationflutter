import 'package:flutter/material.dart';
import 'package:paginationflutter/src/widgets/helpers/default_status_indicators/first_page_exception_indicator.dart';

class FirstPageErrorIndicator extends StatelessWidget {
  const FirstPageErrorIndicator({
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => FirstPageExceptionIndicator(
        message: 'The application has encountered an unknown error.\n'
            'Please try again later.',
        onTryAgain: onTryAgain,
      );
}
