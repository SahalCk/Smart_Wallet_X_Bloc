import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/widgets.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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
              'assets/back_arrow.png', ' Terms and Conditions', context),
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
                        'Welcome to Smart Wallet X. These Terms and Conditions outline the agreement between you ("User") and Sahal ("Developer") regarding the use of our mobile application ("App"). By installing, accessing, or using the App, you agree to be bound by these Terms and Conditions. Please read them carefully before proceeding.',
                        style: TextStyle(fontSize: 17)),
                    SizedBox(
                      height: mediaquery.size.height * 0.04,
                    ),
                    const Text(
                        '1. Acceptance of Terms \n\n1.1 By using the App, you acknowledge that you have read, understood, and agree to comply with these Terms and Conditions, as well as our Privacy Policy.\n1.2 If you do not agree with any provision of these Terms and Conditions, you must refrain from using the App.',
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n2. Purpose of the App \n\n2.1 The App aims to provide a platform for users to securely store and manage their sensitive data, such as credit/debit card details, ID card details, and bank details, within their mobile devices. \n2.2 The Developer does not have access to or store any user's sensitive data, as all data is encrypted and stored solely on the user's device.",
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n3. User Responsibilities \n\n3.1 You, as the User, are solely responsible for the accuracy, security, and confidentiality of the data you provide through the App. \n3.2 You are responsible for maintaining the security and confidentiality of your mobile device, including any login credentials associated with the App.",
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n4. Data Security and Encryption \n\n4.1 The App uses advanced encryption techniques (AES Algorithm) to secure and protect your sensitive data within your mobile device. \n4.2 The Developer takes reasonable measures to maintain the security of the App. However, no method of transmission or storage over the internet or mobile device is completely secure, and the Developer cannot guarantee the absolute security of your data. \n4.3 In the event of any unauthorized access or breach of data security, the Developer will promptly notify you and take appropriate measures to investigate and mitigate the situation.",
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n5. Limited Liability \n\n5.1 The Developer shall not be liable for any direct, indirect, incidental, consequential, or exemplary damages arising from the use or inability to use the App, including but not limited to any loss of data or unauthorized access to data. \n5.2 The Developer disclaims all warranties, whether express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, and non-infringement.",
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n6. User Contacts \n\n6.1 Our mobile application requires access to your contacts to provide you with the ability to easily access and communicate with your contacts. We will only access and use the contact information for the intended purpose and functionality of the application. We do not collect or store your contact information on our servers.",
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n7. Camera \n\n7.1 Our mobile application may require access to your device's camera to provide certain features or functionality. We will only access and use the camera for the intended purposes, such as capturing photos or videos within the application. We do not collect or store any media captured through the camera on our servers without your explicit consent.",
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n8. Biometric Information \n\n8.1 Our mobile application offer a biometric lock feature for login or authentication purposes. If you choose to enable this feature, we may collect and use your biometric information, such as fingerprints or facial recognition data, solely for the purpose of providing secure access to the application. We do not store or transfer this biometric information to any third parties.",
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n9. Read/Write Storage \n\n9.1 Our mobile application requires access to your device's storage to store and retrieve data necessary for the application's functionality. We may collect and store data files, such as user preferences or locally cached content, on your device's storage. We do not access, read, or transfer any personal or sensitive information stored on your device without your consent.",
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n10. User Conduct \n\n10.1 You agree to use the App in compliance with applicable laws, regulations, and these Terms and Conditions. \n11.2 You shall not use the App for any unlawful, fraudulent, or unauthorized purpose. \n11.3 You shall not attempt to reverse engineer, modify, or tamper with the App or its underlying technology.",
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n11. Intellectual Property Rights \n\n11.1 The App and all associated content, including but not limited to text, graphics, images, logos, and software, are the intellectual property of the Developer and are protected by copyright and other intellectual property laws. \n12.2 You are granted a limited, non-exclusive, non-transferable, revocable license to use the App solely for your personal, non-commercial purposes.",
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n12. Modification and Termination \n\n12.1 The Developer reserves the right to modify, suspend, or discontinue the App, or any part thereof, at any time without notice. \n12.2 The Developer may also modify these Terms and Conditions at any time. Your continued use of the App after any modifications constitute your acceptance of the revised Terms and Conditions.",
                        style: TextStyle(fontSize: 16)),
                    const Text(
                        "\n13. Contact Information \n\n13.1 If you have any questions, concerns, or feedback regarding these Terms and Conditions or the App, please contact us at sahalck001@gmail.com. \n\nBy using the App, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.",
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: mediaquery.size.height * 0.03,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
