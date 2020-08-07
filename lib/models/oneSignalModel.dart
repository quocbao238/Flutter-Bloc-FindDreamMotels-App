import 'dart:convert';

OneSignalSendReq oneSignalSendReqFromJson(String str) => OneSignalSendReq.fromJson(json.decode(str));

String oneSignalSendReqToJson(OneSignalSendReq data) => json.encode(data.toJson());

class OneSignalSendReq {
    OneSignalSendReq({
        this.appId,
        this.headings,
        this.contents,
        this.subtitle,
        this.iosAttachments,
        this.includeExternalUserIds,
        this.largeIcon,
        this.smallIcon,
    });

    final String appId;
    final Contents headings;
    final Contents contents;
    final Contents subtitle;
    final IosAttachments iosAttachments;
    final List<String> includeExternalUserIds;
    final String largeIcon;
    final String smallIcon;

    factory OneSignalSendReq.fromJson(Map<String, dynamic> json) => OneSignalSendReq(
        appId: json["app_id"] == null ? null : json["app_id"],
        headings: json["headings"] == null ? null : Contents.fromJson(json["headings"]),
        contents: json["contents"] == null ? null : Contents.fromJson(json["contents"]),
        subtitle: json["subtitle"] == null ? null : Contents.fromJson(json["subtitle"]),
        iosAttachments: json["iosAttachments"] == null ? null : IosAttachments.fromJson(json["iosAttachments"]),
        includeExternalUserIds: json["include_external_user_ids"] == null ? null : List<String>.from(json["include_external_user_ids"].map((x) => x)),
        largeIcon: json["large_icon"] == null ? null : json["large_icon"],
        smallIcon: json["small_icon"] == null ? null : json["small_icon"],
    );

    Map<String, dynamic> toJson() => {
        "app_id": appId == null ? null : appId,
        "headings": headings == null ? null : headings.toJson(),
        "contents": contents == null ? null : contents.toJson(),
        "subtitle": subtitle == null ? null : subtitle.toJson(),
        "iosAttachments": iosAttachments == null ? null : iosAttachments.toJson(),
        "include_external_user_ids": includeExternalUserIds == null ? null : List<dynamic>.from(includeExternalUserIds.map((x) => x)),
        "large_icon": largeIcon == null ? null : largeIcon,
        "small_icon": smallIcon == null ? null : smallIcon,
    };
}

class Contents {
    Contents({
        this.en,
    });

    final String en;

    factory Contents.fromJson(Map<String, dynamic> json) => Contents(
        en: json["en"] == null ? null : json["en"],
    );

    Map<String, dynamic> toJson() => {
        "en": en == null ? null : en,
    };
}

class IosAttachments {
    IosAttachments({
        this.id1,
    });

    final String id1;

    factory IosAttachments.fromJson(Map<String, dynamic> json) => IosAttachments(
        id1: json["id1"] == null ? null : json["id1"],
    );

    Map<String, dynamic> toJson() => {
        "id1": id1 == null ? null : id1,
    };
}
