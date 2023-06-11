import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay(
      {super.key, required this.error, this.retry = false, this.ontap});
  final String error;
  final bool retry;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.8)),
            ),
          ),
          if (retry) ...[
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: ontap,
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                child: Text(
                  'Retry',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headlineSmall
                      ?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
