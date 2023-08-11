import 'package:finalproject/core/styles.dart';
import 'package:finalproject/core/values/colors.dart';
import 'package:finalproject/data/model/question_list_response.dart';
import 'package:finalproject/presentation/exercise/questions_form/exercise_questions_form_controller.dart';
import 'package:finalproject/presentation/exercise/questions_form/exercise_questions_form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseQuestionsFormPage extends StatelessWidget {
  const ExerciseQuestionsFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Soal'),
        centerTitle: true,
      ),
      body: GetBuilder<ExerciseQuestionsFormController>(
        builder: (controller) {
          List<QuestionListData> questions = controller.questionList;
          int activeQuestionIndex = controller.activeQuestionIndex;
          if (questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          QuestionListData activeQuestion = questions[activeQuestionIndex];
          String activeQuestionId = controller.activeQuestionId;
          String? selectedAnswer = controller.questionAnswers
              .firstWhereOrNull((e) => e.questionId == activeQuestionId)
              ?.answer;

          print(
              'questionAnswers: ${controller.questionAnswers.map((e) => '${e.questionId}-${e.answer}')}');

          return Column(
            children: [
              // Question Number Horizontal ListView
              Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    10,
                    (index) {
                      bool isAnswered = controller.questionAnswers.any(
                        (element) =>
                            element.questionId == questions[index].questionId &&
                            element.questionId == activeQuestionId,
                      );

                      return InkWell(
                        onTap: () {
                          controller.navigateToQuestionIndex(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary,
                            ),
                            color: isAnswered
                                ? AppColors.primary
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontWeight: isAnswered
                                    ? FontWeight.w800
                                    : FontWeight.w400,
                                color: isAnswered ? Colors.white : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(18),
                  children: [
                    Text(
                      'Soal Nomor ${activeQuestionIndex + 1}',
                      style: Styles.greyTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // Judul/Pertanyaan Soal
                    HtmlWidget(
                      activeQuestion.questionTitle ?? '',
                      textStyle: Styles.blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // Text(activeQuestion.questionTitle ?? ''),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateAnswerToQuestion(
                            questionId: activeQuestionId,
                            answer: 'A',
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: selectedAnswer == 'A'
                                ? AppColors.primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFD6D6D6),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'A. ',
                                style: GoogleFonts.poppins(
                                  color: selectedAnswer == 'A'
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: HtmlWidget(
                                  '${activeQuestion.optionA}',
                                  textStyle: GoogleFonts.poppins(
                                    color: selectedAnswer == 'A'
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Opsi Jawaban
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateAnswerToQuestion(
                            questionId: activeQuestionId,
                            answer: 'B',
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: selectedAnswer == 'B'
                                ? AppColors.primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFD6D6D6),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'B. ',
                                style: GoogleFonts.poppins(
                                  color: selectedAnswer == 'B'
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: HtmlWidget(
                                  '${activeQuestion.optionB}',
                                  textStyle: GoogleFonts.poppins(
                                    color: selectedAnswer == 'B'
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateAnswerToQuestion(
                            questionId: activeQuestionId,
                            answer: 'C',
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: selectedAnswer == 'C'
                                ? AppColors.primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFD6D6D6),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'C. ',
                                style: GoogleFonts.poppins(
                                  color: selectedAnswer == 'C'
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: HtmlWidget(
                                  '${activeQuestion.optionC}',
                                  textStyle: GoogleFonts.poppins(
                                    color: selectedAnswer == 'C'
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateAnswerToQuestion(
                            questionId: activeQuestionId,
                            answer: 'D',
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: selectedAnswer == 'D'
                                ? AppColors.primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFD6D6D6),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'D. ',
                                style: GoogleFonts.poppins(
                                  color: selectedAnswer == 'D'
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: HtmlWidget(
                                  '${activeQuestion.optionD}',
                                  textStyle: GoogleFonts.poppins(
                                    color: selectedAnswer == 'D'
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateAnswerToQuestion(
                            questionId: activeQuestionId,
                            answer: 'E',
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: selectedAnswer == 'E'
                                ? AppColors.primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFD6D6D6),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'E. ',
                                style: GoogleFonts.poppins(
                                  color: selectedAnswer == 'E'
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: HtmlWidget(
                                  '${activeQuestion.optionE}',
                                  textStyle: GoogleFonts.poppins(
                                    color: selectedAnswer == 'E'
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    if (activeQuestionIndex < questions.length - 1)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            controller.navigateToQuestionIndex(
                                activeQuestionIndex + 1);
                          },
                          child: Text(
                            'Selanjutnya',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    else
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Get.bottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              Wrap(
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Container(
                                        height: 6,
                                        width: 89,
                                        decoration: BoxDecoration(
                                          color: AppColors.greyD6,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      const SizedBox(height: 22),
                                      Image.asset(
                                        'assets/images/bottom-sheet.png',
                                        width: 286,
                                      ),
                                      const SizedBox(height: 9),
                                      Text(
                                        'Kumpulkan latihan soal sekarang?',
                                        style: Styles.blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'Boleh langsung kumpulin dong',
                                        style: Styles.greyTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          const SizedBox(width: 32),
                                          Expanded(
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  side: const BorderSide(
                                                    color: AppColors.primary,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text('Nanti Dulu'),
                                            ),
                                          ),
                                          const SizedBox(width: 32),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.primary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                                controller.submitAnswers();
                                              },
                                              child: const Text('Ya'),
                                            ),
                                          ),
                                          const SizedBox(width: 32),
                                        ],
                                      ),
                                      const SizedBox(height: 32),
                                    ],
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.white,
                            );
                          },
                          child: Text(
                            'Kumpulin',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
