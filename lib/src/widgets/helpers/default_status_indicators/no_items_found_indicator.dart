import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paginationflutter/src/widgets/helpers/default_status_indicators/first_page_exception_indicator.dart';

class NoItemsFoundIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const FirstPageExceptionIndicator(
        message: 'The list is currently empty.',
      );
}
