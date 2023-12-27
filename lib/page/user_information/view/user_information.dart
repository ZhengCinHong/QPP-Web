import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/common_ui/qpp_text/read_more_text.dart';
import 'package:qpp_example/common_ui/qpp_universal_link/universal_link_widget.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/user_information/view_model/user_information_view_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/constants/qpp_contanst.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_image_utils.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

/// 用戶資訊頁
class UserInformationOuterFrame extends StatefulWidget {
  const UserInformationOuterFrame(
      {super.key, required this.userID, required this.url});

  final String userID;
  final String url;

  @override
  State<UserInformationOuterFrame> createState() =>
      _UserInformationOuterFrameState();
}

class _UserInformationOuterFrameState extends State<UserInformationOuterFrame> {
  @override
  void initState() {
    super.initState();

    userInformationProvider =
        ChangeNotifierProvider<UserInformationChangeNotifier>((ref) {
      int? userID = int.tryParse(widget.userID);

      if (userID != null) {
        Future.microtask(() => ref.notifier.setUserID(userID));
        Future.microtask(() => ref.notifier.getUserInfo());
      }

      return UserInformationChangeNotifier();
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(toString());

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1280,
                child: LayoutBuilder(builder: (context, constraints) {
                  final bool isDesktopStyle = screenWidthWithoutContext()
                      .determineScreenStyle()
                      .isDesktop;

                  return Container(
                    constraints: const BoxConstraints(maxWidth: 1280),
                    padding: EdgeInsets.only(
                        top: isDesktopStyle
                            ? kToolbarDesktopHeight + 100
                            : kToolbarMobileHeight + 24,
                        bottom: isDesktopStyle ? 48 : 20,
                        left: 20,
                        right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        children: [
                          isDesktopStyle
                              ? const _AvatarWidget.desktop()
                              : const _AvatarWidget.mobile(),
                          isDesktopStyle
                              ? const _InformationDescriptionWidget.desktop()
                              : const _InformationDescriptionWidget.mobile(),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 24),
            child: UniversalLinkWidget(
              url: widget.url,
              mobileText: QppLocales.commodityInfoLaunchQPP,
            ),
          ),
        ],
      ),
    );
  }
}

// 頭像Widget
class _AvatarWidget extends ConsumerWidget {
  const _AvatarWidget.desktop() : screenStyle = ScreenStyle.desktop;
  const _AvatarWidget.mobile() : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint(toString());

    final isDesktopStyle = screenStyle == ScreenStyle.desktop;

    final userInformation = ref.watch(userInformationProvider);

    final userID = userInformation.userIDState.data;
    final qppUser = userInformation.infoState.data;

    /// 是否為官方帳號
    final isOfficial = qppUser?.isOfficial == true;

    /// 官方帳號Icon寬度
    final double officaialIconWidth = isDesktopStyle ? 28 : 16;

    final avaterIsError = userInformation.avaterIsError;
    final bgImageIsError = userInformation.bgImageIsError;

    return userID == null
        ? const SizedBox.shrink()
        : Container(
            height: isDesktopStyle ? 265 : 196,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: bgImageIsError
                    ? const AssetImage(
                        QPPImages.pic_commodity_largepic_sample_07,
                      ) as ImageProvider
                    : NetworkImage(userInformation.bgImage),
                onError: (exception, stackTrace) =>
                    userInformation.setImageState(
                        style: QppImageStyle.backgroundImage, isSuccess: false),
              ),
            ),
            child: Stack(
              children: [
                ModalBarrier(
                  color: Colors.black.withOpacity(0.5),
                  dismissible: false,
                ), // 遮罩
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: isDesktopStyle ? 36 : 24),
                      SizedBox(
                        width: isDesktopStyle ? 100 : 88,
                        height: isDesktopStyle ? 100 : 88,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent, // 設置透明背景
                          backgroundImage: avaterIsError
                              ? const AssetImage(
                                  QPPImages.mobile_image_newsfeed_avatar_large,
                                ) as ImageProvider
                              : NetworkImage(userInformation.avaterImage),
                          onBackgroundImageError: (exception, stackTrace) =>
                              userInformation.setImageState(isSuccess: false),
                        ),
                      ),
                      SizedBox(height: isDesktopStyle ? 29 : 12),
                      Text(
                        context.tr(
                          qppUser?.displayName ?? QppLocales.errorPageNickname,
                        ),
                        style: QppTextStyles.web_20pt_title_m_Indian_yellow_C,
                      ),
                      SizedBox(height: isDesktopStyle ? 6 : 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isOfficial
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Image.asset(
                                    qppUser?.officialIconPath ?? '',
                                    width: officaialIconWidth,
                                    scale: 1,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          Text(
                            userID.toString(),
                            style: isDesktopStyle
                                ? QppTextStyles.web_16pt_body_Indian_yellow_L
                                : QppTextStyles
                                    .mobile_14pt_body_Indian_yellow_L,
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
}

/// 資訊說明Widget
class _InformationDescriptionWidget extends ConsumerWidget {
  const _InformationDescriptionWidget.desktop()
      : screenStyle = ScreenStyle.desktop;
  const _InformationDescriptionWidget.mobile()
      : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint(toString());

    final isDesktopStyle = screenStyle.isDesktop;

    final moreStyle = isDesktopStyle
        ? QppTextStyles.web_16pt_body_category_text_L
        : QppTextStyles.mobile_14pt_body_category_text_L;
    final textStyle = isDesktopStyle
        ? QppTextStyles.web_16pt_body_platinum_L
        : QppTextStyles.mobile_14pt_body_platinum_L;
    final linkTextStyle = isDesktopStyle
        ? QppTextStyles.web_16pt_body_linktext_L
        : QppTextStyles.mobile_14pt_body_linktext_L;

    final response =
        ref.watch(userInformationProvider.select((value) => value.infoState));

    return Container(
      width: double.infinity,
      color: QppColors.oxfordBlue,
      child: Padding(
        padding: EdgeInsets.only(
          top: isDesktopStyle ? 45 : 16,
          bottom: isDesktopStyle ? 43 : 24,
          left: isDesktopStyle ? 60 : 18,
          right: isDesktopStyle ? 60 : 18,
        ),
        child: ReadMoreText(
          context
              .tr(response.data?.displayInfo ?? QppLocales.errorPageInfoNotyet),
          textAlign: TextAlign.start,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: '',
          trimCollapsedText: context.tr(QppLocales.commodityInfoMore),
          moreStyle: moreStyle,
          style: textStyle,
          linkTextStyle: linkTextStyle,
          onLinkPressed: (String url) {
            url.launchURL();
          },
        ),
      ),
    );
  }
}
