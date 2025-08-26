#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

REPORT_JSON="build/results/report.json"
JUNIT_XML="build/results/junit_report.xml"
HTML_REPORT="build/results/test_report.html"

mkdir -p build/results

echo "Step 1: Running Flutter tests and generating JSON report..."
# Run tests and allow failures, redirecting output to JSON file
flutter test --machine --exclude-tags manual > "$REPORT_JSON" || true
ls -l "$REPORT_JSON"

echo "Step 2: Activating junitreport Dart package (if not already active)..."
flutter pub global activate junitreport

echo "Step 3: Converting JSON report to JUnit XML format..."
flutter pub global run junitreport:tojunit --input "$REPORT_JSON" --output "$JUNIT_XML"
ls -l "$JUNIT_XML"

echo "Step 4: Installing junit2html Python package..."
pip3 install junit2html

echo "Step 5: Converting JUnit XML to HTML report using junit2html..."
junit2html "$JUNIT_XML" "$HTML_REPORT"
ls -l "$HTML_REPORT"

echo "Test report generated successfully at $HTML_REPORT"
# Removed cleanup step for debugging
# rm "$REPORT_JSON" "$JUNIT_XML"

echo "Done."
