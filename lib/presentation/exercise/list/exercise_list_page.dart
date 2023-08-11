import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalproject/core/styles.dart';
import 'package:finalproject/core/values/colors.dart';
import 'package:finalproject/presentation/exercise/list/exercise_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../data/model/exercise_list_response.dart';
import '../../../routes/routes.dart';

/// Arguments untuk dibawa saat pindah/navigate ke halaman ExerciseListPage
class ExerciseListPageArgs {
  final String courseId;
  final String courseName;

  const ExerciseListPageArgs({
    required this.courseId,
    required this.courseName,
  });
}

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({Key? key}) : super(key: key);

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  @override
  void initState() {
    super.initState();
    // Call API
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseListController>(
      builder: (ExerciseListController controller) {
        List<ExerciseListData> exercises = controller.exerciseList;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Text(controller.courseName),
          ),
          body: controller.isExerciseListLoading
              ? const Center(child: CircularProgressIndicator())
              : exercises.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/empaty-exercise.png',
                              width: 269,
                            ),
                            Text(
                              'Yah, Paket tidak tersedia',
                              style: Styles.blackTextStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              'Tenang, masih banyak yang bisa kamu pelajari. cari lagi yuk!',
                              style: Styles.greyTextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 153 / 96,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.exerciseQuestionsForm,
                                arguments: exercises[index].exerciseId);
                          },
                          child: Container(
                            height: 96,
                            width: 153,
                            padding: const EdgeInsets.symmetric(
                              vertical: 11,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: exercises[index].icon != null
                                      ? exercises[index].icon!
                                      : 'assets/images/error.png', // Provide a default image URL
                                  height: 27,
                                  width: 27,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    size: 27,
                                  ),
                                ),
                                Text(
                                  exercises[index].exerciseTitle ?? '',
                                  style: Styles.blackTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                Text(
                                  '${exercises[index].jumlahDone} / ${exercises[index].jumlahSoal} Soal',
                                  style: Styles.greyTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
