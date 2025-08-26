#!/bin/bash

# This script generates the test coverage report for the project.

# Exit immediately if a command exits with a non-zero status.
set -e

mkdir -p build/results

echo "Step 1: Running tests with coverage and excluding manual tests..."
flutter test --coverage --exclude-tags manual
mv coverage build/results/

echo "Step 2: Generating HTML report from coverage data..."
genhtml build/results/coverage/lcov.info -o build/results/coverage/html

echo "Coverage report generated successfully at build/results/coverage/html/index.html"
