#!/bin/bash

ZIP_PATH=$(ls -t ~/rom/out/target/product/surya/lineage*.zip | head -n 1)
ZIP_NAME=$(basename "$ZIP_PATH")

if [ -f "$ZIP_PATH" ]; then
    curl -s https://api.telegram.org/bot$tokentl/sendMessage -d chat_id=$idtl -d text="📤 Uploading Build: $ZIP_NAME"
    rclone copy "$ZIP_PATH" komom:lineage -P
    curl -s https://api.telegram.org/bot$tokentl/sendMessage -d chat_id=$idtl -d text="✅ Build $ZIP_NAME Uploaded Successfully!"
else
    echo "Zip file not found!"
    exit 1
fi
