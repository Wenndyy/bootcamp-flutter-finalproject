import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalproject/core/values/colors.dart';
import 'package:finalproject/data/model/course_response.dart';
import 'package:finalproject/presentation/course/course_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../exercise/list/exercise_list_page.dart';

class CourseListPage extends GetView<CourseListController> {
  const CourseListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pilih Pelajaran'),
        backgroundColor: AppColors.primary,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: GetBuilder<CourseListController>(
          builder: (CourseListController courseController) {
            List<CourseData> courses = courseController.courseList;

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(
                      Routes.exerciseList,
                      arguments: ExerciseListPageArgs(
                        courseId: courses[index].courseId ?? '',
                        courseName: courses[index].courseName ?? '',
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: courses[index].urlCover != null
                              ? '${courses[index].urlCover}'
                              : 'assets/images/error.png', // Check if the URL is not null
                          height: 27,
                          width: 27,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 27,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(courses[index].courseName ?? ''),
                              if (courses[index].jumlahMateri! > 0)
                                Text(
                                  '${courses[index].jumlahDone ?? 0} / ${courses[index].jumlahMateri == 0 ? 1 : courses[index].jumlahMateri!} Paket Latihan Soal',
                                ),
                              const SizedBox(
                                height: 11,
                              ),
                              if (courses[index].jumlahMateri! > 0)
                                LinearProgressIndicator(
                                  backgroundColor: AppColors.greyD6,
                                  color: AppColors.primary,
                                  value: (courses[index].jumlahDone ?? 0) /
                                      (courses[index].jumlahMateri == 0
                                          ? 1
                                          : courses[index].jumlahMateri!),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
