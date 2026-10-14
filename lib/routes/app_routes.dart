import 'package:get/get.dart';

import '../features/authentication/controllers/forgot_password_controller.dart';
import '../features/authentication/controllers/otp_controller.dart';
import '../features/authentication/controllers/reset_password_controller.dart';
import '../features/authentication/controllers/sign_in_controller.dart';
import '../features/authentication/controllers/sign_up_controller.dart';
import '../features/authentication/presentation/screens/forgot_password_screen.dart';
import '../features/authentication/presentation/screens/otp_screen.dart';
import '../features/authentication/presentation/screens/reset_password_screen.dart';
import '../features/authentication/presentation/screens/sign_in_screen.dart';
import '../features/authentication/presentation/screens/sign_up_screen.dart';
import '../features/community/controllers/community_controller.dart';
import '../features/community/controllers/community_details_controller.dart';
import '../features/community/controllers/community_new_post_controller.dart';
import '../features/community/controllers/create_community_controller.dart';
import '../features/community/controllers/invite_members_controller.dart';
import '../features/community/presentation/screens/community_details_screen.dart';
import '../features/community/presentation/screens/community_new_post_screen.dart';
import '../features/community/presentation/screens/create_community_screen.dart';
import '../features/community/presentation/screens/invite_members_screen.dart';
import '../features/community/presentation/screens/my_communities_screen.dart';
import '../features/discover/controllers/create_product_controller.dart';
import '../features/discover/controllers/discover_controller.dart';
import '../features/discover/controllers/recycle_product_details_controller.dart';
import '../features/discover/presentation/screens/create_product_screen.dart';
import '../features/discover/presentation/screens/recycle_product_details_screen.dart';
import '../features/home/controllers/chat_controller.dart';
import '../features/home/controllers/home_controller.dart';
import '../features/home/controllers/home_search_controller.dart';
import '../features/home/controllers/messages_controller.dart';
import '../features/home/controllers/notifications_controller.dart';
import '../features/home/presentation/screens/chat_screen.dart';
import '../features/home/presentation/screens/messages_screen.dart';
import '../features/home/presentation/screens/notifications_screen.dart';
import '../features/home/presentation/screens/search_screen.dart';
import '../features/main_nav/controllers/main_nav_controller.dart';
import '../features/pleasure/controllers/create_pleasure_controller.dart';
import '../features/pleasure/controllers/pleasure_controller.dart';
import '../features/pleasure/controllers/pleasure_details_controller.dart';
import '../features/profile/controllers/add_hobby_controller.dart';
import '../features/profile/controllers/album_details_controller.dart';
import '../features/profile/controllers/edit_about_controller.dart';
import '../features/profile/controllers/profile_controller.dart';
import '../features/profile/controllers/settings_controller.dart';
import '../features/profile/presentation/screens/about_brofile_screen.dart';
import '../features/profile/presentation/screens/about_me_screen.dart';
import '../features/profile/presentation/screens/add_hobby_screen.dart';
import '../features/profile/presentation/screens/album_details_screen.dart';
import '../features/profile/presentation/screens/blocked_users_screen.dart';
import '../features/profile/presentation/screens/change_password_screen.dart';
import '../features/profile/presentation/screens/contact_us_screen.dart';
import '../features/profile/presentation/screens/help_center_screen.dart';
import '../features/profile/presentation/screens/hidden_communities_screen.dart';
import '../features/profile/presentation/screens/hobbies_screen.dart';
import '../features/profile/presentation/screens/notifications_settings_screen.dart';
import '../features/profile/presentation/screens/privacy_policy_screen.dart';
import '../features/profile/controllers/aspirations_controller.dart';
import '../features/profile/controllers/business_profile_controller.dart';
import '../features/profile/controllers/create_business_event_controller.dart';
import '../features/profile/controllers/create_business_post_controller.dart';
import '../features/profile/controllers/create_business_product_controller.dart';
import '../features/profile/controllers/create_business_service_controller.dart';
import '../features/profile/controllers/edit_business_controller.dart';
import '../features/profile/controllers/my_circle_controller.dart';
import '../features/profile/presentation/screens/add_to_circle_screen.dart';
import '../features/profile/presentation/screens/aspirations_screen.dart';
import '../features/profile/presentation/screens/business_catalog_details_screen.dart';
import '../features/profile/presentation/screens/business_event_details_screen.dart';
import '../features/profile/presentation/screens/business_profile_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/create_aspiration_screen.dart';
import '../features/profile/presentation/screens/create_business_event_screen.dart';
import '../features/profile/presentation/screens/create_business_post_screen.dart';
import '../features/profile/presentation/screens/create_business_product_screen.dart';
import '../features/profile/presentation/screens/create_business_service_screen.dart';
import '../features/profile/presentation/screens/edit_business_screen.dart';
import '../features/profile/presentation/screens/my_circle_screen.dart';
import '../features/profile/presentation/screens/settings_screen.dart';
import '../features/pleasure/presentation/screens/create_pleasure_screen.dart';
import '../features/pleasure/presentation/screens/pleasure_details_screen.dart';
import '../features/main_nav/presentation/screens/main_nav_screen.dart';
import '../features/onboarding/controllers/onboarding_controller.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/splash/controllers/splash_controller.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = "/onboardingScreen";
  static String signInScreen = "/signInScreen";
  static String signUpScreen = "/signUpScreen";
  static String forgotPasswordScreen = "/forgotPasswordScreen";
  static String otpScreen = "/otpScreen";
  static String resetPasswordScreen = "/resetPasswordScreen";
  static String mainNavScreen = "/mainNavScreen";
  static String pleasureDetailsScreen = "/pleasureDetailsScreen";
  static String createPleasureScreen = "/createPleasureScreen";
  static String createProductScreen = "/createProductScreen";
  static String recycleProductDetailsScreen = "/recycleProductDetailsScreen";
  static String hobbiesScreen = "/hobbiesScreen";
  static String addHobbyScreen = "/addHobbyScreen";
  static String albumDetailsScreen = "/albumDetailsScreen";
  static String aboutMeScreen = "/aboutMeScreen";
  static String settingsScreen = "/settingsScreen";
  static String changePasswordScreen = "/changePasswordScreen";
  static String notificationsSettingsScreen = "/notificationsSettingsScreen";
  static String blockedUsersScreen = "/blockedUsersScreen";
  static String hiddenCommunitiesScreen = "/hiddenCommunitiesScreen";
  static String helpCenterScreen = "/helpCenterScreen";
  static String contactUsScreen = "/contactUsScreen";
  static String privacyPolicyScreen = "/privacyPolicyScreen";
  static String myCommunitiesScreen = "/myCommunitiesScreen";
  static String communityDetailsScreen = "/communityDetailsScreen";
  static String communityNewPostScreen = "/communityNewPostScreen";
  static String inviteMembersScreen = "/inviteMembersScreen";
  static String createCommunityScreen = "/createCommunityScreen";
  static String aboutBrofileScreen = "/aboutBrofileScreen";
  static String myCircleScreen = "/myCircleScreen";
  static String addToCircleScreen = "/addToCircleScreen";
  static String aspirationsScreen = "/aspirationsScreen";
  static String createAspirationScreen = "/createAspirationScreen";
  static String businessProfileScreen = "/businessProfileScreen";
  static String userProfileScreen = "/userProfileScreen";
  static String businessEventDetailsScreen = "/businessEventDetailsScreen";
  static String businessCatalogDetailsScreen = "/businessCatalogDetailsScreen";
  static String createBusinessProductScreen = "/createBusinessProductScreen";
  static String createBusinessServiceScreen = "/createBusinessServiceScreen";
  static String createBusinessEventScreen = "/createBusinessEventScreen";
  static String createBusinessPostScreen = "/createBusinessPostScreen";
  static String editBusinessScreen = "/editBusinessScreen";
  static String searchScreen = "/searchScreen";
  static String notificationsInboxScreen = "/notificationsInboxScreen";
  static String messagesScreen = "/messagesScreen";
  static String chatScreen = "/chatScreen";

  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getSignInScreen() => signInScreen;
  static String getMainNavScreen() => mainNavScreen;

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: onboardingScreen,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => OnboardingController())),
    ),
    GetPage(
      name: signInScreen,
      page: () => const SignInScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => SignInController())),
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => SignUpController())),
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ForgotPasswordController())),
    ),
    GetPage(
      name: otpScreen,
      page: () => const OtpScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => OtpController())),
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ResetPasswordController())),
    ),
    GetPage(
      name: mainNavScreen,
      page: () => const MainNavScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MainNavController());
        Get.lazyPut(() => HomeController());
        Get.lazyPut(() => CommunityController());
        Get.lazyPut(() => PleasureController());
        Get.lazyPut(() => DiscoverController());
        Get.lazyPut(() => ProfileController());
      }),
    ),
    GetPage(
      name: pleasureDetailsScreen,
      page: () => const PleasureDetailsScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => PleasureDetailsController()),
      ),
    ),
    GetPage(
      name: createPleasureScreen,
      page: () => const CreatePleasureScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => CreatePleasureController()),
      ),
    ),
    GetPage(
      name: createProductScreen,
      page: () => const CreateProductScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => CreateProductController()),
      ),
    ),
    GetPage(
      name: recycleProductDetailsScreen,
      page: () => const RecycleProductDetailsScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => RecycleProductDetailsController()),
      ),
    ),
    GetPage(
      name: hobbiesScreen,
      page: () => const HobbiesScreen(),
    ),
    GetPage(
      name: addHobbyScreen,
      page: () => const AddHobbyScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<AddHobbyController>()) {
          Get.delete<AddHobbyController>();
        }
        Get.put(AddHobbyController());
      }),
    ),
    GetPage(
      name: albumDetailsScreen,
      page: () => const AlbumDetailsScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<AlbumDetailsController>()) {
          Get.delete<AlbumDetailsController>();
        }
        Get.put(AlbumDetailsController());
      }),
    ),
    GetPage(
      name: aboutMeScreen,
      page: () => const AboutMeScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<EditAboutController>()) {
          Get.delete<EditAboutController>();
        }
        Get.put(EditAboutController());
      }),
    ),
    GetPage(
      name: settingsScreen,
      page: () => const SettingsScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<SettingsController>()) {
          Get.delete<SettingsController>();
        }
        Get.put(SettingsController());
      }),
    ),
    GetPage(
      name: changePasswordScreen,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(
      name: notificationsSettingsScreen,
      page: () => const NotificationsSettingsScreen(),
    ),
    GetPage(
      name: blockedUsersScreen,
      page: () => const BlockedUsersScreen(),
    ),
    GetPage(
      name: hiddenCommunitiesScreen,
      page: () => const HiddenCommunitiesScreen(),
    ),
    GetPage(
      name: helpCenterScreen,
      page: () => const HelpCenterScreen(),
    ),
    GetPage(
      name: contactUsScreen,
      page: () => const ContactUsScreen(),
    ),
    GetPage(
      name: privacyPolicyScreen,
      page: () => const PrivacyPolicyScreen(),
    ),
    GetPage(
      name: myCommunitiesScreen,
      page: () => const MyCommunitiesScreen(),
    ),
    GetPage(
      name: communityDetailsScreen,
      page: () => const CommunityDetailsScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<CommunityDetailsController>()) {
          Get.delete<CommunityDetailsController>();
        }
        Get.put(CommunityDetailsController());
      }),
    ),
    GetPage(
      name: communityNewPostScreen,
      page: () => const CommunityNewPostScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<CommunityNewPostController>()) {
          Get.delete<CommunityNewPostController>();
        }
        Get.put(CommunityNewPostController());
      }),
    ),
    GetPage(
      name: inviteMembersScreen,
      page: () => const InviteMembersScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<InviteMembersController>()) {
          Get.delete<InviteMembersController>();
        }
        Get.put(InviteMembersController());
      }),
    ),
    GetPage(
      name: createCommunityScreen,
      page: () => const CreateCommunityScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<CreateCommunityController>()) {
          Get.delete<CreateCommunityController>();
        }
        Get.put(CreateCommunityController());
      }),
    ),
    GetPage(
      name: aboutBrofileScreen,
      page: () => const AboutBrofileScreen(),
    ),
    GetPage(
      name: myCircleScreen,
      page: () => const MyCircleScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<MyCircleController>()) {
          Get.put(MyCircleController());
        }
      }),
    ),
    GetPage(
      name: addToCircleScreen,
      page: () => const AddToCircleScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<MyCircleController>()) {
          Get.put(MyCircleController());
        }
      }),
    ),
    GetPage(
      name: aspirationsScreen,
      page: () => const AspirationsScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<AspirationsController>()) {
          Get.put(AspirationsController());
        }
      }),
    ),
    GetPage(
      name: createAspirationScreen,
      page: () => const CreateAspirationScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<AspirationsController>()) {
          Get.put(AspirationsController());
        }
      }),
    ),
    GetPage(
      name: businessProfileScreen,
      page: () => const BusinessProfileScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<BusinessProfileController>()) {
          Get.delete<BusinessProfileController>();
        }
        Get.put(BusinessProfileController());
      }),
    ),
    GetPage(
      name: userProfileScreen,
      page: () => const ProfileScreen(asVisitor: true),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<ProfileController>()) {
          Get.put(ProfileController());
        }
      }),
    ),
    GetPage(
      name: businessEventDetailsScreen,
      page: () => const BusinessEventDetailsScreen(),
    ),
    GetPage(
      name: businessCatalogDetailsScreen,
      page: () => const BusinessCatalogDetailsScreen(),
    ),
    GetPage(
      name: createBusinessProductScreen,
      page: () => const CreateBusinessProductScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<CreateBusinessProductController>()) {
          Get.delete<CreateBusinessProductController>();
        }
        Get.put(CreateBusinessProductController());
      }),
    ),
    GetPage(
      name: createBusinessServiceScreen,
      page: () => const CreateBusinessServiceScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<CreateBusinessServiceController>()) {
          Get.delete<CreateBusinessServiceController>();
        }
        Get.put(CreateBusinessServiceController());
      }),
    ),
    GetPage(
      name: createBusinessEventScreen,
      page: () => const CreateBusinessEventScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<CreateBusinessEventController>()) {
          Get.delete<CreateBusinessEventController>();
        }
        Get.put(CreateBusinessEventController());
      }),
    ),
    GetPage(
      name: createBusinessPostScreen,
      page: () => const CreateBusinessPostScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<CreateBusinessPostController>()) {
          Get.delete<CreateBusinessPostController>();
        }
        Get.put(CreateBusinessPostController());
      }),
    ),
    GetPage(
      name: editBusinessScreen,
      page: () => const EditBusinessScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<EditBusinessController>()) {
          Get.delete<EditBusinessController>();
        }
        Get.put(EditBusinessController());
      }),
    ),
    GetPage(
      name: searchScreen,
      page: () => const SearchScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<HomeSearchController>()) {
          Get.delete<HomeSearchController>();
        }
        Get.put(HomeSearchController());
      }),
    ),
    GetPage(
      name: notificationsInboxScreen,
      page: () => const NotificationsScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<NotificationsController>()) {
          Get.delete<NotificationsController>();
        }
        Get.put(NotificationsController());
      }),
    ),
    GetPage(
      name: messagesScreen,
      page: () => const MessagesScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => MessagesController(), fenix: true)),
    ),
    GetPage(
      name: chatScreen,
      page: () => const ChatScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<ChatController>()) {
          Get.delete<ChatController>();
        }
        Get.put(ChatController());
      }),
    ),
  ];
}
