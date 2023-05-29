import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/widgets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: mediaquery.size.height * 0.025,
            ),
            appbarwithouttrail(
                'assets/back_arrow.png', ' Privacy Policy', context),
            SizedBox(
              height: mediaquery.size.height * 0.03,
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mediaquery.size.width * 0.04),
                        child: Column(
                          children: [
                            const Text(
                              'Welcome to the Privacy Policy of Smart Wallet X ("App") provided by Sahal ("Developer"). This Privacy Policy outlines how we collect, use, and protect your personal information when you use our App. By using the App, you agree to the terms and practices described in this Privacy Policy.',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: mediaquery.size.height * 0.04,
                            ),
                            const Text(
                              "1. Information We Collect \n\n1.1 Personal Information: We may collect personal information such as your name, email address, phone number, and other relevant details when you voluntarily provide it to us. This information is necessary for the functionality of the App and to provide you with the services you request.\n1.2 Sensitive Data: The App may collect sensitive data, such as credit/debit card details, ID card details, and bank details, only for the purpose of securely storing and managing this information within your mobile device. We do not have access to or store this sensitive data, as it is encrypted and stored solely on your device.",
                              style: TextStyle(fontSize: 17),
                            ),
                            const Text(
                              '\n\n2. Use of Information\n\n2.1 We use the information collected to show the datas in your own SmartWalletX App.',
                              style: TextStyle(fontSize: 17),
                            ),
                            const Text(
                              '\n\n3. Data Security\n\n3.1 We take the security of your personal information seriously and implement reasonable measures to protect it. The App utilizes encryption techniques to secure and protect your sensitive data within your mobile device.\n3.2 While we strive to ensure the security of your data, no method of transmission or storage over the internet or mobile device is completely secure. Therefore, we cannot guarantee the absolute security of your information.',
                              style: TextStyle(fontSize: 17),
                            ),
                            const Text(
                              '\n\n4. Changes to the Privacy Policy\n\n4.1 The Developer reserves the right to update or modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the updated Privacy Policy on the App. You are encouraged to review this Privacy Policy periodically to stay informed of any changes.',
                              style: TextStyle(fontSize: 17),
                            ),
                            const Text(
                              '\n\n5. Contact Us\n\n5.1 If you have any questions, concerns, or requests regarding this Privacy Policy or the handling of your personal information, please contact us at sahalck001gmail.com.\n\nBy using the App, you acknowledge that you have read, understood, and agree to the terms and practices described in this Privacy Policy.',
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              height: mediaquery.size.height * 0.03,
                            )
                          ],
                        ))))
          ],
        ),
      ),
    );
  }
}
