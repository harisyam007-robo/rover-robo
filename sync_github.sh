#!/bin/bash

cd "$HOME/ros2_ws" || exit 1

echo "Checking project changes..."

git add -A

if git diff --cached --quiet; then
    echo "No changes to upload."
    exit 0
fi

git commit -m "Update ROS 2 rover project"

if [ $? -ne 0 ]; then
    echo "Commit failed."
    exit 1
fi

git pull --rebase origin main

if [ $? -ne 0 ]; then
    echo "Pull failed. Resolve conflicts before pushing."
    exit 1
fi

git push origin main

echo "GitHub sync completed!"
