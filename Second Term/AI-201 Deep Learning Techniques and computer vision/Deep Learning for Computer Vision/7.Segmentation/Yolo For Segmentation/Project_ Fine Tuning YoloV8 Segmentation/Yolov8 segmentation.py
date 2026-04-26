import os
os.environ["KMP_DUPLICATE_LIB_OK"] = "TRUE"   # Fix for Intel MKL duplicate library issue

import cv2
import numpy as np
from ultralytics import YOLO
from ultralytics.utils.plotting import Annotator, colors

# ============================
# Load YOLOv8 Segmentation Model
# ============================
model = YOLO("yolov8n-seg.pt")   # You can replace with your custom best.pt

# ============================
# Open input video
# ============================
cap = cv2.VideoCapture("traffictrim.mp4")

# Get video width, height, and fps
w, h, fps = (int(cap.get(x)) for x in (
    cv2.CAP_PROP_FRAME_WIDTH,
    cv2.CAP_PROP_FRAME_HEIGHT,
    cv2.CAP_PROP_FPS
))

# ============================
# Create output video writer
# ============================
out = cv2.VideoWriter(
    'instance-segmentation-object-tracking.avi',
    cv2.VideoWriter_fourcc(*'MJPG'),
    fps,
    (w, h)
)

# ============================
# Process each frame
# ============================
while True:
    ret, im0 = cap.read()
    if not ret:
        print("Video frame is empty or processing completed.")
        break

    # Annotator for drawing masks and labels
    annotator = Annotator(im0, line_width=2)

    # ============================
    # Run model tracking + segmentation
    # persist=True → keeps same IDs across frames
    # tracker="bytetrack.yaml" → using ByteTrack
    # ============================
    results = model.track(
        im0,
        iou=0.5,
        show=False,
        persist=True,
        tracker="bytetrack.yaml"
    )

    # Ensure we have both segmentation masks and tracking IDs
    if results[0].boxes.id is not None and results[0].masks is not None:
        
        masks = results[0].masks.xy          # Polygons of segmentation masks
        track_ids = results[0].boxes.id.int().cpu().tolist()  # Object IDs

        # ============================
        # Draw each mask + its tracking ID
        # ============================
        for mask, track_id in zip(masks, track_ids):

            # Draw segmentation mask using YOLO annotator
            annotator.seg_bbox(
                mask=mask,
                mask_color=colors(track_id, True),
                track_label=str(track_id)
            )

            # Draw mask polygon outline
            cv2.polylines(
                im0,
                [np.int32([mask])],
                isClosed=True,
                color=(255, 0, 0),
                thickness=2
            )

            # Draw tracking ID text at the first mask point
            #cv2.putText(
             #   im0,
              #  f'{track_id}',
               # (int(mask[0][0]), int(mask[0][1])),
                #cv2.FONT_HERSHEY_SIMPLEX,
                #1.2,
                #(255, 0, 0),
                #3
            #)

    # Write frame to output video
    out.write(im0)

    # Show frame on screen
    cv2.imshow("instance-segmentation-object-tracking", im0)

    # Quit if user presses Q
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# ============================
# Cleanup
# ============================
out.release()
cap.release()
cv2.destroyAllWindows()
