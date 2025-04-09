#!/bin/bash

# Function to perform find and replace in files
find_and_replace() {
    find . -type f -not -path "*/\.*" -not -name "rename.sh" -exec sed -i '' "s/InterviewTemp/Interview/g" {} +
    find . -type f -not -path "*/\.*" -not -name "rename.sh" -exec sed -i '' "s/interview_temp/interview/g" {} +
}

# Rename directories
mv lib/interview_temp lib/interview 2>/dev/null || true
mv lib/interview_temp.ex lib/interview.ex 2>/dev/null || true
mv lib/interview_temp_web lib/interview_web 2>/dev/null || true
mv lib/interview_temp_web.ex lib/interview_web.ex 2>/dev/null || true
mv test/interview_temp test/interview 2>/dev/null || true
mv test/interview_temp_web test/interview_web 2>/dev/null || true

# Perform find and replace
find_and_replace

echo "Rename complete. Please review the changes and run mix compile to verify." 