import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:rebora/domain/usecase/user_usecase.dart';
import 'package:rebora/presentation/common/const.dart';
import 'package:rebora/presentation/common/data_singleton.dart';
import 'package:rebora/presentation/common/ui/app_toast.dart';
import 'package:rebora/presentation/dialog/custom_dialog.dart';
import 'package:rebora/presentation/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateController extends SuperController {

  ProfileUpdateController({
    required this.userUseCase
  });

  late BuildContext context;
  final UserUseCase userUseCase;

  var isLoading = false.obs;

  var selectImage = "".obs;
  var userProfile = "".obs;
  var nickName = "";
  var name = "".obs;
  var email = "".obs;
  var userId = 0;


  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final changePasswordController = TextEditingController();
  final changeConfirmPasswordController = TextEditingController();


  AppToast appToast = AppToast();
  alertOkCallBack() => {
    Navigator.of(context).pop(),
  };

  void setContext(BuildContext context) {
    this.context = context;
  }

  alertWithdrawalCallBack() => {
    Navigator.of(context).pop(),
    _withdrawalPrc(),
  };

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  getProfile() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    userUseCase.findProfile().then((value) {
      isLoading.value = false;
      if (value.result) {
        prefs.setString(AppConst.NICKNAME,value.userNickname);
        prefs.setString(AppConst.PROFILE_IMAGE,value.userImage);

        DataSingleton.nickName = value.userNickname;
        DataSingleton.profile = value.userImage;

        userId = value.id;
        nickName = value.userNickname;
        emailController.text = value.userEmail;
        nameController.text = value.userName;
        nickNameController.text = value.userNickname;
        userProfile.value = value.userImage;
      }
    });
  }

  getImage() async {
    selectImage.value = "";
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if ( image != null) {
      selectImage.value = image.path;
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        maxHeight: 500,
        maxWidth: 500,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 75,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: const Color.fromRGBO(138, 94, 255, 1),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile != null) {
        selectImage.value = croppedFile.path;
      }
    }
  }

  updateProfile() {
    if (isLoading.value) return;
    var isUpdateCheck = true;
    isUpdateCheck = nickNameCheck();
    if (!isUpdateCheck) {
      isLoading.value = false;
      return;
    }

    isUpdateCheck = passwordCheck();
    if (!isUpdateCheck) {
      isLoading.value = false;
      return;
    }

    var isUpdate = false;
    Map<String,dynamic> data = {};
    if (selectImage.value != "") {
      data["filePath"] = selectImage.value;
      isUpdate = true;
    }

    if (nickName != nickNameController.text) {
      data["userNickname"] = nickNameController.text;
      isUpdate = true;
    }

    if (changePasswordController.text != "") {
      data["currentPassword"] = currentPasswordController.text;
      data["changePassword"] = changePasswordController.text;
      isUpdate = true;
    }

    if (!isUpdate) return;
    isLoading.value = true;

    userUseCase.profileUpdate("$userId", data).then((value) {
      isLoading.value = false;
      if (value.result) {
        appToast.show("적용이 완료 되었습니다.");
        getProfile();
      } else {
        var message = value.message;
        if (message == "") {
          message = "회원 정보 수정에 실패하였습니다.\n증상이 계속되면 고객센터로 문의하세요";
        }
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialog(
                title: message,
                okText: "확인",
                okCallBack: alertOkCallBack,
              );
            }
        );
      }
    });

  }

  bool nickNameCheck() {
    if (nickNameController.text == nickName
      || nickNameController.text == "" ) {
      return true;
    }

    RegExp basicReg = RegExp(r"^[ㄱ-ㅎ가-힣0-9a-zA-Z\s+]*$");
    if (!basicReg.hasMatch(nickNameController.text)) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "특수문자나 이모지는 사용하실 수 없습니다.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return false;
    }
    return true;
  }

  bool passwordCheck() {
    var changePassword = changePasswordController.text;
    if (changePasswordController.text == "") {
      return true;
    }
    if (changePassword != "" && currentPasswordController.text == "") {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "기존 비밀번호를 입력해주세요.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return false;
    }

    RegExp basicReg = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]$');

    var lengthCheck = (changePassword.length < 8);

    if (lengthCheck && !basicReg.hasMatch(changePassword)) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "비밀번호 규칙에 맞지 않습니다.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return false;
    }

    if (changeConfirmPasswordController.text == "") {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "변경할 비밀번호를 한번더 입력해주세요.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return false;
    }

    if (changeConfirmPasswordController.text != changePasswordController.text) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialog(
              title: "변경할 비밀번호가 맞지 않습니다.\n다시 한번 확인해주세요.",
              okText: "확인",
              okCallBack: alertOkCallBack,
            );
          }
      );
      return false;
    }

    return true;
  }

  withdrawal() {
    showDialog(context: context,
        builder: (BuildContext context){
          return CustomDialog(
            title: "정말 회원탈퇴 하시겠습니까?",
            descriptions: "회원탈퇴를 할 경우 모집글과,댓글을 제외한 모든 데이터가 삭제되며 동일한 계정으로 다시 가입이 불가능합니다.",
            okText: "확인",
            okCallBack: alertWithdrawalCallBack,
            cancelText: "취소",
            cancelCallBack: alertOkCallBack,
          );
        }
    );
  }

  _withdrawalPrc() {

    isLoading.value = true;
    userUseCase.withdrawal("$userId").then((value) async {
      isLoading.value = false;
      if(value.result) {

        final prefs = await SharedPreferences.getInstance();
        prefs.setString(AppConst.LOGIN_TOKEN,"");
        prefs.setString(AppConst.NICKNAME,"");
        prefs.setString(AppConst.PROFILE_IMAGE,"");

        DataSingleton.token = "";
        DataSingleton.nickName = "";
        DataSingleton.profile = "";

        Get.offAllNamed(Routes.LOGIN);

      } else {

        var message = value.message;
        if (message == "") {
          message = "회원 탈퇴에 실패하였습니다.\n증상이 계속되면 고객센터로 문의하세요";
        }

        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialog(
                title: message,
                okText: "확인",
                okCallBack: alertOkCallBack,
              );
            }
        );
      }
    });
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

}