import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade700,
      child: Center(
        child: Stack(
          children: [
            // White circle (bottom half)
            const SpinKitHourGlass(
              color: Colors.red,
              size: 50.0,
            ),

            FutureBuilder<void>(
              future: Future.delayed(const Duration(milliseconds: 100)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const SpinKitHourGlass(
                    color: Colors.black,
                    size: 40.0,
                  );
                }
                return const SizedBox(); // Show nothing while waiting
              },
            ),

            FutureBuilder<void>(
              future: Future.delayed(const Duration(milliseconds: 200)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const SpinKitHourGlass(
                    color: Colors.white,
                    size: 30.0,
                  );
                }
                return const SizedBox(); // Show nothing while waiting
              },
            ),
          ],
        ),
      ),
    );
  }
}
