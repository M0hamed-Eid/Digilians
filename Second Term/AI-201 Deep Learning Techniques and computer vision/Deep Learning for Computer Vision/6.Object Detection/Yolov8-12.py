import os  # Import the OS module to interact with the operating system

os.environ["KMP_DUPLICATE_LIB_OK"] = "TRUE"  
# Fixes potential OpenMP library conflict error (common with PyTorch/Ultralytics)

from ultralytics import YOLO  # Import YOLO model from Ultralytics
import cv2  # Import OpenCV for video processing and visualization

font = cv2.FONT_HERSHEY_SIMPLEX  
# Define the font type to use when writing text on frames

model = YOLO('YoloV8 RPS.pt')  
# Load the trained YOLOv8 model (custom model file)

names = model.model.names  
# Get class names from the model (e.g., rock, paper, scissors)

font_scale = 1  
# Set font size for displayed text

thickness = 2  
# Set thickness of text (not used in putText but defined here)

cap = cv2.VideoCapture(0)  
# Start video capture from default webcam (0 = built-in camera)

# cap = cv2.VideoCapture("video.mp4")
# Use this line instead if you want to read from a video file

# cap = cv2.VideoCapture("http://192.168.10.1:8080/video") 
# Use this for an IP camera stream

# cap = link to video online
# You can provide an online video URL

# cap = cv2.VideoCapture(1) 
# Use this for an external camera if connected


while cap.isOpened():  
# Run the loop while the video capture is successfully opened

    success, frame = cap.read()  
    # Read a single frame from the video

    if not success:  
        # If frame was not read correctly
        print("Video frame is empty or video processing has been successfully completed.")
        # Print message if video ended or frame is empty
        break  
        # Exit the loop

    results = model.track(
        frame, 
        iou=0.5, 
        show=False, 
        tracker="bytetrack.yaml", 
        persist=True
    )  
    # Perform object detection + tracking on the frame
    # iou=0.5 → IOU threshold for tracking
    # show=False → Do not auto-display results
    # tracker="bytetrack.yaml" → Use ByteTrack tracking algorithm
    # persist=True → Keep tracking IDs across frames

    if results[0].boxes.id is not None:  
        # Check if tracked object IDs exist in the results

        track_ids = results[0].boxes.id.int().cpu().tolist()  
        # Get tracking IDs and convert to list

        clss = results[0].boxes.cls.int().cpu().tolist()  
        # Get detected class indices and convert to list

        boxes = results[0].boxes.xyxy.cpu()  
        # Get bounding box coordinates (x1, y1, x2, y2)

        conf = results[0].boxes.conf.tolist()  
        # Get confidence scores for detections

        for box, track_id, cof, c in zip(boxes, track_ids, conf, clss):  
            # Loop through each detected object

            x1, y1, x2, y2 = box.int().tolist()  
            # Convert bounding box coordinates to integers

            cv2.rectangle(frame, (x1, y1), (x2, y2), color=(255, 0, 0))  
            # Draw a blue rectangle around detected object

            cv2.putText(frame, names[c], (x1, y1 - 20), font, font_scale, (255, 0, 0))  
            # Display class name above bounding box

            cv2.putText(frame, str(track_id), (x2, y2 + 20), font, font_scale, (0, 255, 0))  
            # Display tracking ID below bounding box

    # Break the loop if 'q' is pressed
    cv2.imshow('img', frame)  
    # Show the processed frame in a window named 'img'

    if cv2.waitKey(1) & 0xFF == ord("q"):  
        # Wait 1ms for key press, exit if 'q' is pressed
        break

cap.release()  
# Release the video capture object

cv2.destroyAllWindows()  
# Close all OpenCV windows
