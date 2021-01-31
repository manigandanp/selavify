import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as gSignIn;

const List<String> DEFAULT_SCOPES = [
  drive.DriveApi.DriveScope,
];

class GoogleSignInHelper {
  final List<String> scopes;

  GoogleSignInHelper({this.scopes = DEFAULT_SCOPES});

  gSignIn.GoogleSignIn get _googleSignInApi =>
      gSignIn.GoogleSignIn(scopes: scopes);

  Future<gSignIn.GoogleSignInAccount> signIn() async {
    gSignIn.GoogleSignInAccount account =
        await _googleSignInApi.signInSilently();
    account ??= await _googleSignInApi.signIn();
    return account;
  }

  Future<Map<String, dynamic>> get accountDetails async {
    gSignIn.GoogleSignInAccount account = await signIn();
    return {
      "name": account.displayName,
      "email": account.email,
      "imageUrl": account.photoUrl,
    };
  }

  Future<bool> get isSignedIn async => await _googleSignInApi.isSignedIn();

  Future<gSignIn.GoogleSignInAccount> signOut() => _googleSignInApi.signOut();
}

class GoogleDriveApiHelper {
  final GoogleAuthClient authClient;

  GoogleDriveApiHelper(this.authClient);

  Future<drive.File> createFile(File fileToUpload, String fileName) async {
    var driveApi = drive.DriveApi(authClient);

    var response = await driveApi.files.create(drive.File()..name = fileName,
        uploadMedia:
            drive.Media(fileToUpload.openRead(), fileToUpload.lengthSync()));

    return response;
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, dynamic> _headers;

  GoogleAuthClient(this._headers);

  final http.Client _client = new http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

class GoogleDriveFacade {
  final GoogleSignInHelper gSignInHelper = GoogleSignInHelper();

  Future<drive.File> uploadFile(File file, String fileName) async {
    gSignIn.GoogleSignInAccount account = await gSignInHelper.signIn();
    var authClient = GoogleAuthClient(await account.authHeaders);
    GoogleDriveApiHelper authendicatedDrive = GoogleDriveApiHelper(authClient);
    drive.File response = await authendicatedDrive.createFile(file, fileName);
    return response;
  }

  Future<Map<String, dynamic>> accountDetails() async =>
      await gSignInHelper.accountDetails;

  Future<void> signOut() async => await gSignInHelper.signOut();
  Future<void> signIn() async => await gSignInHelper.signIn();
  Future<bool> get isSignedIn async => await gSignInHelper.isSignedIn;
}
