import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.brown,
        decoration: const InputDecoration(
            hintText: "Search Characters",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  color: Colors.grey,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  color: Colors.grey,
                )),
            suffixIcon: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.search,
                color: Colors.brown,
              ),
            )),
      ),
    );
  }
}
