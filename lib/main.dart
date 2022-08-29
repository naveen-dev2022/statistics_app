import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'app/root_binding/root_binding.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Sizer(builder: (context, orientation, deviceType) {
    // Get.put(BookmarkController(), permanent: true);
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      initialBinding: RootBinding(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }));
}
