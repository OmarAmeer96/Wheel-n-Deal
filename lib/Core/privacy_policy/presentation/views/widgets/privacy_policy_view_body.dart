import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyViewBody extends StatelessWidget {
  const PrivacyPolicyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Privacy Policy \n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: "The ",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "Wheel N' Deal",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: " app as a Free app.\n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text:
                            "This page is used to inform visitors regarding our policies with the collection, use, and  disclosure of Personal Information if anyone decided to use our Service.\n\nIf you choose to use our Service, then you  agree to the collection and use of information in relation to this policy.\nThe Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.\n\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Wheel N' Deal unless otherwise defined in this Privacy Policy.\n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "Information Collection and Use\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            "For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information. The information that we request will be retained by us and used as described in this privacy policy.\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await launchUrl(Uri.parse(
                        "https://support.google.com/googleplay/answer/9037938?hl=en"));
                  },
                  child: Text(
                    "Google Play Services",
                    style: Styles.manropeMedium18.copyWith(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "\nLog Data \n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            "We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data.\nThis Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service.\n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "\nSecurity \n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.\n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "\nLinks to Other Sites \n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site.\n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "\nCancel The Orders \n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            "In case you are a client: If the order is canceled by you after some commuter picks it up The cancellation tax will be deducted But if the order was canceled by you and the commuter has not chosen it yet Nothing will be deducted.\n\nIn case you are commuter: If the order is canceled by you shortly before the specified time, all the money will be returned to the customer and you will not get any of the profits.\n\nService cost: The cost of the service depends on distances and time. A 5% profit percentage is taken for the application account from the total service value.\n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "\nChanges to This Privacy Policy \n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.\nThis policy is effective as of 2023-12-12.\n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "\nContact Us \n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at ",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "wheelndeal24@gmail.com\n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: "This privacy policy page was created at ",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "privacypolicytemplate.net\n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: "and modified/ generated by ",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "App Privacy Policy Generator\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
