import 'package:afet_yonetim/services/provider/location.dart';
import 'package:afet_yonetim/views/widgets/image/big_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class VolunteerScreen extends ConsumerWidget {
  const VolunteerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yardıma İhtiyacı Olanlar"),
      ),
      body: ref.watch(locationDataProvider).when(
            data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () => launchUrlString(
                    "https://maps.google.com/?q=${data[index].latitude},${data[index].longitude}"),
                title: Text(
                    "Enlem: ${data[index].latitude} \nBoylam: ${data[index].longitude}"),
                subtitle: Text("Telefon numarası: ${data[index].phoneNumber}"),
                leading: data[index].photo != ""
                    ? Hero(
                        tag: data[index].photo,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BigImageScreen(
                                url: data[index].photo,
                              ),
                            ),
                          ),
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child:
                                CachedNetworkImage(imageUrl: data[index].photo),
                          ),
                        ),
                      )
                    : Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 48,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                trailing: IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () =>
                      launchUrlString("tel:${data[index].phoneNumber}"),
                ),
              ),
            ),
            error: (err, s) => Text(err.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
