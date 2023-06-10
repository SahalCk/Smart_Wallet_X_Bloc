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
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              height: mediaquery.size.height * 0.04,
                            ),
                            const Text(
                              "1. Information We Collect \n\n1.1 Personal Information: We may collect personal information such as your name, email address, phone number, and other relevant details when you voluntarily provide it to us. This information is necessary for the functionality of the App and to provide you with the services you request.\n1.2 Sensitive Data: The App may collect sensitive data, such as credit/debit card details, ID card details, and bank details, only for the purpose of securely storing and managing this information within your mobile device. We do not have access to or store this sensitive data, as it is encrypted and stored solely on your device.",
                              style: TextStyle(fontSize: 16),
                            ),
                            const Text(
                              '\n\n2. Use of Information\n\n2.1 We use the information collected to show the datas in your own SmartWalletX App.',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Text(
                              '\n\n3. Data Security\n\n3.1 We take the security of your personal information seriously and implement reasonable measures to protect it. The App utilizes encryption techniques to secure and protect your sensitive data within your mobile device.\n3.2 While we strive to ensure the security of your data, no method of transmission or storage over the internet or mobile device is completely secure. Therefore, we cannot guarantee the absolute security of your information.',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Text(
                                "\n4. User Contacts \n\n4.1 Our mobile application requires access to your contacts to provide you with the ability to easily access and communicate with your contacts. We will only access and use the contact information for the intended purpose and functionality of the application. We do not collect or store your contact information on our servers.",
                                style: TextStyle(fontSize: 16)),
                            const Text(
                                "\n5. Camera \n\n5.1 Our mobile application may require access to your device's camera to provide certain features or functionality. We will only access and use the camera for the intended purposes, such as capturing photos or videos within the application. We do not collect or store any media captured through the camera on our servers without your explicit consent.",
                                style: TextStyle(fontSize: 16)),
                            const Text(
                                "\n6. Biometric Information \n\n6.1 Our mobile application offer a biometric lock feature for login or authentication purposes. If you choose to enable this feature, we may collect and use your biometric information, such as fingerprints or facial recognition data, solely for the purpose of providing secure access to the application. We do not store or transfer this biometric information to any third parties.",
                                style: TextStyle(fontSize: 16)),
                            const Text(
                                "\n7. Read/Write Storage \n\n7.1 Our mobile application requires access to your device's storage to store and retrieve data necessary for the application's functionality. We may collect and store data files, such as user preferences or locally cached content, on your device's storage. We do not access, read, or transfer any personal or sensitive information stored on your device without your consent.",
                                style: TextStyle(fontSize: 16)),
                            const Text(
                              '\n\n8. Changes to the Privacy Policy\n\n8.1 The Developer reserves the right to update or modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the updated Privacy Policy on the App. You are encouraged to review this Privacy Policy periodically to stay informed of any changes.',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Text(
                              '\n\n9. Contact Us\n\n9.1 If you have any questions, concerns, or requests regarding this Privacy Policy or the handling of your personal information, please contact us at sahalck001gmail.com.\n\nBy using the App, you acknowledge that you have read, understood, and agree to the terms and practices described in this Privacy Policy.',
                              style: TextStyle(fontSize: 16),
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
