import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolices extends StatelessWidget {
  PrivacyPolices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorId.white,
        iconTheme: IconThemeData(color: colorId.black),
        title: Text(
          '''Privacy polices''',
          style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: colorId.btnColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const SizedBox(height: 15),
              Text(
                  '''Vivek Kurupath built the Pocket app as a Free app. This SERVICE is provided by Vivek Kurupath at no cost and is intended for use as is.
This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.
If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service.
I will not use or share your information with anyone except as described in this Privacy Policy.
The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Pocket unless otherwise defined in this Privacy Policy.''',
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.w400)),
              const SizedBox(height: 15),
              //^  heading  Information Collection and Use
              Text("""Information Collection and Use""",
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: colorId.btnColor)),
              Text(
                  """For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.
The app does use third-party services that may collect information used to identify you.
Link to the privacy policy of third-party service providers used by the app
Google Play Services""",
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.w400)),
              //^  heading - Log Data
              Text("Log Data",
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: colorId.btnColor)),
              Text(
                  """I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.""",
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.w400)),
              //^  heading - Cookies

              Text("Cookies",
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: colorId.btnColor)),
              Text(
                  """Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.
      This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.""",
                  style: GoogleFonts.lato(
                     fontSize: 15, fontWeight: FontWeight.w400)),
              //^  heading - Service Providers
              Text("Service Providers",
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: colorId.btnColor)),
              Text(
                  """ I may employ third-party companies and individuals due to the following reasons:
      * To facilitate our Service;
      * To provide the Service on our behalf;
      * To perform Service-related services; or
      * To assist us in analyzing how our Service is used.
      I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.""",
                  style: GoogleFonts.lato(
                     fontSize: 15, fontWeight: FontWeight.w400)),
              //^  heading - Contact Us
              Text("Contact Us",
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: colorId.btnColor)),
              Text(
                  """If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at codemygallery@gmail.com.
      This privacy policy page was created at privacypolicytemplate.net and modified/generated by App Privacy Policy Generator""",
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.w400))
            ],
          ),
        ),
      ),
    );
  }

  final colorId = ColorsID();
}
