;;;; chat.lisp --- Simple chat program using RSB.
;;;;
;;;; Copyright (C) 2011, 2012, 2013, 2014 Jan Moringen
;;;;
;;;; Author: Jan Moringen <jmoringe@techfak.uni-bielefeld.de>

(cl:in-package #:chat)

(defvar *base-url* "/chat/")

(defun chat (nick)
  (let* ((text-url  (puri:merge-uris "text/" *base-url*))
         (speak-url (puri:merge-uris nick text-url)))
    (with-informer (i speak-url t)
      (with-listener (l text-url)
        (setf (receiver-filters l)
              (list (complement (filter :origin :origin (participant-id i)))))
        (with-handler l
            ((event)
             (format *standard-output* "~C ~A: ~A~%> "
                     #\Return
                     (lastcar (scope-components (event-scope event)))
                     (event-data event))
             (finish-output *standard-output*))
          (loop (format *standard-output* "> ")
             (finish-output *standard-output*)
             (let ((line (read-line)))
               (when (string= line "/quit")
                 (return))
               (send i line))))))))
