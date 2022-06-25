unit IOPCOM3Lib_TLB;

// ************************************************************************ //
// WARNING                                                                  //
// -------                                                                  //
// The types declared in this file were generated from data read from a     //
// Type Library. If this type library is explicitly or indirectly (via      //
// another type library referring to this type library) re-imported, or the //
// 'Refresh' command of the Type Library Editor activated while editing the //
// Type Library, the contents of this file will be regenerated and all      //
// manual modifications will be lost.                                       //
// ************************************************************************ //

// PASTLWTR : $Revision:   1.11.1.63  $
// File generated on 2005.03.13 05:17:16 PM from Type Library described below.

// ************************************************************************ //
// Type Lib: C:\Program Files\Schlumberger\Smart Cards and Terminals\Cyberflex Access Kits\v4\iopCOM3.dll
// IID\LCID: {05B5AE1E-F0B6-11D4-8DE3-00B0D021D545}\0
// Helpfile: 
// HelpString: Schlumberger IOP COM 3.0 Type Library
// Version:    1.0
// ************************************************************************ //

interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:      //
//   Type Libraries     : LIBID_xxxx                                    //
//   CoClasses          : CLASS_xxxx                                    //
//   DISPInterfaces     : DIID_xxxx                                     //
//   Non-DISP interfaces: IID_xxxx                                      //
// *********************************************************************//
const
  LIBID_IOPCOM3Lib: TGUID = '{05B5AE1E-F0B6-11D4-8DE3-00B0D021D545}';
  DIID_IIOPSystemEvents3: TGUID = '{05B5AE20-F0B6-11D4-8DE3-00B0D021D545}';
  DIID_IIOPCardEvents3: TGUID = '{05B5AE22-F0B6-11D4-8DE3-00B0D021D545}';
  IID_IIOPVisaOP: TGUID = '{7110BFE5-A077-11D4-8DD1-00B0D021D545}';
  CLASS_IOPVisaOP: TGUID = '{E901E6F6-A07F-11D4-8DD1-00B0D021D545}';
  IID_IIOPFileSystem3: TGUID = '{05B5AE0C-F0B6-11D4-8DE3-00B0D021D545}';
  CLASS_IOPFileSystem3: TGUID = '{05B5ADFE-F0B6-11D4-8DE3-00B0D021D545}';
  IID_IIOPFileHeader3: TGUID = '{05B5AE1C-F0B6-11D4-8DE3-00B0D021D545}';
  IID_IIOPCrypto3: TGUID = '{05B5AE0E-F0B6-11D4-8DE3-00B0D021D545}';
  CLASS_IOPCrypto3: TGUID = '{05B5ADFA-F0B6-11D4-8DE3-00B0D021D545}';
  IID_IIOPPublicKeyBlob3: TGUID = '{05B5AE18-F0B6-11D4-8DE3-00B0D021D545}';
  IID_IIOPPrivateKeyBlob3: TGUID = '{05B5AE1A-F0B6-11D4-8DE3-00B0D021D545}';
  IID_IIOPJava3: TGUID = '{05B5AE10-F0B6-11D4-8DE3-00B0D021D545}';
  CLASS_IOPJava3: TGUID = '{05B5AE02-F0B6-11D4-8DE3-00B0D021D545}';
  IID_IIOPError3: TGUID = '{05B5AE12-F0B6-11D4-8DE3-00B0D021D545}';
  CLASS_IOPError3: TGUID = '{05B5ADFC-F0B6-11D4-8DE3-00B0D021D545}';
  IID_IIOPSystem3: TGUID = '{05B5AE14-F0B6-11D4-8DE3-00B0D021D545}';
  CLASS_IOPSystem3: TGUID = '{05B5AE0A-F0B6-11D4-8DE3-00B0D021D545}';
  IID_IIOPCard3: TGUID = '{05B5AE16-F0B6-11D4-8DE3-00B0D021D545}';
  CLASS_IOPCard3: TGUID = '{05B5ADF9-F0B6-11D4-8DE3-00B0D021D545}';
  CLASS_IOPPublicKeyBlob3: TGUID = '{05B5AE08-F0B6-11D4-8DE3-00B0D021D545}';
  CLASS_IOPPrivateKeyBlob3: TGUID = '{05B5AE06-F0B6-11D4-8DE3-00B0D021D545}';
  CLASS_IOPFileHeader3: TGUID = '{05B5AE00-F0B6-11D4-8DE3-00B0D021D545}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                  //
// *********************************************************************//
// iopKeys constants
type
  iopKeys = TOleEnum;
const
  iopTransportKey = $000000FF;

// iopFileStatusMasks constants
type
  iopFileStatusMasks = TOleEnum;
const
  iopValidated = $00000001;
  iopCreated = $00000002;
  iopInstalled = $00000004;
  iopRegistered = $00000008;
  iopApplication = $00000010;
  iopApplet = $00000020;

// iopFileType constants
type
  iopFileType = TOleEnum;
const
  Directory = $00000000;
  BinaryFile = $00000001;
  CyclicFile = $00000002;
  VariableRecordFile = $00000003;
  FixedRecordFile = $00000004;
  Instance = $00000005;
  ProgramFile = $00000006;

// iopFileActions constants
type
  iopFileActions = TOleEnum;
const
  EFRead = $00000000;
  EFWrite = $00000001;
  EFExecute = $00000002;
  EFInvalidate = $00000003;
  EFRehabilidate = $00000004;
  EFCustom0 = $00000005;
  EFCustom1 = $00000006;
  EFCustom2 = $00000007;
  RFRead = $00000000;
  RFWrite = $00000001;
  RFCreateRecord = $00000002;
  RFInvalidate = $00000003;
  RFRehabilidate = $00000004;
  RFCustom0 = $00000005;
  RFCustom1 = $00000006;
  RFCustom2 = $00000007;
  DFList = $00000000;
  DFDelete = $00000001;
  DFChangeACL = $00000002;
  DFInvalidate = $00000003;
  DFRehabilidate = $00000004;
  DFCreate = $00000005;
  DFManage = $00000006;
  DFCustom2 = $00000007;

// iopFileAuthentications constants
type
  iopFileAuthentications = TOleEnum;
const
  Always = $00000000;
  CHV1 = $00000001;
  CHV2 = $00000002;
  AUT0 = $00000003;
  AUT1 = $00000004;
  AUT2 = $00000005;
  AUT3 = $00000006;
  AUT4 = $00000007;

// iopMethodType constants
type
  iopMethodType = TOleEnum;
const
  Install = $00000013;
  Main = $00000002;

// iopCardletType constants
type
  iopCardletType = TOleEnum;
const
  AppletOnly = $00000001;
  FullApplication = $00000002;

// iopCardType constants
type
  iopCardType = TOleEnum;
const
  ctUnknown = $00000000;
  ctCryptoflex = $00000001;
  ctCyberflex = $00000002;
  ctCyberflexV2 = $00000003;
  ctPalmera = $00000004;

// iopKeyType constants
type
  iopKeyType = TOleEnum;
const
  ktIOPRSA512 = $00000001;
  ktIOPRSA768 = $00000002;
  ktIOPRSA1024 = $00000003;
  ktIOPRSA2048 = $00000004;

type

// *********************************************************************//
// Forward declaration of interfaces defined in Type Library            //
// *********************************************************************//
  IIOPSystemEvents3 = dispinterface;
  IIOPCardEvents3 = dispinterface;
  IIOPVisaOP = interface;
  IIOPVisaOPDisp = dispinterface;
  IIOPFileSystem3 = interface;
  IIOPFileSystem3Disp = dispinterface;
  IIOPFileHeader3 = interface;
  IIOPFileHeader3Disp = dispinterface;
  IIOPCrypto3 = interface;
  IIOPCrypto3Disp = dispinterface;
  IIOPPublicKeyBlob3 = interface;
  IIOPPublicKeyBlob3Disp = dispinterface;
  IIOPPrivateKeyBlob3 = interface;
  IIOPPrivateKeyBlob3Disp = dispinterface;
  IIOPJava3 = interface;
  IIOPJava3Disp = dispinterface;
  IIOPError3 = interface;
  IIOPError3Disp = dispinterface;
  IIOPSystem3 = interface;
  IIOPSystem3Disp = dispinterface;
  IIOPCard3 = interface;
  IIOPCard3Disp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                     //
// (NOTE: Here we map each CoClass to its Default Interface)            //
// *********************************************************************//
  IOPVisaOP = IIOPVisaOP;
  IOPFileSystem3 = IIOPFileSystem3;
  IOPCrypto3 = IIOPCrypto3;
  IOPJava3 = IIOPJava3;
  IOPError3 = IIOPError3;
  IOPSystem3 = IIOPSystem3;
  IOPCard3 = IIOPCard3;
  IOPPublicKeyBlob3 = IIOPPublicKeyBlob3;
  IOPPrivateKeyBlob3 = IIOPPrivateKeyBlob3;
  IOPFileHeader3 = IIOPFileHeader3;


// *********************************************************************//
// Declaration of structures, unions and aliases.                       //
// *********************************************************************//
  PPSafeArray1 = ^PSafeArray; {*}


// *********************************************************************//
// DispIntf:  IIOPSystemEvents3
// Flags:     (4096) Dispatchable
// GUID:      {05B5AE20-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPSystemEvents3 = dispinterface
    ['{05B5AE20-F0B6-11D4-8DE3-00B0D021D545}']
    procedure CardInserted(const ReaderName: WideString); dispid 1;
    procedure CardRemoved(const ReaderName: WideString); dispid 2;
    procedure ReaderInserted; dispid 3;
    procedure ReaderRemoved(const ReaderName: WideString); dispid 4;
  end;

// *********************************************************************//
// DispIntf:  IIOPCardEvents3
// Flags:     (4096) Dispatchable
// GUID:      {05B5AE22-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPCardEvents3 = dispinterface
    ['{05B5AE22-F0B6-11D4-8DE3-00B0D021D545}']
    procedure DataSent(var Data: {??PSafeArray} OleVariant); dispid 1;
    procedure DataReceived(var Data: {??PSafeArray} OleVariant); dispid 2;
  end;

// *********************************************************************//
// Interface: IIOPVisaOP
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7110BFE5-A077-11D4-8DD1-00B0D021D545}
// *********************************************************************//
  IIOPVisaOP = interface(IDispatch)
    ['{7110BFE5-A077-11D4-8DD1-00B0D021D545}']
    function EstablishSecureChannel(Mode: Byte; var bKeyAuth: PSafeArray; var bKeyMac: PSafeArray; 
                                    var bKeyKek: PSafeArray): WordBool; safecall;
    function EnumerateAID(AIDTypes: Byte; out OutAIDList: PSafeArray): WordBool; safecall;
    function DeleteAID(var bAID: PSafeArray): WordBool; safecall;
    function LoadApplet(var bByteCode: PSafeArray; var bAID: PSafeArray): WordBool; safecall;
    function CreateInstance(var bAppletAID: PSafeArray; var bInstanceAID: PSafeArray; 
                            var bInstallParameters: PSafeArray; sInstanceSize: Smallint): WordBool; safecall;
    function MakeSelectable(var bAID: PSafeArray): WordBool; safecall;
    function ReleaseSecureChannel: WordBool; safecall;
    function GetAIDFromBlob(var AIDList: PSafeArray; bIndex: Byte; out AID: PSafeArray): WordBool; safecall;
    function GetStatusFromBlob(var AIDList: PSafeArray; bIndex: Byte; out Status: PSafeArray): WordBool; safecall;
    function SelectAID(var AID: PSafeArray): WordBool; safecall;
    function PutKey(var bAuth: PSafeArray; var bMAC: PSafeArray; var bKek: PSafeArray): WordBool; safecall;
    function GetData(out CardData: PSafeArray): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IIOPVisaOPDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7110BFE5-A077-11D4-8DD1-00B0D021D545}
// *********************************************************************//
  IIOPVisaOPDisp = dispinterface
    ['{7110BFE5-A077-11D4-8DD1-00B0D021D545}']
    function EstablishSecureChannel(Mode: Byte; var bKeyAuth: {??PSafeArray} OleVariant; 
                                    var bKeyMac: {??PSafeArray} OleVariant; 
                                    var bKeyKek: {??PSafeArray} OleVariant): WordBool; dispid 1;
    function EnumerateAID(AIDTypes: Byte; out OutAIDList: {??PSafeArray} OleVariant): WordBool; dispid 2;
    function DeleteAID(var bAID: {??PSafeArray} OleVariant): WordBool; dispid 3;
    function LoadApplet(var bByteCode: {??PSafeArray} OleVariant; 
                        var bAID: {??PSafeArray} OleVariant): WordBool; dispid 4;
    function CreateInstance(var bAppletAID: {??PSafeArray} OleVariant; 
                            var bInstanceAID: {??PSafeArray} OleVariant; 
                            var bInstallParameters: {??PSafeArray} OleVariant; 
                            sInstanceSize: Smallint): WordBool; dispid 5;
    function MakeSelectable(var bAID: {??PSafeArray} OleVariant): WordBool; dispid 6;
    function ReleaseSecureChannel: WordBool; dispid 7;
    function GetAIDFromBlob(var AIDList: {??PSafeArray} OleVariant; bIndex: Byte; 
                            out AID: {??PSafeArray} OleVariant): WordBool; dispid 8;
    function GetStatusFromBlob(var AIDList: {??PSafeArray} OleVariant; bIndex: Byte; 
                               out Status: {??PSafeArray} OleVariant): WordBool; dispid 9;
    function SelectAID(var AID: {??PSafeArray} OleVariant): WordBool; dispid 10;
    function PutKey(var bAuth: {??PSafeArray} OleVariant; var bMAC: {??PSafeArray} OleVariant; 
                    var bKek: {??PSafeArray} OleVariant): WordBool; dispid 11;
    function GetData(out CardData: {??PSafeArray} OleVariant): WordBool; dispid 12;
  end;

// *********************************************************************//
// Interface: IIOPFileSystem3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE0C-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPFileSystem3 = interface(IDispatch)
    ['{05B5AE0C-F0B6-11D4-8DE3-00B0D021D545}']
    function Get_CurrentDir: WideString; safecall;
    function Delete(sFileID: Smallint): WordBool; safecall;
    function Directory(FileNumber: Byte; out FileHeader: IIOPFileHeader3): WordBool; safecall;
    function SelectParent: WordBool; safecall;
    function Select(const szFileFullPath: WideString; out FileHeader: IIOPFileHeader3): WordBool; safecall;
    function ReadBinary(sOffset: Smallint; sDataLength: Smallint; out bDataOut: PSafeArray): WordBool; safecall;
    function WriteBinary(sOffset: Smallint; var bData: PSafeArray): WordBool; safecall;
    function Get_CurrentFile: WideString; safecall;
    function Create(const pFileHeader: IIOPFileHeader3): WordBool; safecall;
    function ChangeACL(var bData: PSafeArray): WordBool; safecall;
    function GetCurrentACL(out bDataOut: PSafeArray): WordBool; safecall;
    property CurrentDir: WideString read Get_CurrentDir;
    property CurrentFile: WideString read Get_CurrentFile;
  end;

// *********************************************************************//
// DispIntf:  IIOPFileSystem3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE0C-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPFileSystem3Disp = dispinterface
    ['{05B5AE0C-F0B6-11D4-8DE3-00B0D021D545}']
    property CurrentDir: WideString readonly dispid 0;
    function Delete(sFileID: Smallint): WordBool; dispid 1;
    function Directory(FileNumber: Byte; out FileHeader: IIOPFileHeader3): WordBool; dispid 2;
    function SelectParent: WordBool; dispid 3;
    function Select(const szFileFullPath: WideString; out FileHeader: IIOPFileHeader3): WordBool; dispid 4;
    function ReadBinary(sOffset: Smallint; sDataLength: Smallint; 
                        out bDataOut: {??PSafeArray} OleVariant): WordBool; dispid 5;
    function WriteBinary(sOffset: Smallint; var bData: {??PSafeArray} OleVariant): WordBool; dispid 6;
    property CurrentFile: WideString readonly dispid 8;
    function Create(const pFileHeader: IIOPFileHeader3): WordBool; dispid 9;
    function ChangeACL(var bData: {??PSafeArray} OleVariant): WordBool; dispid 10;
    function GetCurrentACL(out bDataOut: {??PSafeArray} OleVariant): WordBool; dispid 11;
  end;

// *********************************************************************//
// Interface: IIOPFileHeader3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE1C-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPFileHeader3 = interface(IDispatch)
    ['{05B5AE1C-F0B6-11D4-8DE3-00B0D021D545}']
    function Get_Size: Smallint; safecall;
    procedure Set_Size(pVal: Smallint); safecall;
    function Get_ID: Smallint; safecall;
    procedure Set_ID(pVal: Smallint); safecall;
    function Get_FileType: iopFileType; safecall;
    procedure Set_FileType(pVal: iopFileType); safecall;
    function Get_Status: Byte; safecall;
    procedure Set_Status(pVal: Byte); safecall;
    function Get_NumberSubDir: Byte; safecall;
    procedure Set_NumberSubDir(pVal: Byte); safecall;
    function Get_NumberFiles: Byte; safecall;
    procedure Set_NumberFiles(pVal: Byte); safecall;
    function Get_AccessConditionHexString: WideString; safecall;
    procedure Set_AccessConditionHexString(const pVal: WideString); safecall;
    function Get_AccessCondition(What: iopFileActions; Who: iopFileAuthentications): WordBool; safecall;
    procedure Set_AccessCondition(What: iopFileActions; Who: iopFileAuthentications; pVal: WordBool); safecall;
    function Get_ApplicationID: PSafeArray; safecall;
    procedure Set_ApplicationID(var pVal: PSafeArray); safecall;
    function Get_AIDLength: Byte; safecall;
    function Get_CryptoflexACL: WideString; safecall;
    procedure Set_CryptoflexACL(const pVal: WideString); safecall;
    property Size: Smallint read Get_Size write Set_Size;
    property ID: Smallint read Get_ID write Set_ID;
    property FileType: iopFileType read Get_FileType write Set_FileType;
    property Status: Byte read Get_Status write Set_Status;
    property NumberSubDir: Byte read Get_NumberSubDir write Set_NumberSubDir;
    property NumberFiles: Byte read Get_NumberFiles write Set_NumberFiles;
    property AccessConditionHexString: WideString read Get_AccessConditionHexString write Set_AccessConditionHexString;
    property AccessCondition[What: iopFileActions; Who: iopFileAuthentications]: WordBool read Get_AccessCondition write Set_AccessCondition;
    property AIDLength: Byte read Get_AIDLength;
    property CryptoflexACL: WideString read Get_CryptoflexACL write Set_CryptoflexACL;
  end;

// *********************************************************************//
// DispIntf:  IIOPFileHeader3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE1C-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPFileHeader3Disp = dispinterface
    ['{05B5AE1C-F0B6-11D4-8DE3-00B0D021D545}']
    property Size: Smallint dispid 1;
    property ID: Smallint dispid 2;
    property FileType: iopFileType dispid 3;
    property Status: Byte dispid 4;
    property NumberSubDir: Byte dispid 5;
    property NumberFiles: Byte dispid 6;
    property AccessConditionHexString: WideString dispid 7;
    property AccessCondition[What: iopFileActions; Who: iopFileAuthentications]: WordBool dispid 8;
    function ApplicationID: {??PSafeArray} OleVariant; dispid 9;
    property AIDLength: Byte readonly dispid 10;
    property CryptoflexACL: WideString dispid 11;
  end;

// *********************************************************************//
// Interface: IIOPCrypto3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE0E-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPCrypto3 = interface(IDispatch)
    ['{05B5AE0E-F0B6-11D4-8DE3-00B0D021D545}']
    function VerifyKey(KeyNumber: Byte; var Key: PSafeArray): WordBool; safecall;
    function VerifyCHV(CHVNumber: Byte; var CHV: PSafeArray): WordBool; safecall;
    function GetChallenge(NumberLength: Byte; out RandomNumber: PSafeArray): WordBool; safecall;
    function ExternalAuth(bAlgorithmID: Byte; bKeyNumber: Byte; var bData: PSafeArray): WordBool; safecall;
    function InternalAuth(bAlgorithmID: Byte; bKeyNumber: Byte; var bDataIn: PSafeArray; 
                          out bDataOut: PSafeArray): WordBool; safecall;
    function WritePublicKey(const pKey: IIOPPublicKeyBlob3; bKeyNum: Byte; bAlgorithmNumber: Byte): WordBool; safecall;
    function ReadPublicKey(out ppKey: IIOPPublicKeyBlob3; bKeyNum: Byte): WordBool; safecall;
    function WritePrivateKey(const pKey: IIOPPrivateKeyBlob3; bKeyNum: Byte; bAlgorithmID: Byte): WordBool; safecall;
    function ChangeCHV(var OldCHV: PSafeArray; var NewCHV: PSafeArray; KeyNumber: Byte): WordBool; safecall;
    function UnblockCHV(var UnblockCHV: PSafeArray; var NewCHV: PSafeArray; KeyNumber: Byte): WordBool; safecall;
    function ChangeUnblock(var NewUnblock: PSafeArray; KeyNumber: Byte): WordBool; safecall;
    function ChangeTransportKey(var NewTransportKey: PSafeArray): WordBool; safecall;
    function LogoutAll: WordBool; safecall;
    function UpdateCHV(CHVNumber: Byte; Offset: Byte; Length: Byte; var CHVData: PSafeArray): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IIOPCrypto3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE0E-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPCrypto3Disp = dispinterface
    ['{05B5AE0E-F0B6-11D4-8DE3-00B0D021D545}']
    function VerifyKey(KeyNumber: Byte; var Key: {??PSafeArray} OleVariant): WordBool; dispid 1;
    function VerifyCHV(CHVNumber: Byte; var CHV: {??PSafeArray} OleVariant): WordBool; dispid 2;
    function GetChallenge(NumberLength: Byte; out RandomNumber: {??PSafeArray} OleVariant): WordBool; dispid 3;
    function ExternalAuth(bAlgorithmID: Byte; bKeyNumber: Byte; var bData: {??PSafeArray} OleVariant): WordBool; dispid 4;
    function InternalAuth(bAlgorithmID: Byte; bKeyNumber: Byte; 
                          var bDataIn: {??PSafeArray} OleVariant; 
                          out bDataOut: {??PSafeArray} OleVariant): WordBool; dispid 5;
    function WritePublicKey(const pKey: IIOPPublicKeyBlob3; bKeyNum: Byte; bAlgorithmNumber: Byte): WordBool; dispid 6;
    function ReadPublicKey(out ppKey: IIOPPublicKeyBlob3; bKeyNum: Byte): WordBool; dispid 7;
    function WritePrivateKey(const pKey: IIOPPrivateKeyBlob3; bKeyNum: Byte; bAlgorithmID: Byte): WordBool; dispid 8;
    function ChangeCHV(var OldCHV: {??PSafeArray} OleVariant; 
                       var NewCHV: {??PSafeArray} OleVariant; KeyNumber: Byte): WordBool; dispid 9;
    function UnblockCHV(var UnblockCHV: {??PSafeArray} OleVariant; 
                        var NewCHV: {??PSafeArray} OleVariant; KeyNumber: Byte): WordBool; dispid 10;
    function ChangeUnblock(var NewUnblock: {??PSafeArray} OleVariant; KeyNumber: Byte): WordBool; dispid 11;
    function ChangeTransportKey(var NewTransportKey: {??PSafeArray} OleVariant): WordBool; dispid 12;
    function LogoutAll: WordBool; dispid 13;
    function UpdateCHV(CHVNumber: Byte; Offset: Byte; Length: Byte; 
                       var CHVData: {??PSafeArray} OleVariant): WordBool; dispid 14;
  end;

// *********************************************************************//
// Interface: IIOPPublicKeyBlob3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE18-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPPublicKeyBlob3 = interface(IDispatch)
    ['{05B5AE18-F0B6-11D4-8DE3-00B0D021D545}']
    function Get_ModulusLength: Byte; safecall;
    function Get_ModulusHexString: WideString; safecall;
    procedure Set_ModulusHexString(const pVal: WideString); safecall;
    function Get_ExponentHexString: WideString; safecall;
    procedure Set_ExponentHexString(const pVal: WideString); safecall;
    property ModulusLength: Byte read Get_ModulusLength;
    property ModulusHexString: WideString read Get_ModulusHexString write Set_ModulusHexString;
    property ExponentHexString: WideString read Get_ExponentHexString write Set_ExponentHexString;
  end;

// *********************************************************************//
// DispIntf:  IIOPPublicKeyBlob3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE18-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPPublicKeyBlob3Disp = dispinterface
    ['{05B5AE18-F0B6-11D4-8DE3-00B0D021D545}']
    property ModulusLength: Byte readonly dispid 1;
    property ModulusHexString: WideString dispid 2;
    property ExponentHexString: WideString dispid 3;
  end;

// *********************************************************************//
// Interface: IIOPPrivateKeyBlob3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE1A-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPPrivateKeyBlob3 = interface(IDispatch)
    ['{05B5AE1A-F0B6-11D4-8DE3-00B0D021D545}']
    function Get_P: WideString; safecall;
    procedure Set_P(const pVal: WideString); safecall;
    function Get_Q: WideString; safecall;
    procedure Set_Q(const pVal: WideString); safecall;
    function Get_InvQ: WideString; safecall;
    procedure Set_InvQ(const pVal: WideString); safecall;
    function Get_KsecModQ: WideString; safecall;
    procedure Set_KsecModQ(const pVal: WideString); safecall;
    function Get_KsecModP: WideString; safecall;
    procedure Set_KsecModP(const pVal: WideString); safecall;
    property P: WideString read Get_P write Set_P;
    property Q: WideString read Get_Q write Set_Q;
    property InvQ: WideString read Get_InvQ write Set_InvQ;
    property KsecModQ: WideString read Get_KsecModQ write Set_KsecModQ;
    property KsecModP: WideString read Get_KsecModP write Set_KsecModP;
  end;

// *********************************************************************//
// DispIntf:  IIOPPrivateKeyBlob3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE1A-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPPrivateKeyBlob3Disp = dispinterface
    ['{05B5AE1A-F0B6-11D4-8DE3-00B0D021D545}']
    property P: WideString dispid 1;
    property Q: WideString dispid 2;
    property InvQ: WideString dispid 3;
    property KsecModQ: WideString dispid 4;
    property KsecModP: WideString dispid 5;
  end;

// *********************************************************************//
// Interface: IIOPJava3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE10-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPJava3 = interface(IDispatch)
    ['{05B5AE10-F0B6-11D4-8DE3-00B0D021D545}']
    function SelectAID(var AID: PSafeArray): WordBool; safecall;
    function DeleteApplet: WordBool; safecall;
    function SetCurrentAsLoader: WordBool; safecall;
    function SetDefaultAsLoader: WordBool; safecall;
    function ResetProgram: WordBool; safecall;
    function ResetInstance: WordBool; safecall;
    function BlockApplet: WordBool; safecall;
    function Execute(mthdEntryPoint: iopMethodType; cardlettype: iopCardletType; ProgID: Smallint; 
                     InstContainerSize: Smallint; InstContainerID: Smallint; 
                     InstDataSize: Smallint; const AIDHexString: WideString; 
                     var ExtraData: PSafeArray): WordBool; safecall;
    function Validate(var bSignature: PSafeArray): WordBool; safecall;
    function SelectLoader: WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IIOPJava3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE10-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPJava3Disp = dispinterface
    ['{05B5AE10-F0B6-11D4-8DE3-00B0D021D545}']
    function SelectAID(var AID: {??PSafeArray} OleVariant): WordBool; dispid 1;
    function DeleteApplet: WordBool; dispid 2;
    function SetCurrentAsLoader: WordBool; dispid 3;
    function SetDefaultAsLoader: WordBool; dispid 4;
    function ResetProgram: WordBool; dispid 5;
    function ResetInstance: WordBool; dispid 6;
    function BlockApplet: WordBool; dispid 7;
    function Execute(mthdEntryPoint: iopMethodType; cardlettype: iopCardletType; ProgID: Smallint; 
                     InstContainerSize: Smallint; InstContainerID: Smallint; 
                     InstDataSize: Smallint; const AIDHexString: WideString; 
                     var ExtraData: {??PSafeArray} OleVariant): WordBool; dispid 8;
    function Validate(var bSignature: {??PSafeArray} OleVariant): WordBool; dispid 9;
    function SelectLoader: WordBool; dispid 10;
  end;

// *********************************************************************//
// Interface: IIOPError3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE12-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPError3 = interface(IDispatch)
    ['{05B5AE12-F0B6-11D4-8DE3-00B0D021D545}']
    function Get_IsError: WordBool; safecall;
    function Get_Description: WideString; safecall;
    function Get_Success: WordBool; safecall;
    function Get_Status: Integer; safecall;
    property IsError: WordBool read Get_IsError;
    property Description: WideString read Get_Description;
    property Success: WordBool read Get_Success;
    property Status: Integer read Get_Status;
  end;

// *********************************************************************//
// DispIntf:  IIOPError3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE12-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPError3Disp = dispinterface
    ['{05B5AE12-F0B6-11D4-8DE3-00B0D021D545}']
    property IsError: WordBool readonly dispid 0;
    property Description: WideString readonly dispid 1;
    property Success: WordBool readonly dispid 2;
    property Status: Integer readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IIOPSystem3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE14-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPSystem3 = interface(IDispatch)
    ['{05B5AE14-F0B6-11D4-8DE3-00B0D021D545}']
    function Connect(const ReaderName: WideString; ExclusiveMode: WordBool): IIOPCard3; safecall;
    function ListReaders(out OutReadersList: PSafeArray): WordBool; safecall;
    function Get_LastError: IIOPError3; safecall;
    function ListKnownCards(out OutCardList: PSafeArray): WordBool; safecall;
    property LastError: IIOPError3 read Get_LastError;
  end;

// *********************************************************************//
// DispIntf:  IIOPSystem3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE14-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPSystem3Disp = dispinterface
    ['{05B5AE14-F0B6-11D4-8DE3-00B0D021D545}']
    function Connect(const ReaderName: WideString; ExclusiveMode: WordBool): IIOPCard3; dispid 1;
    function ListReaders(out OutReadersList: {??PSafeArray} OleVariant): WordBool; dispid 3;
    property LastError: IIOPError3 readonly dispid 4;
    function ListKnownCards(out OutCardList: {??PSafeArray} OleVariant): WordBool; dispid 5;
  end;

// *********************************************************************//
// Interface: IIOPCard3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE16-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPCard3 = interface(IDispatch)
    ['{05B5AE16-F0B6-11D4-8DE3-00B0D021D545}']
    function Get_CardName: WideString; safecall;
    procedure Reset; safecall;
    function Get_FileSystem: IIOPFileSystem3; safecall;
    function Get_Crypto: IIOPCrypto3; safecall;
    function Get_Java: IIOPJava3; safecall;
    function Get_ATR: PSafeArray; safecall;
    function SendAPDU(CLA: Byte; INS: Byte; P1: Byte; P2: Byte; var DataSend: PSafeArray; 
                      ExpectedLengthReply: Byte; out DataReply: PSafeArray; out wSW: Smallint): WordBool; safecall;
    function Disconnect: WordBool; safecall;
    function Get_LastError: IIOPError3; safecall;
    function BeginTransaction: WordBool; safecall;
    function EndTransaction: WordBool; safecall;
    function Get_HasProperty(PropertyNumber: Integer): WordBool; safecall;
    function Get_Serial: PSafeArray; safecall;
    function Get_VisaOP: IIOPVisaOP; safecall;
    function Get_CardType: iopCardType; safecall;
    function SupportedKeySize(kt: iopKeyType): WordBool; safecall;
    function Get_MaxPinLength: Byte; safecall;
    function Get_RsaKeyGeneration: WordBool; safecall;
    function Get_RsaKeyGenPublKeyNeeded: WordBool; safecall;
    function Get_RsaCryptoPublKeyNeeded: WordBool; safecall;
    function Get_CardPointer: Integer; safecall;
    property CardName: WideString read Get_CardName;
    property FileSystem: IIOPFileSystem3 read Get_FileSystem;
    property Crypto: IIOPCrypto3 read Get_Crypto;
    property Java: IIOPJava3 read Get_Java;
    property ATR: PSafeArray read Get_ATR;
    property LastError: IIOPError3 read Get_LastError;
    property HasProperty[PropertyNumber: Integer]: WordBool read Get_HasProperty;
    property Serial: PSafeArray read Get_Serial;
    property VisaOP: IIOPVisaOP read Get_VisaOP;
    property CardType: iopCardType read Get_CardType;
    property MaxPinLength: Byte read Get_MaxPinLength;
    property RsaKeyGeneration: WordBool read Get_RsaKeyGeneration;
    property RsaKeyGenPublKeyNeeded: WordBool read Get_RsaKeyGenPublKeyNeeded;
    property RsaCryptoPublKeyNeeded: WordBool read Get_RsaCryptoPublKeyNeeded;
    property CardPointer: Integer read Get_CardPointer;
  end;

// *********************************************************************//
// DispIntf:  IIOPCard3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05B5AE16-F0B6-11D4-8DE3-00B0D021D545}
// *********************************************************************//
  IIOPCard3Disp = dispinterface
    ['{05B5AE16-F0B6-11D4-8DE3-00B0D021D545}']
    property CardName: WideString readonly dispid 0;
    procedure Reset; dispid 1;
    property FileSystem: IIOPFileSystem3 readonly dispid 2;
    property Crypto: IIOPCrypto3 readonly dispid 3;
    property Java: IIOPJava3 readonly dispid 4;
    property ATR: {??PSafeArray} OleVariant readonly dispid 6;
    function SendAPDU(CLA: Byte; INS: Byte; P1: Byte; P2: Byte; 
                      var DataSend: {??PSafeArray} OleVariant; ExpectedLengthReply: Byte; 
                      out DataReply: {??PSafeArray} OleVariant; out wSW: Smallint): WordBool; dispid 7;
    function Disconnect: WordBool; dispid 8;
    property LastError: IIOPError3 readonly dispid 9;
    function BeginTransaction: WordBool; dispid 10;
    function EndTransaction: WordBool; dispid 11;
    property HasProperty[PropertyNumber: Integer]: WordBool readonly dispid 12;
    property Serial: {??PSafeArray} OleVariant readonly dispid 13;
    property VisaOP: IIOPVisaOP readonly dispid 14;
    property CardType: iopCardType readonly dispid 15;
    function SupportedKeySize(kt: iopKeyType): WordBool; dispid 16;
    property MaxPinLength: Byte readonly dispid 17;
    property RsaKeyGeneration: WordBool readonly dispid 18;
    property RsaKeyGenPublKeyNeeded: WordBool readonly dispid 19;
    property RsaCryptoPublKeyNeeded: WordBool readonly dispid 20;
    property CardPointer: Integer readonly dispid 21;
  end;

  CoIOPSystem3 = class
    class function Create: IIOPSystem3;
    class function CreateRemote(const MachineName: string): IIOPSystem3;
  end;

  CoIOPPublicKeyBlob3 = class
    class function Create: IIOPPublicKeyBlob3;
    class function CreateRemote(const MachineName: string): IIOPPublicKeyBlob3;
  end;

  CoIOPPrivateKeyBlob3 = class
    class function Create: IIOPPrivateKeyBlob3;
    class function CreateRemote(const MachineName: string): IIOPPrivateKeyBlob3;
  end;

  CoIOPFileHeader3 = class
    class function Create: IIOPFileHeader3;
    class function CreateRemote(const MachineName: string): IIOPFileHeader3;
  end;

implementation

uses ComObj;

class function CoIOPSystem3.Create: IIOPSystem3;
begin
  Result := CreateComObject(CLASS_IOPSystem3) as IIOPSystem3;
end;

class function CoIOPSystem3.CreateRemote(const MachineName: string): IIOPSystem3;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_IOPSystem3) as IIOPSystem3;
end;

class function CoIOPPublicKeyBlob3.Create: IIOPPublicKeyBlob3;
begin
  Result := CreateComObject(CLASS_IOPPublicKeyBlob3) as IIOPPublicKeyBlob3;
end;

class function CoIOPPublicKeyBlob3.CreateRemote(const MachineName: string): IIOPPublicKeyBlob3;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_IOPPublicKeyBlob3) as IIOPPublicKeyBlob3;
end;

class function CoIOPPrivateKeyBlob3.Create: IIOPPrivateKeyBlob3;
begin
  Result := CreateComObject(CLASS_IOPPrivateKeyBlob3) as IIOPPrivateKeyBlob3;
end;

class function CoIOPPrivateKeyBlob3.CreateRemote(const MachineName: string): IIOPPrivateKeyBlob3;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_IOPPrivateKeyBlob3) as IIOPPrivateKeyBlob3;
end;

class function CoIOPFileHeader3.Create: IIOPFileHeader3;
begin
  Result := CreateComObject(CLASS_IOPFileHeader3) as IIOPFileHeader3;
end;

class function CoIOPFileHeader3.CreateRemote(const MachineName: string): IIOPFileHeader3;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_IOPFileHeader3) as IIOPFileHeader3;
end;

end.
