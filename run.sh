#!/bin/bash
# Run this script to generate all the necessary code files

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs 