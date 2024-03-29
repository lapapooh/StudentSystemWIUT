import 'package:flutter/material.dart';
import 'package:student_system_flutter/pages/app_updates_page.dart';
import 'package:student_system_flutter/pages/attendance_page.dart';
import 'package:student_system_flutter/pages/books_page.dart';
import 'package:student_system_flutter/pages/ccm_add_feedback_page.dart';
import 'package:student_system_flutter/pages/ccm_feedback_category_page.dart';
import 'package:student_system_flutter/pages/ccm_feedback_su_page.dart';
import 'package:student_system_flutter/pages/ccm_role_select_page.dart';
import 'package:student_system_flutter/pages/contacts_page.dart';
import 'package:student_system_flutter/pages/coursework_upload_page.dart';
import 'package:student_system_flutter/pages/feedback_reply_page.dart';
import 'package:student_system_flutter/pages/file_downloader_page.dart';
import 'package:student_system_flutter/pages/file_picker_page.dart';
import 'package:student_system_flutter/pages/files_downloaded_page.dart';

import 'package:student_system_flutter/pages/home_page.dart';
import 'package:student_system_flutter/pages/iOS_pages/contacts_page_ios.dart';
import 'package:student_system_flutter/pages/learning_materials_page.dart';
import 'package:student_system_flutter/pages/login_page.dart';
import 'package:student_system_flutter/pages/map_page.dart';
import 'package:student_system_flutter/pages/marks_page.dart';
import 'package:student_system_flutter/pages/new_post_page.dart';
import 'package:student_system_flutter/pages/offences_page.dart';
import 'package:student_system_flutter/pages/offline_page.dart';
import 'package:student_system_flutter/pages/preview_page.dart';
import 'package:student_system_flutter/pages/security_page.dart';
import 'package:student_system_flutter/pages/settings_page.dart';
import 'package:student_system_flutter/pages/social_myposts_page.dart';
import 'package:student_system_flutter/pages/social_page.dart';
import 'package:student_system_flutter/pages/social_search_page.dart';
import 'package:student_system_flutter/pages/support_page.dart';
import 'package:student_system_flutter/pages/test_page2.dart';
import 'package:student_system_flutter/pages/timetable_page.dart';
import 'package:student_system_flutter/pages/timetable_picker_ios.dart';
import 'package:student_system_flutter/pages/tips_and_tricks_list_page.dart';
import 'package:student_system_flutter/pages/tips_tricks_page.dart';

import 'app_constants.dart';

final routes = {
  '/': (BuildContext context) => LoginPage(),
  loginPage: (BuildContext context) => LoginPage(),
  securityPage: (BuildContext context) => SecurityPage(),
  homePage: (BuildContext context) => HomePage(),
  marksPage: (BuildContext context) => MarksPage(),
  offencesPage: (BuildContext context) => OffencesPage(),
  socialPage: (BuildContext context) => SocialPage(),
  fileDownloaderPage: (BuildContext context) => FileDownloaderPage(),
  filesDownloadedPage: (BuildContext context) => FilesDownloadedPage(),
  tweetPage: (BuildContext context) => NewPostPage(),
  lecturesPage: (BuildContext context) => LearningMaterialsPage(),
  offlinePage: (BuildContext context) => OfflinePage(),
  courseworkUploadPage: (BuildContext context) => CourseworkUploadPage(),
  timetablePage: (BuildContext context) => TimetablePage(),
  filePickerPage: (BuildContext context) => FilePickerPage(),
  // commentsPage: (BuildContext context) => CommentsPage(),
  settingsPage: (BuildContext context) => SettingsPage(),
  contactsPage: (BuildContext context) => ContactsPage(),
  mapPage: (BuildContext context) => MapPage(),
  appUpdatesPage: (BuildContext context) => AppUpdatesPage(),
  booksPage: (BuildContext context) => BooksPage(),
  supportPage: (BuildContext context) => SupportPage(),
  iosContactsPage: (BuildContext context) => IosContactsPage(),
  previewPage: (BuildContext context) => PreviewPage(),
  ccmAddFeedbackPage: (BuildContext context) => CCMAddFeedBackPage(),
  testPage2: (BuildContext context) => FormDemo(),
  replyPage: (BuildContext context) => FeedbackReplyPage(),
  ccmCategoryPage: (BuildContext context) => CCMFeedbackCategoryPage(),
  ccmFeedbackForSUPage: (BuildContext context) => CCMFeedbackForSUPage(),
  timetablePickerIosPage: (BuildContext context) => TimetablePickerIosPage(),
  tipsTricksPage: (BuildContext context) => TipsAndTricksPage(),
  tipsTricksListPage: (BuildContext context) => TipsAndTricksListPage(),
  // videosPage: (BuildContext context) => VideoPage(),
  ccmRoleSelectPage: (BuildContext context) => CCMRoleSelectPage(),
  socialSearchPage: (BuildContext context) => SocialSearchPage(),
  socialMyPostsPage: (BuildContext context) => SocialMyPostsPage(),
  attendancePage: (BuildContext context) => AttendancePage(),
};
