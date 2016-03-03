;;;; chat.lisp --- Simple chat program using RSB.
;;;;
;;;; Copyright (C) 2011-2016 Jan Moringen
;;;;
;;;; Author: Jan Moringen <jmoringe@techfak.uni-bielefeld.de>

(cl:in-package #:chat)

(defvar *base-url* "/chat/")

(defun chat (nick)
  (let* ((text-url  (puri:merge-uris "text/" *base-url*))
         (speak-url (puri:merge-uris nick text-url)))
    (with-participants ((i :informer speak-url)
                        (l :listener text-url
                           :filters (list (complement (filter :origin :origin (participant-id i))))))
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
                (send i line)))))))
