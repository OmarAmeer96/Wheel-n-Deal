import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class TermsViewBody extends StatelessWidget {
  const TermsViewBody({super.key});

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
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Terms & Conditions \n\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text:
                            "By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app.\n\nYou’re not allowed to copy or modify the app, any part of the app,or our trademarks in any way.\nYou’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions.\nThe app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Wheel N' Deal.\n\nWheel N' Deal is committed to ensuring that the app is as useful and efficient as possible. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.\n\nThe Wheel N' Deal app stores and processes personal data that you have provided to us, to provide our Service.\nIt’s your responsibility to keep your phone and access to the app secure.\nWe therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Wheel N' Deal app won’t work properly or at all.\n\nThe app does use third-party services that declare their Terms and Conditions.\n Link to Terms and Conditions of third-party service providers used by the app Google Play Services.\n\nYou should be aware that there are certain things that Wheel N' Deal will not take responsibility for.\n Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider,\n but Wheel N' Deal cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.\n If you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region ) without turning off data roaming.\n If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\n\nAlong the same lines, Wheel N' Deal cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service,\n Wheel N' Deal cannot accept responsibility. With respect to Wheel N' Deal’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you.\n Wheel N' Deal accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.\n At some point, we may wish to update the app. The app is currently available on Android & iOS – the requirements for the both systems(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app.\n Wheel N' Deal does not promise that it will always update the app so that it is relevant to you and/or works with the Android & iOS version that you have installed on your device.\n",
                        style: Styles.manropeMedium18.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
