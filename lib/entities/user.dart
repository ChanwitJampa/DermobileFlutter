class User {
  User({
    required this.data,
  });
  late final List<Data> data;

  User.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.trialId,
    this.aliasName,
    required this.trialActive,
    required this.trialStatus,
    required this.plotSettingAutoLockUpload,
    required this.plotSettingAutoLockApproved,
    required this.createDate,
    required this.lastUpdate,
    required this.plots,
  });
  late final String trialId;
  late final Null aliasName;
  late final String trialActive;
  late final String trialStatus;
  late final int plotSettingAutoLockUpload;
  late final int plotSettingAutoLockApproved;
  late final int createDate;
  late final int lastUpdate;
  late final List<Plots> plots;

  Data.fromJson(Map<String, dynamic> json) {
    trialId = json['trialId'];
    aliasName = null;
    trialActive = json['trialActive'];
    trialStatus = json['trialStatus'];
    plotSettingAutoLockUpload = json['plotSettingAutoLockUpload'];
    plotSettingAutoLockApproved = json['plotSettingAutoLockApproved'];
    createDate = json['createDate'];
    lastUpdate = json['lastUpdate'];
    plots = List.from(json['plots']).map((e) => Plots.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['trialId'] = trialId;
    _data['aliasName'] = aliasName;
    _data['trialActive'] = trialActive;
    _data['trialStatus'] = trialStatus;
    _data['plotSettingAutoLockUpload'] = plotSettingAutoLockUpload;
    _data['plotSettingAutoLockApproved'] = plotSettingAutoLockApproved;
    _data['createDate'] = createDate;
    _data['lastUpdate'] = lastUpdate;
    _data['plots'] = plots.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Plots {
  Plots({
    required this.plotId,
    required this.barcode,
    required this.pltId,
    required this.repNo,
    required this.abbrc,
    required this.entno,
    required this.notet,
    this.plotImgPath,
    this.plotImgPathS,
    this.plotImgBoxPath,
    this.plotImgBoxPathS,
    this.uploadDate,
    this.eartnA,
    this.dlernA,
    this.dlerpA,
    this.drwapA,
    this.eartnM,
    this.dlernM,
    this.dlerpM,
    this.drwapM,
    this.approveDate,
    required this.plotProgress,
    required this.plotStatus,
    required this.plotActive,
    required this.lastUpdate,
    this.ears,
    this.undetectears,
  });
  late final int plotId;
  late final String barcode;
  late final String pltId;
  late final int repNo;
  late final String abbrc;
  late final int entno;
  late final String notet;
  late final String? plotImgPath;
  late final String? plotImgPathS;
  late final String? plotImgBoxPath;
  late final String? plotImgBoxPathS;
  late final int? uploadDate;
  late final int? eartnA;
  late final int? dlernA;
  late final double? dlerpA;
  late final double? drwapA;
  late final int? eartnM;
  late final int? dlernM;
  late final int? dlerpM;
  late final int? drwapM;
  late final int? approveDate;
  late final String plotProgress;
  late final String plotStatus;
  late final String plotActive;
  late final int lastUpdate;
  late final Null ears;
  late final Null undetectears;

  Plots.fromJson(Map<String, dynamic> json) {
    plotId = json['plotId'];
    barcode = json['barcode'];
    pltId = json['pltId'];
    repNo = json['repNo'];
    abbrc = json['abbrc'];
    entno = json['entno'];
    notet = json['notet'];
    plotImgPath = null;
    plotImgPathS = null;
    plotImgBoxPath = null;
    plotImgBoxPathS = null;
    uploadDate = null;
    eartnA = null;
    dlernA = null;
    dlerpA = null;
    drwapA = null;
    eartnM = null;
    dlernM = null;
    dlerpM = null;
    drwapM = null;
    approveDate = null;
    plotProgress = json['plotProgress'];
    plotStatus = json['plotStatus'];
    plotActive = json['plotActive'];
    lastUpdate = json['lastUpdate'];
    ears = null;
    undetectears = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['plotId'] = plotId;
    _data['barcode'] = barcode;
    _data['pltId'] = pltId;
    _data['repNo'] = repNo;
    _data['abbrc'] = abbrc;
    _data['entno'] = entno;
    _data['notet'] = notet;
    _data['plotImgPath'] = plotImgPath;
    _data['plotImgPathS'] = plotImgPathS;
    _data['plotImgBoxPath'] = plotImgBoxPath;
    _data['plotImgBoxPathS'] = plotImgBoxPathS;
    _data['uploadDate'] = uploadDate;
    _data['eartnA'] = eartnA;
    _data['dlernA'] = dlernA;
    _data['dlerpA'] = dlerpA;
    _data['drwapA'] = drwapA;
    _data['eartnM'] = eartnM;
    _data['dlernM'] = dlernM;
    _data['dlerpM'] = dlerpM;
    _data['drwapM'] = drwapM;
    _data['approveDate'] = approveDate;
    _data['plotProgress'] = plotProgress;
    _data['plotStatus'] = plotStatus;
    _data['plotActive'] = plotActive;
    _data['lastUpdate'] = lastUpdate;
    _data['ears'] = ears;
    _data['undetectears'] = undetectears;
    return _data;
  }
}
