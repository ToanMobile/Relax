import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/viewmodel/home_model.dart';
import 'package:relax/viewmodel/login_model.dart';

import 'base_repository.dart';

class LoginRegisterRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final CollectionReference infoCollection = Firestore.instance.collection('firstInfos');
  static final CollectionReference driverCollection = Firestore.instance.collection('driverInfos');
  static var verificationId = '';

  // static List<LoginEntity> listUser() => JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preListUser));
  static Future login(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user ?? null;
    await infoCollection.document(user.uid).get().then((value) {
      LoginEntity loginEntity = LoginEntity().fromJson(value.data);
      loginEntity.uid = user.uid;
      StorageManager.sharedPreferences.setBool(LoginModel.preIsLogin, true);
      StorageManager.saveObject(LoginModel.preLoginUser, loginEntity);
    });
  }

  static Future<ROLE> checkRegisterDriver(String uid, int role) async {
    ROLE data;
    await driverCollection.document(uid).get().then(
      (value) {
        if (value.data != null && value.data['driver_status'] == "0") {
          if (role == Constant.role_shipper) {
            data = ROLE.SHIPPER;
          } else if (role == Constant.role_driver) {
            data = ROLE.DRIVER;
          } else if (role == Constant.role_shipper_driver) {
            data = ROLE.DRIVER_SHIPPER;
          }
        } else if (role != Constant.role_shipper) {
          data = ROLE.CAPTURE;
        } else {
          data = ROLE.SHIPPER;
        }
      },
    );
    printLog('checkRegisterDriver:' + data.toString());
    return data;
  }

  static Future register(String name, String email, String password, String address, String phone, int role) async {
    AuthResult result;
    try {
      result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, s) {
      printLog(e.toString());
    }
    LoginEntity loginEntity = LoginEntity();
    loginEntity.name = name;
    loginEntity.email = email;
    loginEntity.address = address;
    loginEntity.role = role;
    loginEntity.tel = phone;
    if (result == null) {
      result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      var customerId = 0;
      var customer = Firestore.instance.collection('customerId').document("1");
      await customer.get().then((value) => {customerId = value.data['customer_id']});
      FirebaseUser user = result.user;
      loginEntity.uid = user.uid;
      loginEntity.customer_id = customerId;
      await customer.updateData(<String, dynamic>{
        'customer_id': customerId + 1,
      });
      await infoCollection.document(user.uid).setData(loginEntity.toJson());
    } else {
      //case đã tồn tại user này
      await infoCollection.document(result.user.uid).updateData(loginEntity.toJson());
    }
    printLog('register:loginEntity=' + loginEntity.toString());
    StorageManager.sharedPreferences.setBool(LoginModel.preIsLogin, true);
    StorageManager.saveObject(LoginModel.preLoginUser, loginEntity);
  }

  static Future<String> sendOtp(String phone) async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      verificationId = verId;
    };
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      // PHONE NUMBER TO SEND OTP
      codeAutoRetrievalTimeout: (String verId) {
        //Starts the phone number verification process for the given phone number.
        //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
        //this.verificationId = verId;
      },
      codeSent: smsOTPSent,
      // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
      timeout: const Duration(seconds: 20),
      verificationCompleted: (AuthCredential phoneAuthCredential) {
        print(phoneAuthCredential);
        return verificationId;
      },
      verificationFailed: (AuthException exceptio) {
        print('${exceptio.message}');
        return '';
      },
    );
    return '';
  }

  static Future<bool> verifyOtp(String otp) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: otp,
    );
    print('otp=' + otp);
    print('verificationId=' + verificationId);
    final AuthResult user = await _auth.signInWithCredential(credential);
    final FirebaseUser currentUser = await _auth.currentUser();
    if (user.user.uid == currentUser.uid) {
      return true;
    } else {
      return false;
    }
  }

  static Future logout() async {
    await StorageManager.sharedPreferences.clear();
    await _auth.signOut();
  }

  static void printLog(dynamic data) {
    BaseRepository.logger.e(data);
  }
}
