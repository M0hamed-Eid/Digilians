from ultralytics import YOLO
import cv2

font = cv2.FONT_HERSHEY_SIMPLEX
font_scale = 1
thickness = 2

model = YOLO('YoloV8 RPS.pt') 
names = model.model.names
print(names)



cap = cv2.VideoCapture("WhatsApp Video 2025-09-23 at 21.45.33_0d33387e.mp4")

while cap.isOpened():

    success, frame = cap.read()
    if not success:
        print("Video frame is empty or video processing has been successfully completed.")
        break

    
    results = model.predict(frame , show=False,verbose = False)[0] 

    # 🔹 Safety check
    if results.boxes is not None and len(results.boxes) > 0:

        boxes = results.boxes.xyxy.cpu()
        clss = results.boxes.cls.int().cpu().tolist()
        confs = results.boxes.conf.cpu().tolist()

        for box, conf, cls_id in zip(boxes, confs, clss):
            x1, y1, x2, y2 = map(int, box.tolist())

            label = f"{names[cls_id]} | {conf:.2f}"

            # Draw bounding box
            cv2.rectangle(frame, (x1, y1), (x2, y2), (255, 0, 0), 2)

            # Draw label
            cv2.putText(frame, label, (x1, y1 - 10),
                        font, font_scale, (255, 0, 0), thickness)
            
    # Break the loop if 'q' is pressed
    cv2.imshow('img',frame)
    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

cap.release()
cv2.destroyAllWindows()