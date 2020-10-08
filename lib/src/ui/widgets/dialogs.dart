import 'package:flutter/material.dart';
import 'package:skintel/src/ui/style.dart';

disclaimerDialog(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Dismiss",
                    style: TextStyle(fontFamily: kFontFamilyBold)),
              ))
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Colors.amber[100],
        title: Text(
          "Skintel Disclaimer",
          style: TextStyle(fontFamily: kFontFamilyBold, fontSize: 24),
        ),
        content: Text(
          """We provide skin care recommendations based on existing public information provided by the American Academy of Dermatology Association and other certified organizations. If you believe you may have a medical condition, please contact your medical professional immediately.

These statements have not been evaluated by the Food and Drug Administration. This product is not intended to diagnose, treat, cure, or prevent any disease.

By using Skintel you confirm you have read and agree with the above-mentioned disclaimers.""",
          style: TextStyle(fontFamily: kFontFamilyNormal),
        ),
      );
    },
  );
}
