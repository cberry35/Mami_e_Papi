import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<void> uploadImageToGitHub(Uint8List imageData, String imageFile) async {
  String part1 = 'ghp_GgDCzVYBeNO8N5Q';
  String part2 = 'ywkRBDmtPbuEH5M1ulL7R';

  final url =
      'https://api.github.com/repos/cberry35/rasp_pi_images/contents/Display_Images/$imageFile'; // Replace with your GitHub repository URL and path to the image file

  final auth = 'Basic ${base64Encode(utf8.encode('cberry35:$part1$part2'))}'; // Replace with your GitHub username and personal access token

  final headers = {
    'Authorization': auth,
    'Content-Type': 'application/json',
  };

  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final sha = json['sha'];

    final body = {
      'message': 'Update image file',
      'content': base64Encode(imageData),
      'sha': sha,
    };

    final putResponse = await http.put(Uri.parse(url), headers: headers, body: jsonEncode(body));

    if (putResponse.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Image upload failed');
      print(putResponse.body);
    }
  } else {
    print('Error retrieving file information');
    print(response.body);
  }
}