import os
os.environ["KMP_DUPLICATE_LIB_OK"] = "TRUE"

from ultralytics import YOLO
import cv2

# Init
model = YOLO('YoloV8 RPS.pt')
names = model.model.names

font = cv2.FONT_HERSHEY_SIMPLEX
font_scale = 1
thickness = 2

cap = cv2.VideoCapture("WhatsApp Video 2025-09-23 at 21.45.33_0d33387e.mp4")

while cap.isOpened():

    success, frame = cap.read()
    if not success:
        print("✅ Video finished.")
        break

    # 🔹 Use ByteTrack (change here)
    results = model.track(
        frame,
        persist=True,
        tracker="bytetrack.yaml",   # ✅ switched from botsort → bytetrack , botsort.yaml → bytetrack.yaml
        conf=0.25,
        verbose=False                # ✅ prints tracking info
    )[0]

    
    # 🔹 Safety check
    if results.boxes is not None and len(results.boxes) > 0:

        boxes = results.boxes.xyxy.cpu()

        clss = results.boxes.cls.int().cpu().tolist()
        confs = results.boxes.conf.cpu().tolist()
        track_ids = results.boxes.id

        if track_ids is not None:
            track_ids = track_ids.int().cpu().tolist()
        else:
            track_ids = [None] * len(boxes)

        for box, track_id, conf, cls_id in zip(boxes, track_ids, confs, clss):
            x1, y1, x2, y2 = map(int, box.tolist())

            label = f"{names[cls_id]} | ID {track_id} | {conf:.2f}"

            # Draw bounding box
            cv2.rectangle(frame, (x1, y1), (x2, y2), (255, 0, 0), 2)

            # Draw label
            cv2.putText(frame, label, (x1, y1 - 10),
                        font, font_scale, (255, 0, 0), thickness)

    # 🔹 Show frame
    cv2.imshow("ByteTrack Tracking", frame)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

cap.release()
cv2.destroyAllWindows()