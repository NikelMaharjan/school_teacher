




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../api.dart';
import '../../../../constants/colors.dart';
import '../../../authentication/providers/auth_provider.dart';
import '../../../services/school_info_services.dart';

class AboutUs extends ConsumerStatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  ConsumerState<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends ConsumerState<AboutUs> {


  @override
  Widget build(BuildContext context) {

    final auth = ref.watch(authProvider);
    final schoolData = ref.watch(schoolInfo(auth.user.token));
    final otherInfo = ref.watch(schoolOtherInfo(auth.user.token));
    final contactInfo = ref.watch(schoolContactInfo(auth.user.token));

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
                        school_info.coverPhoto != null ?
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
                          decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage('${Api.basePicUrl}${school_info.coverPhoto}'),fit: BoxFit.cover)
                          ),
// color: primary,
                          height: MediaQuery.of(context).size.height*1.5/5,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text('About Us',style: TextStyle(color: Colors.white,fontSize: 40.sp,fontWeight: FontWeight.bold),),
                          ),
                        )
                            :Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                          decoration: BoxDecoration(
                              color: primary
                          ),
// color: primary,
                          height: MediaQuery.of(context).size.height*1.5/5,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(school_info.name,style: TextStyle(color: Colors.white,fontSize: 40.sp,fontWeight: FontWeight.bold),),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                          height: MediaQuery.of(context).size.height*3.5/5,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 100.sp,
                                  backgroundImage: NetworkImage('${Api.basePicUrl}${school_info.logo}'),
                                ),
                                Text(school_info.name,style: TextStyle(color: Colors.black,fontSize: 30.sp,fontWeight: FontWeight.bold),),
                                Text( 'Est. ${DateFormat('yyy-MM-dd').format(school_info.establishedDate)}',style: TextStyle(color: Colors.black,fontSize: 20.sp),),
                                SizedBox(height: 10.h,),
                                Text( '\" ${details.first.schoolMotto} \" ',style: TextStyle(color: Colors.black,fontSize: 20.sp,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                  indent: 80.w,
                                  endIndent: 80.w,
                                ),

                                SizedBox(height: 10.h,),

                                Text(details.first.communityInvolvementInfo,style: TextStyle(color: Colors.black,fontSize: 18.sp),),
                                SizedBox(height: 10.h,),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Achievements',style: TextStyle(color: Colors.black,fontSize: 25.sp,fontWeight: FontWeight.bold),)),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),

                                Text(details.first.communityInvolvementInfo,style: TextStyle(color: Colors.black,fontSize: 18.sp),),


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


