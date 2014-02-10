;;;; chat.lisp --- Chat program with avatars using RSB
;;;;
;;;; Copyright (C) 2011, 2012, 2013 Jan Moringen
;;;;
;;;; Author: Jan Moringen <jmoringe@techfak.uni-bielefeld.de>

;; mark-start::body
(cl:in-package :chat)

(defvar *avatar* (make-instance 'rst.vision:image
				:width	32
				:height 32
				:data	(nibbles:make-octet-vector (* 32 32 3))))

(let ((avatar-url (puri:merge-uris "avatar/" *base-url*)))

  (defun start-avatar-server (nick avatar)
    (let* ((url	   (puri:merge-uris nick avatar-url))
	   (server (rsb.patterns:make-local-server url)))
      (setf (rsb.patterns:server-method server "get")
	    #'(lambda () avatar))
      server))

  (defun get-avatar (nick)
    (with-remote-server (server (puri:merge-uris nick avatar-url))
      (call server "get" rsb.converter:+no-value+))))
;; mark-end::body
