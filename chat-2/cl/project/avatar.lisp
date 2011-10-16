;;; chat.lisp --- Chat program with avatars using RSB
;;
;; Copyright (C) 2011 Jan Moringen
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

(in-package :chat)

(defvar *avatar* (make-instance 'rst.vision:image
			       :width  32
			       :height 32
			       :data   (binio:make-octet-vector (* 32 32 3))))

(let ((avatar-url (puri:merge-uris "avatar/" *base-url*)))

  (defun start-avatar-server (nick avatar)
    (let* ((url    (puri:merge-uris nick avatar-url))
	   (server (rsb.patterns:make-local-server url)))
      (setf (rsb.patterns:server-method server "get")
	    #'(lambda () avatar))
      server))

  (defun get-avatar (nick)
    (with-remote-server (server (puri:merge-uris nick avatar-url))
      (call server "get" rsb.converter:+no-value+))))
