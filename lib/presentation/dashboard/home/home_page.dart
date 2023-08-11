import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalproject/core/styles.dart';
import 'package:finalproject/core/values/colors.dart';
import 'package:finalproject/data/model/banner_response.dart';
import 'package:finalproject/data/model/course_response.dart';
import 'package:finalproject/data/model/user_response.dart';
import 'package:finalproject/presentation/dashboard/home/home_controller.dart';
import 'package:finalproject/presentation/exercise/list/exercise_list_page.dart';
import 'package:finalproject/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Get.find<HomeController>().loadUserData();
    Get.find<HomeController>().getCourses();
    Get.find<HomeController>().getBanners();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        UserData? userData = controller.currentUserData.value;
        List<CourseData> courses = controller.courseList;
        List<BannerData> banners = controller.bannerList;
        String foto = controller.firebaseAuthService.getPhoto() ?? '';
        if (userData == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hai, ${userData.userName ?? ''} ',
                          style: Styles.blackTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Selamat Datang',
                          style: Styles.blackTextStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(foto),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 26,
                      left: 20,
                      child: Text(
                        'Mau kerjain \nlatihan soal \napa hari ini?',
                        style: Styles.whiteTextStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/top-banner.png',
                        height: 97.96,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pilih Pelajaran",
                          style: Styles.blackTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        if (courses.length > controller.maxHomeCourseCount)
                          TextButton(
                            child: const Text('Lihat Semua'),
                            onPressed: () {
                              Get.toNamed(Routes.courseList);
                            },
                          ),
                      ],
                    ),
                  ),
                  if (controller.isLoading == true)
                    const Center(child: CircularProgressIndicator())
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courses.length > controller.maxHomeCourseCount
                          ? controller.maxHomeCourseCount
                          : courses.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          //title: Text(courses[index].courseName ?? ''),
                          onTap: () {
                            Get.toNamed(
                              Routes.exerciseList,
                              arguments: ExerciseListPageArgs(
                                courseId: courses[index].courseId!,
                                courseName: courses[index].courseName ?? '',
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 10),
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
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    size: 27,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          value: (courses[index].jumlahDone ??
                                                  0) /
                                              (courses[index].jumlahMateri == 0
                                                  ? 1
                                                  : courses[index]
                                                      .jumlahMateri!),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Terbaru",
                      style: Styles.blackTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (controller.isLoading == true)
                    const Center(child: CircularProgressIndicator())
                  else
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(banners.length, (index) {
                          return Container(
                            height: 146,
                            width: 284,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${banners[index].eventImage}',
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                ],
              ),

              //const HomeProfileWidget(),
              // const HomeTopBannerWidget(),
              // const HomeCoursesWidget(),
            ],
          );
        }
      },
    );
  }

  /*  Widget _mobileWidget() {
    return Container();
  }

  Widget _tabletWidget() {
    return Container();
  }

  Widget _landscapeWidget() {
    return Container();
  } */
}
