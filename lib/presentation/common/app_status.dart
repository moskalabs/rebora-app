import 'package:flutter/material.dart';

class AppStatus {
  final _recruitmentStatus = {
    "CONFIRMATION" : {
      "color" : const Color.fromRGBO(50, 195, 225, 1),
      "title" : "상영확정"
    },
    "CONFIRMATION_DAY" : {
      "color" : const Color.fromRGBO(50, 195, 225, 1),
      "title" : "상영확정"
    },
    "COMPLETED" : {
      "color" : const Color.fromRGBO(174, 174, 174, 1),
      "title" : "상영완료"
    },
    "RECRUITING" : {
      "color" : const Color.fromRGBO(138, 94, 255, 1),
      "title" : "모집중"
    },
    "DAY" : {
      "color" : const Color.fromRGBO(255, 255, 255, 1),
      "fontColor" : const Color.fromRGBO(117, 117, 117, 1),
      "title" : "D-"
    },
    "DAY3" : {
      "color" : const Color.fromRGBO(255, 127, 34, 1),
      "fontColor" : const Color.fromRGBO(255, 255, 255, 1),
      "title" : "D-3"
    },
    "PARTICIPATE" : {
      "color" : const Color.fromRGBO(255, 127, 34, 1),
      "fontColor" : const Color.fromRGBO(255, 255, 255, 1),
      "title" : "참여가능"
    },
    "OVER_DAY" : {
      "color" : const Color.fromRGBO(174, 174, 174, 1),
      "fontColor" : const Color.fromRGBO(255, 255, 255, 1),
      "title" : "마감"
    },
    "CANCEL" : {
      "color" : const Color.fromRGBO(174, 174, 174, 1),
      "fontColor" : const Color.fromRGBO(255, 255, 255, 1),
      "title" : "상영취소"
    }
  };

  String getRecruitmentTitle(String key) {
    var data = _recruitmentStatus[key];
    if (data == null) return "";
    return data["title"] as String;
  }

  Color getRecruitmentColor(String key) {
    var data = _recruitmentStatus[key];
    if (data == null) return const Color.fromRGBO(255, 255, 225, 1);
    return data["color"] as Color;
  }

  Color getRecruitmentFontColor(String key) {
    var data = _recruitmentStatus[key];
    if (data == null) return const Color.fromRGBO(255, 255, 225, 1);
    return data["fontColor"] as Color;
  }

  String getRecruitmentEndDayTitle(int day, int confirmationDay, String key, bool overFull) {
    var status = _recruitmentEndDayStatus(day, confirmationDay, key, overFull);
    if (status == "DAY") {
      return "${getRecruitmentTitle(status)}$day";
    }
    return getRecruitmentTitle(status);
  }

  String getRecruitmentEndDayViewTitle(int day, int confirmationDay, String key, bool overFull) {
    var status = recruitmentViewEndDayStatus(day, confirmationDay, key, overFull);
    if (status == "DAY") {
      return "${getRecruitmentTitle(status)}$day";
    }
    return getRecruitmentTitle(status);
  }

  Color getRecruitmentEndDayColor(int day, int confirmationDay, String key, bool overFull) {
    var status = _recruitmentEndDayStatus(day,confirmationDay, key, overFull);
    return getRecruitmentColor(status);
  }

  Color getRecruitmentViewEndDayColor(int day, int confirmationDay, String key, bool overFull) {
    var status = recruitmentViewEndDayStatus(day, confirmationDay, key, overFull);
    return getRecruitmentColor(status);
  }

  Color getRecruitmentEndDayFontColor(int day, int confirmationDay, String key, bool overFull) {
    var status = _recruitmentEndDayStatus(day, confirmationDay, key, overFull);
    return getRecruitmentFontColor(status);
  }

  String _recruitmentEndDayStatus(int day, int confirmationDay, String status, bool overFull) {

    if (status == "CONFIRMATION" && overFull) {
      return "OVER_DAY";
    }

    if (status == "CONFIRMATION" && confirmationDay <= 0) {
      return "OVER_DAY";
    }

    if (status == "CONFIRMATION") {
      return "PARTICIPATE";
    }

    if (day > 3) {
      return "DAY";
    }

    if (day <= 3 && day >= 0) {
      return "DAY3";
    }

    return "OVER_DAY";
  }

  String recruitmentViewEndDayStatus(int day, int confirmationDay, String status, bool overFull) {

    if (status == "CONFIRMATION" && overFull) {
      return "OVER_DAY";
    }

    if (status == "CONFIRMATION" && confirmationDay <= 0) {
      return "OVER_DAY";
    }

    if (status == "CONFIRMATION") {
      return "CONFIRMATION_DAY";
    }

    if (day > 3) {
      return "RECRUITING";
    }

    if (day <= 3 && day >= 0) {
      return "RECRUITING";
    }

    return "OVER_DAY";
  }

  String payStatus(String status) {
    if (status == "COMPLETE") {
      return "결제완료";
    } else if (status == "COMPLETE") {
      return "결제취소";
    } else {
      return "결제실패";
    }

  }
}