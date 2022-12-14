// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:postman/models/Package.dart';
import 'package:postman/widgets/Space.dart';

import '../controllers/Globals.dart';

class Packages extends StatefulWidget {
  const Packages({Key? key}) : super(key: key);

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  // function to retrive available packages
  Future<List<Result>> fetchPackages() async {
    String? token = await global.getValue("token");
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    Client client = Client();
    var response = await client.get(
        Uri.parse("https://api.postman.ug/api/v1/packages/"),
        headers: header);
    // if (response.statusCode == 200) {
    return packagesFromJson(jsonDecode(response.body));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Result>>(
      future: fetchPackages(),
      builder: (context, snapshot) {
        var packages = snapshot.data;
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: Column(
                  children: [
                    Space(space: 0.5),
                    const CircularProgressIndicator.adaptive(),
                    Space(space: 0.07),
                    Text(
                      "Loading packages...",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              )
            : packages!.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Space(space: 0.12),
                        Image.asset("assets/empty.png"),
                        Text(
                          "No packages found",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  )
                : RenderPackages(packages: packages);
      },
    );
  }
}

class RenderPackages extends StatefulWidget {
  List<Result> packages;
  RenderPackages({Key? key, required this.packages}) : super(key: key);

  @override
  State<RenderPackages> createState() => _RenderPackagesState();
}

class _RenderPackagesState extends State<RenderPackages> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          print(widget.packages.isEmpty);
          return ListTile(
            title: Text("Package from ${widget.packages[index].senderName}"),
            trailing: Text(widget.packages[index].description),
          );
        },
        separatorBuilder: (context, index) => Space(),
        itemCount: widget.packages.length);
  }
}
