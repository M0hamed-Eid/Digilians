import cv2
import torch
from ultralytics import YOLO

# Path to your model
model_path = "yolov8_Face.pt"

# Load YOLOv8 model
model = YOLO(model_path)

# Select device
device = 0 if torch.cuda.is_available() else "cpu"

# Open webcam
cap = cv2.VideoCapture(0)

if not cap.isOpened():
    print("Error: Could not open webcam")
    exit()

print("Press 'q' to exit")

while True:
    ret, frame = cap.read()
    if not ret:
        break

    # Run YOLOv8 inference
    results = model.predict(
        source=frame,
        conf=0.4,
        device=device,
        verbose=False
    )

    # Draw detections
    for result in results:
        if result.boxes is None:
            continue

        boxes = result.boxes.xyxy.cpu().numpy()

        for box in boxes:
            x1, y1, x2, y2 = map(int, box[:4])

            cv2.rectangle(frame, (x1, y1), (x2, y2), (0,255,0), 2)
            cv2.putText(
                frame,
                "Face",
                (x1, y1-10),
                cv2.FONT_HERSHEY_SIMPLEX,
                0.7,
                (0,255,0),
                2
            )

    # Show frame
    cv2.imshow("YOLOv8 Face Detection", frame)

    # Exit on 'q'
    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

cap.release()
cv2.destroyAllWindows()