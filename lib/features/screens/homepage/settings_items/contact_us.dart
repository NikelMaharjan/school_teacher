




import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../api.dart';
import '../../../../constants/colors.dart';
import '../../../authentication/providers/auth_provider.dart';
import '../../../services/school_info_services.dart';

class ContactUs extends ConsumerStatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  ConsumerState<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends ConsumerState<ContactUs> {

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  Future<void> _redirect(String website) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      path: website,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {

    final auth = ref.watch(authProvider);
    final schoolData = ref.watch(schoolInfo(auth.user.token));
    final otherInfo = ref.watch(schoolContactInfo(auth.user.token));

    return Scaffold(
      backgroundColor: Colors.white,
      body: schoolData.when(
          data: (data){
            final school_info = data.firstWhere((element) => element.id == 1);
            return otherInfo.when(
                data: (details){
                  // final details = other_data.firstWhere((element) => element.schoolCollege==);
                  return
                    Column(
                      children: [

                        Container(

                          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                          height: MediaQuery.of(context).size.height*3.5/5,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text('Contact Us',style: TextStyle(color: Colors.black,fontSize: 30.sp,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10.h,),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,


                                ),

                                SizedBox(height: 10.h,),

                                IconTextRow(
                                    title: 'Email',
                                    icon: Icons.person,
                                    text: details.first.email,
                                  onTap: (){
                                      _makeEmail(details.first.email);
                                  },
                                ),
                                SizedBox(height: 20.h,),
                                IconTextRow(
                                    title: 'Phone Number',
                                    icon: Icons.phone,
                                    text: details.first.phoneNumber,
                                  onTap: (){
                                      _makePhoneCall(details.first.phoneNumber);
                                  },
                                ),
                                SizedBox(height: 20.h,),
                                IconTextRow(
                                  title: 'Website',
                                  icon: Icons.link,
                                  text: details.first.website??'',
                                  onTap: (){
                                    _redirect(details.first.website!);
                                  },
                                )


                              ],
                            ),
                          ),

                        ),
                      ],
                    );
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () =>
                    Center(child: CircularProgressIndicator())
            );
          },
          error: (err, stack) => Center(child: Text('$err')),
          loading: () =>
              Center(child: CircularProgressIndicator())
      ),



    );
  }
}


