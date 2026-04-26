import os
import json
import cv2
import numpy as np
from PIL import Image
from tqdm import tqdm

# === CONFIGURATION ===
input_folder = "dataset"
images_folder = os.path.join(input_folder, "images")
masks_folder = os.path.join(input_folder, "masks")

# === CREATE OUTPUT FOLDERS ===
os.makedirs(masks_folder, exist_ok=True)

# === PROCESS EACH FILE IN images/ ===
for file in tqdm(os.listdir(images_folder)):
    if file.endswith(".json"):
        json_path = os.path.join(images_folder, file)

        with open(json_path, 'r') as f:
            data = json.load(f)

        # Get image filename correctly
        image_filename = os.path.basename(data["imagePath"])
        image_path = os.path.join(images_folder, image_filename)

        if not os.path.exists(image_path):
            print("Image NOT found:", image_path)
            continue

        # Read the image (optional)
        img = cv2.imread(image_path)

        # Prepare blank mask
        h, w = data["imageHeight"], data["imageWidth"]
        mask = np.zeros((h, w), dtype=np.uint8)

        # Draw polygons
        for shape in data["shapes"]:
            pts = np.array(shape["points"], dtype=np.int32)
            cv2.fillPoly(mask, [pts], 255)

        # Save mask
        mask_name = os.path.splitext(image_filename)[0] + "_mask.png"
        mask_path = os.path.join(masks_folder, mask_name)
        cv2.imwrite(mask_path, mask)

print("✔ Masks saved inside:", masks_folder)
