// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/common/converter.dart';
import '../../../../../../core/common/logger.dart';
import '../../../../../../core/components/container.dart';
import '../../../../../../core/components/text/golden_gradient_text.dart';
import '../../../../../../core/components/textform_field.dart';
import '../../../bloc/profile/profil_bloc.dart';
import '../widget/_height_widget.dart';
import '../widget/_horoscope_widget.dart';
import '../widget/_weight_widget.dart';
import '../widget/_zodiac_widget.dart';
import '../widget/appbar_profile.dart';
import '../widget/interest_widget.dart';

XFile? imageX2;
bool image = false;

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // var email = Get.arguments[0];

  var gender = <String>['Male', 'Female'];

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;

  var selectedDate = DateTime.now();
  int ageP = 0;

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final zodiac = getZodiac(selectedDate.month, selectedDate.day);
    final horoscope = calculateZodiac(selectedDate.year);

    dynamic argumentData = Get.arguments;

    logger.i(Get.arguments[0]);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarProfile(email: Get.arguments[0]),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(9, 20, 26, 1),
        ),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 71, bottom: 50),
              child: Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    ProfileSatu(email: argumentData[0]),
                    const SizedBox(height: 24),
                    BlocBuilder<ProfileBloc, ProfilState>(
                      builder: (context, state) {
                        if (state.status == "LOADED") {
                          return GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(14, 25, 31, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "About",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<ProfileBloc>()
                                                .add(UpdateTapAbout2(
                                                  name: nameController.text,
                                                  gender:
                                                      selectedValue.toString(),
                                                  zodiac: zodiac,
                                                  horoscope: horoscope,
                                                  height:
                                                      '${heightController.text} cm',
                                                  weight: weightController
                                                              .text !=
                                                          ''
                                                      ? '${weightController.text} kg'
                                                      : ' - ',
                                                ));
                                          },
                                          child: const GoldText(
                                            text: "Save & Update",
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const AddImageWidget(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 29,
                                        left: 27,
                                        right: 14,
                                        bottom: 40),
                                    child: Column(
                                      children: [
                                        DisplayNameWidget(
                                            nameController: nameController),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Gender:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Colors.white
                                                    .withOpacity(0.33),
                                              ),
                                            ),
                                            ConstrainedBox(
                                              constraints:
                                                  const BoxConstraints.tightFor(
                                                      width: 202, height: 36),
                                              child: containerAbout(
                                                child: DropdownButtonFormField2(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerEnd,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                    ),
                                                  ),
                                                  isExpanded: true,
                                                  hint: const Text(
                                                    'Select Gender ',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromRGBO(
                                                            255,
                                                            255,
                                                            255,
                                                            0.3)),
                                                  ),
                                                  items: genderItems
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .centerEnd,
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return '  gender.';
                                                    }
                                                    return value;
                                                  },
                                                  onChanged: (value) {
                                                    selectedValue = value;
                                                  },
                                                  onSaved: (value) {
                                                    selectedValue;
                                                  },
                                                  value: selectedValue,
                                                  buttonStyleData:
                                                      const ButtonStyleData(
                                                    height: 60,
                                                    padding: EdgeInsets.only(
                                                        left: 0, right: 9),
                                                  ),
                                                  iconStyleData:
                                                      const IconStyleData(
                                                    icon: Icon(
                                                      Icons
                                                          .arrow_drop_down_outlined,
                                                      color: Colors.white,
                                                    ),
                                                    iconSize: 28,
                                                  ),
                                                  dropdownStyleData:
                                                      DropdownStyleData(
                                                    width: 202,
                                                    offset:
                                                        const Offset(-1, -10),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black26,
                                                      ),
                                                      color: const Color(
                                                          0xFF0D1D23),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Birthday:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Colors.white
                                                    .withOpacity(0.33),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                FocusScope.of(context)
                                                    .unfocus();

                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: selectedDate,
                                                  firstDate: DateTime(1800),
                                                  lastDate: DateTime(2024),
                                                  builder:
                                                      (BuildContext context,
                                                          Widget? child) {
                                                    return Theme(
                                                      data: ThemeData.dark()
                                                          .copyWith(
                                                        useMaterial3: true,
                                                        colorScheme:
                                                            const ColorScheme
                                                                .dark(
                                                          primary:
                                                              Color.fromARGB(
                                                                  255,
                                                                  3,
                                                                  112,
                                                                  101),
                                                          background:
                                                              Color(0xff121212),
                                                          onPrimary:
                                                              Colors.white,
                                                          surface:
                                                              Color(0xFF0D1D23),
                                                          onSurface:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },
                                                  helpText: 'Select DOB',
                                                  cancelText: 'Close',
                                                  confirmText: 'Confirm',
                                                  errorFormatText:
                                                      'Enter valid date',
                                                  errorInvalidText:
                                                      'Enter valid date range',
                                                  fieldLabelText: 'DOB',
                                                  fieldHintText:
                                                      'Month/Date/Year',
                                                );

                                                if (pickedDate != null &&
                                                    pickedDate !=
                                                        selectedDate) {
                                                  selectedDate = pickedDate;
                                                }

                                                context.read<ProfileBloc>().add(
                                                    UpdateLooping(
                                                        loop: state.loop + 1));
                                              },
                                              child: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints
                                                            .tightFor(
                                                        width: 202, height: 36),
                                                child: containerAbout(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: BlocConsumer<
                                                        ProfileBloc,
                                                        ProfilState>(
                                                      listener: (context,
                                                          state) async {
                                                        final zodiac =
                                                            getZodiac(
                                                                selectedDate
                                                                    .month,
                                                                selectedDate
                                                                    .day);
                                                        final horoscope =
                                                            calculateZodiac(
                                                                selectedDate
                                                                    .year);

                                                        var age = DateTime.now()
                                                                .year -
                                                            selectedDate.year;

                                                        ageP = age;

                                                        context
                                                            .read<ProfileBloc>()
                                                            .add(UpdateTapAbout3(
                                                                zodiac: zodiac,
                                                                horoscope:
                                                                    horoscope,
                                                                age: age,
                                                                gender: selectedValue
                                                                    .toString()));
                                                      },
                                                      builder:
                                                          (context, state) {
                                                        if (state.loop > 0) {
                                                          return Text(
                                                            DateFormat(
                                                                    "dd-MM-yyyy")
                                                                .format(
                                                                    selectedDate)
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          );
                                                        }
                                                        return Text(
                                                          "DD MM YYYY",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.33),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        const HoroscopeWiget(),
                                        const SizedBox(height: 12),
                                        const ZodiacWidget(),
                                        const SizedBox(height: 12),
                                        HeightWidget(
                                            heightController: heightController),
                                        const SizedBox(height: 12),
                                        WeightWidget(
                                            weightController: weightController),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          if (state.status == "SAVED") {
                            return Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(14, 25, 31, 1),
                                border: Border.all(
                                  color: const Color.fromRGBO(14, 25, 31, 1),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "About",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<ProfileBloc>()
                                                  .add(const UpdateTapAbout1());
                                            },
                                            child: SvgPicture.asset(
                                              'assets/icon/edit-2.svg',
                                              width: 17,
                                              height: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 25, left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text("Birthday: ",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.52),
                                                    fontSize: 14)),
                                            Text(
                                              "${DateFormat("dd / MM / yyyy").format(selectedDate)} (Age $ageP)",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Text("Horoscope: ",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.52),
                                                    fontSize: 14)),
                                            Text(
                                              state.horoscope,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Text("Zodiac: ",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.52),
                                                    fontSize: 14)),
                                            Text(
                                              state.zodiac,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Text("Height: ",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.52),
                                                    fontSize: 14)),
                                            Text(
                                              state.height,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            const Text("Weight: ",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.52),
                                                    fontSize: 14)),
                                            Text(
                                              state.weight,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const EmptyAbout();
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    const InterestWidget(),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class AddImageWidget extends StatefulWidget {
  const AddImageWidget({super.key});

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  Future<XFile?> getImage(ImageSource imageSource) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: imageSource);

    if (pickedImage != null) {
      imageX2 = XFile(pickedImage.path);
    }

    setState(() {});

    return imageX2;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 27),
      child: Row(
        children: [
          GestureDetector(
              onTap: () async {
                pickImageFrom(context);
              },
              child: BlocConsumer<ProfileBloc, ProfilState>(
                listener: (context, state) async {
                  context.read<ProfileBloc>().add(const UpdateTapProfile());
                },
                builder: (context, state) {
                  if (imageX2 != null) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: SizedBox(
                        width: 57,
                        height: 57,
                        child: Image.file(
                          File(imageX2!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }

                  return Container(
                    width: 57,
                    height: 57,
                    padding: const EdgeInsets.all(19),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(22, 35, 41, 1),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: SvgPicture.asset(
                      'assets/icon/add_image.svg',
                      width: 18,
                      height: 18,
                    ),
                  );
                },
              )),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: imageX2 == null
                ? GestureDetector(
                    onTap: () {
                      pickImageFrom(context);
                    },
                    child: const Text(
                      "Add image",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      imageX2 = null;

                      setState(() {});
                    },
                    child: const Text(
                      "Clear image",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> pickImageFrom(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 132,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF0D1D23),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);

                    getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F4247).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.camera,
                            size: 28.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('Camera')
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F4247).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.image,
                            size: 28.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('Photo Gallery')
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class DisplayNameWidget extends StatelessWidget {
  const DisplayNameWidget({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Display name:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.white.withOpacity(0.33),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 202, height: 36),
          child: CustomTextFormField(
            hintText: ("Enter name"),
            controller: nameController,
          ),
        )
      ],
    );
  }
}

class EmptyAbout extends StatelessWidget {
  const EmptyAbout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(14, 25, 31, 1),
        border: Border.all(
          color: const Color.fromRGBO(14, 25, 31, 1),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "About",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<ProfileBloc>().add(const UpdateTapAbout1());
                    },
                    child: SvgPicture.asset(
                      'assets/icon/edit-2.svg',
                      width: 17,
                      height: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 7),
          const Padding(
            padding: EdgeInsets.only(bottom: 23, left: 15, right: 57),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Add in your your to help others know you better",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.52), fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSatu extends StatelessWidget {
  const ProfileSatu({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfilState>(
      builder: (context, state) {
        if (imageX2 != null) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 190,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(imageX2!.path)),
                fit: BoxFit.fitWidth,
              ),
              color: const Color.fromRGBO(22, 35, 41, 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF000000).withOpacity(0.76),
                    Colors.transparent,
                    const Color(0xFF000000),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 81, left: 13),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<ProfileBloc, ProfilState>(
                        builder: (context, state) {
                          if (state.status == "SAVED") {
                            return Text(
                              '${state.name}, ${state.age}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            );
                          }

                          return const Text(
                            "",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 6, bottom: 12, left: 13),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: BlocBuilder<ProfileBloc, ProfilState>(
                          builder: (context, state) {
                            if (state.status == "SAVED") {
                              return Text(state.gender,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13));
                            } else {
                              return const Text("",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13));
                            }
                          },
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 13),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(31, 35, 31, 1),
                              border: Border.all(
                                color: const Color.fromRGBO(31, 35, 31, 1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 9.5),
                            child: Center(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/zodia.svg',
                                    width: 14,
                                    height: 14,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    state.zodiac,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(31, 35, 31, 1),
                              border: Border.all(
                                color: const Color.fromRGBO(31, 35, 31, 1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 9.5),
                            child: Center(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/horoscope.svg',
                                    width: 14,
                                    height: 14,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    state.horoscope,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.status == "SAVED") {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 190,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(22, 35, 41, 1),
              border: Border.all(
                color: const Color.fromRGBO(22, 35, 41, 1),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 87, left: 13),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: BlocBuilder<ProfileBloc, ProfilState>(
                      builder: (context, state) {
                        if (state.status == "SAVED") {
                          return Text(
                            '${state.name}, ${state.age}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          );
                        }

                        return const Text(
                          "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 12, left: 13),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<ProfileBloc, ProfilState>(
                        builder: (context, state) {
                          if (state.status == "SAVED") {
                            return Text(state.gender,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 13));
                          } else {
                            return const Text("",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13));
                          }
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(31, 35, 31, 1),
                            border: Border.all(
                              color: const Color.fromRGBO(31, 35, 31, 1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 97,
                          height: 36,
                          child: Center(
                            child: Text(
                              state.zodiac,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(31, 35, 31, 1),
                            border: Border.all(
                              color: const Color.fromRGBO(31, 35, 31, 1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 97,
                          height: 36,
                          child: Center(
                            child: Text(
                              state.horoscope,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 190,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(22, 35, 41, 1),
            border: Border.all(
              color: const Color.fromRGBO(22, 35, 41, 1),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 17, left: 13),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '@${removeEmailDomain(email)}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
