;;; chat.lisp --- Simple chat program using RSB.
;;
;; Copyright (C) 2011, 2012 Jan Moringen
;;
;; Author: Jan Moringen <jmoringe@techfak.uni-bielefeld.de>
;;
;; This Program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This Program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses>.

(cl:in-package :chat)

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
