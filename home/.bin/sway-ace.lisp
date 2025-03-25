(ql:quickload '(:cffi :ltk :json))

(defpackage :sway-ace
            (:use :cl :ltk))

(in-package :sway-ace)

(cffi:define-foreign-library i3-ipc
                             (:unix "libi3ipc.so"))

(defclass window-overlay ()
  ((window :accessor window-id :initarg :id)
   (overlay :accessor overlay-widget)
   (key :accessor key-char :initarg :key)))

(defun create-overlay (window key)
  (let* ((overlay (make-instance 'toplevel))
         (label (make-instance 'label 
                               :text (string key)
                               :font "Arial 24")))
    (wm-overrideredirect overlay 1)
    (setf (geometry-manager label) :pack)
    (wm-geometry overlay 
                 (format nil "+~A+~A" 
                         (+ (window-x window) 10)
                         (+ (window-y window) 10)))
    overlay))

(defun get-windows ()
  (let* ((conn (i3-connect))
         (tree (get-tree conn)))
    (get-leaves tree)))

(defun window-picker ()
  (let* ((windows (get-windows))
         (overlays (make-hash-table))
         (keys "asdfghjkl"))
    (loop for win in windows
          for key across keys
          do (setf (gethash key overlays)
                   (make-instance 'window-overlay 
                                  :id (window-id win)
                                  :key key
                                  :overlay (create-overlay win key))))
    (focus-selected overlays)))

(defun focus-selected (overlays)
  (let ((key (read-char)))
    (when-let ((win (gethash key overlays)))
      (focus-window (window-id win))
      (cleanup-overlays overlays))))
