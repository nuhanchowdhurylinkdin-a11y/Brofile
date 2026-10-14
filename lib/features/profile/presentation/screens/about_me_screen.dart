import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/edit_about_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/features/profile/presentation/widgets/about_edit_fields.dart';
import 'package:brofile/features/profile/presentation/widgets/profile_about_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AboutMeScreen extends GetView<EditAboutController> {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: const ProfileAboutHeader(),
          body: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
                children: [
                  const _IdentityCard(),
                  SizedBox(height: 8.w),
                  _Section(
                    section: AboutSection.about,
                    icon: IconPath.profileAbout,
                    title: AppText.aboutMe,
                    display: Obx(
                      () => Text(
                        controller.profile.bio.value,
                        style: manrope(14, color: const Color(0xFF4B5563), lineHeight: 20),
                      ),
                    ),
                    editor: const Column(
                      children: [
                        AboutBioBox(),
                        AboutSaveBar(),
                      ],
                    ),
                  ),
                  _Section(
                    section: AboutSection.contact,
                    icon: IconPath.profileLink,
                    title: AppText.contact,
                    display: Obx(
                      () => Column(
                        children: [
                          _ContactRow(label: '${AppText.phone}:', value: controller.profile.phone.value),
                          SizedBox(height: 12.w),
                          _ContactRow(label: '${AppText.email}:', value: controller.profile.email.value),
                        ],
                      ),
                    ),
                    editor: Column(
                      children: [
                        AboutLabeledField(
                          label: AppText.phone,
                          child: AboutInputBox(
                            controller: controller.phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        SizedBox(height: 16.w),
                        AboutLabeledField(
                          label: AppText.email,
                          child: AboutInputBox(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const AboutSaveBar(),
                      ],
                    ),
                  ),
                  _Section(
                    section: AboutSection.employment,
                    icon: IconPath.profileCommunities,
                    title: AppText.employment,
                    display: Obx(() {
                      final jobs = controller.profile.jobs.take(2).toList();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < jobs.length; i++)
                            _JobTile(job: jobs[i], bordered: i == 0),
                          SizedBox(height: 12.w),
                          Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: GestureDetector(
                              onTap: () => controller.toggleSection(AboutSection.employment),
                              child: Text(
                                AppText.seeAll,
                                style: manrope(14, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 20),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    editor: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < controller.jobs.length; i++) ...[
                            if (i > 0) SizedBox(height: 24.w),
                            AboutJobFields(form: controller.jobs[i]),
                          ],
                          SizedBox(height: 12.w),
                          AboutAddAction(label: AppText.addAnother, onTap: controller.addJob),
                          const AboutSaveBar(),
                        ],
                      ),
                    ),
                  ),
                  _Section(
                    section: AboutSection.education,
                    icon: IconPath.profileAlbum,
                    title: AppText.education,
                    display: Obx(() {
                      final items = controller.profile.education.take(2).toList();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final item in items) _EducationTile(entry: item),
                          SizedBox(height: 12.w),
                          Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: GestureDetector(
                              onTap: () => controller.toggleSection(AboutSection.education),
                              child: Text(
                                AppText.seeAll,
                                style: manrope(14, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 20),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    editor: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < controller.education.length; i++) ...[
                            if (i > 0) SizedBox(height: 24.w),
                            AboutEducationFields(form: controller.education[i]),
                          ],
                          SizedBox(height: 12.w),
                          AboutAddAction(label: AppText.addAnother, onTap: controller.addEducation),
                          const AboutSaveBar(),
                        ],
                      ),
                    ),
                  ),
                  _Section(
                    section: AboutSection.skills,
                    icon: IconPath.profileHobbies,
                    title: AppText.skills,
                    display: Obx(
                      () => Wrap(
                        spacing: 8.w,
                        runSpacing: 8.w,
                        children: [
                          for (final skill in controller.profile.skills) _SkillChip(skill),
                        ],
                      ),
                    ),
                    editor: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Obx(
                          () => Wrap(
                            spacing: 8.w,
                            runSpacing: 8.w,
                            children: [
                              for (final skill in controller.skills)
                                GestureDetector(
                                  onTap: () => controller.removeSkill(skill),
                                  child: _SkillChip(skill, remove: true),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.w),
                        AboutInputBox(
                          controller: controller.skillInputController,
                          hint: AppText.addNew,
                          onSubmitted: (_) => controller.addSkill(),
                        ),
                        const AboutSaveBar(),
                      ],
                    ),
                  ),
                  _Section(
                    section: AboutSection.philosophy,
                    icon: IconPath.profileAspirations,
                    title: AppText.philosophy,
                    display: Obx(
                      () => Text(
                        controller.profile.philosophy.value,
                        style: manrope(14, color: const Color(0xFF4B5563), lineHeight: 20),
                      ),
                    ),
                    editor: Column(
                      children: [
                        AboutInputBox(controller: controller.philosophyController),
                        const AboutSaveBar(),
                      ],
                    ),
                  ),
                  _Section(
                    section: AboutSection.links,
                    icon: IconPath.profileLink,
                    title: AppText.links,
                    bordered: false,
                    display: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final link in controller.profile.links)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.w, left: 8.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('•  ', style: manrope(14, color: const Color(0xFF4B5563), lineHeight: 20)),
                                  Expanded(
                                    child: Text(
                                      link,
                                      style: manrope(14, color: const Color(0xFF4B5563), lineHeight: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    editor: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < controller.links.length; i++) ...[
                            if (i > 0) SizedBox(height: 16.w),
                            AboutInputBox(controller: controller.links[i]),
                          ],
                          SizedBox(height: 12.w),
                          AboutAddAction(label: AppText.addLink, onTap: controller.addLink),
                          const AboutSaveBar(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

class _IdentityCard extends GetView<EditAboutController> {
  const _IdentityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 229.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: Image.asset(
                    ImagePath.profileCover,
                    width: double.infinity,
                    height: 198.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12.w,
                  right: 12.w,
                  child: GestureDetector(
                    onTap: () => controller.toggleSection(AboutSection.identity),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.openNowScrim,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(IconPath.addPhotoCamera, width: 20.w, height: 20.w),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 111.w,
                  child: Center(
                    child: Container(
                      width: 109.w,
                      height: 109.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 6.813.w),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              ImagePath.avatarWilliam,
                              fit: BoxFit.cover,
                              width: 109.w,
                              height: 109.w,
                            ),
                          ),
                          Positioned(
                            right: -3.w,
                            bottom: -3.w,
                            child: Container(
                              width: 27.w,
                              height: 27.w,
                              decoration: BoxDecoration(
                                color: AppColors.online,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (controller.isEditing(AboutSection.identity)) {
              return Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 16.w),
                child: Column(
                  children: [
                    AboutLabeledField(
                      label: AppText.fullName,
                      child: AboutInputBox(controller: controller.nameController),
                    ),
                    SizedBox(height: 16.w),
                    AboutLabeledField(
                      label: AppText.userName,
                      child: AboutInputBox(controller: controller.usernameController),
                    ),
                    SizedBox(height: 16.w),
                    AboutLabeledField(
                      label: AppText.headline,
                      child: AboutInputBox(controller: controller.headlineController),
                    ),
                    SizedBox(height: 16.w),
                    AboutLabeledField(
                      label: AppText.locationLabel,
                      child: AboutInputBox(controller: controller.locationController),
                    ),
                    SizedBox(height: 16.w),
                    AboutLabeledField(
                      label: AppText.website,
                      child: AboutInputBox(controller: controller.websiteController),
                    ),
                    const AboutSaveBar(),
                  ],
                ),
              );
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.profile.displayName.value,
                      style: manrope(16, weight: FontWeight.w600, color: AppColors.primary, lineHeight: 24),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      controller.profile.username.value,
                      style: manrope(12, color: AppColors.neutral500, lineHeight: 16),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => controller.toggleSection(AboutSection.identity),
                      child: SvgPicture.asset(
                        IconPath.profileCoverEdit,
                        width: 16.w,
                        height: 16.w,
                        colorFilter: const ColorFilter.mode(AppColors.neutral500, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 16.w, 12.w, 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconPath.profilePin, width: 20.w, height: 20.w),
                      SizedBox(width: 8.w),
                      Text(
                        controller.profile.locationLabel.value,
                        style: manrope(14, weight: FontWeight.w500, color: AppColors.neutral600, lineHeight: 20),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 4.w,
                        height: 4.w,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      SvgPicture.asset(IconPath.profileLink, width: 20.w, height: 20.w),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          controller.profile.website.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: manrope(14, weight: FontWeight.w500, color: AppColors.neutral600, lineHeight: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _Section extends GetView<EditAboutController> {
  const _Section({
    required this.section,
    required this.icon,
    required this.title,
    required this.display,
    required this.editor,
    this.bordered = true,
  });

  final AboutSection section;
  final String icon;
  final String title;
  final Widget display;
  final Widget editor;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      decoration: bordered
          ? const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.neutral300)))
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon, width: 20.w, height: 20.w),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
                ),
              ),
              GestureDetector(
                onTap: () => controller.toggleSection(section),
                child: Obx(
                  () => SvgPicture.asset(
                    controller.isEditing(section) ? IconPath.pleasureClose : IconPath.profileCoverEdit,
                    width: 20.w,
                    height: 20.w,
                    colorFilter: const ColorFilter.mode(AppColors.neutral500, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          Obx(() => controller.isEditing(section) ? editor : display),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(label, style: manrope(14, color: const Color(0xFF4B5563), lineHeight: 20)),
        ),
        Expanded(
          child: Text(value, style: manrope(14, color: const Color(0xFF4B5563), lineHeight: 20)),
        ),
      ],
    );
  }
}

class _JobTile extends StatelessWidget {
  const _JobTile({required this.job, required this.bordered});

  final EmploymentEntry job;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25.w, 16.w, 0, 16.w),
      decoration: bordered
          ? const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.neutral300)))
          : null,
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              job.company.characters.first,
              style: manrope(16, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 24),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.title, style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24)),
                Text(job.company, style: manrope(14, weight: FontWeight.w500, color: AppColors.neutral500, lineHeight: 20)),
                Text(job.period, style: manrope(14, color: AppColors.neutral600, lineHeight: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationTile extends StatelessWidget {
  const _EducationTile({required this.entry});

  final EducationEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(25.w, 16.w, 0, 16.w),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.neutral300))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.course, style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24)),
          Text(entry.institute, style: manrope(14, weight: FontWeight.w500, color: AppColors.neutral500, lineHeight: 20)),
          Text(entry.period, style: manrope(14, color: AppColors.neutral600, lineHeight: 20)),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip(this.label, {this.remove = false});

  final String label;
  final bool remove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFAE6),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: manrope(14, color: const Color(0xFF067647), lineHeight: 20)),
          if (remove) ...[
            SizedBox(width: 6.w),
            Icon(Icons.close, size: 14.w, color: const Color(0xFF067647)),
          ],
        ],
      ),
    );
  }
}
