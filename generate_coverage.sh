#!/bin/bash

# This script generates the test coverage report for the project.

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Step 1: Running tests with coverage and excluding manual tests..."
flutter test --coverage --exclude-tags manual

echo "Step 2: Generating HTML report from coverage data..."
genhtml coverage/lcov.info -o coverage/html

echo "Coverage report generated successfully at coverage/html/index.html"
