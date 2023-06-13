import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoes_shop_app/controller/loading_controller.dart';

class LoadingBuilder extends StatelessWidget {
  const LoadingBuilder({
    super.key,
    required this.loadingController,
  });

  final LoadingController loadingController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingController>(
      builder: (_) => loadingController.getLoadingState() ? Container(
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
            child: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.red,
                size: 48,
              ),
            ),
          )
        : Container()
    );
  }
}
