from ultralytics import YOLO
import cv2
import numpy as np

font = cv2.FONT_HERSHEY_SIMPLEX
font_scale = 1
thickness = 2

model = YOLO('yolov8n.pt') 
names = model.model.names
print(names)

{0: 'person', 1: 'bicycle', 2: 'car', 3: 'motorcycle', 4: 'airplane', 5: 'bus', 6: 'train', 7: 'truck', 8: 'boat', 9: 'traffic light',
  10: 'fire hydrant', 11: 'stop sign', 12: 'parking meter', 13: 'bench', 14: 'bird', 15: 'cat', 16: 'dog', 17: 'horse', 18: 'sheep',
    19: 'cow', 20: 'elephant', 21: 'bear', 22: 'zebra', 23: 'giraffe', 24: 'backpack', 25: 'umbrella', 26: 'handbag', 27: 'tie',
      28: 'suitcase', 29: 'frisbee', 30: 'skis', 31: 'snowboard', 32: 'sports ball', 33: 'kite', 34: 'baseball bat', 35: 'baseball glove',
        36: 'skateboard', 37: 'surfboard', 38: 'tennis racket', 39: 'bottle', 40: 'wine glass', 41: 'cup', 42: 'fork', 43: 'knife',
          44: 'spoon', 45: 'bowl', 46: 'banana', 47: 'apple', 48: 'sandwich', 49: 'orange', 50: 'broccoli', 51: 'carrot', 52: 'hot dog',
            53: 'pizza', 54: 'donut', 55: 'cake', 56: 'chair', 57: 'couch', 58: 'potted plant', 59: 'bed', 60: 'dining table', 61: 'toilet',
              62: 'tv', 63: 'laptop', 64: 'mouse', 65: 'remote', 66: 'keyboard', 67: 'cell phone', 68: 'microwave', 69: 'oven',
                70: 'toaster', 71: 'sink', 72: 'refrigerator', 73: 'book', 74: 'clock', 75: 'vase', 76: 'scissors', 77: 'teddy bear',
                    78: 'hair drier', 79: 'toothbrush'}

cap = cv2.VideoCapture("traffictrim.mp4")

while cap.isOpened():

    success, frame = cap.read()
    print(frame)
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