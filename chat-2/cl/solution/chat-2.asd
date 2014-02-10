;;;; chat-2.asd --- System definition for chat-2 tutorial.
;;;;
;;;; Copyright (C) 2011, 2012, 2013 Jan Moringen
;;;;
;;;; Author: Jan Moringen <jmoringe@techfak.uni-bielefeld.de>

(cl:defpackage :chat-2-system
  (:use
   :cl
   :asdf))

(cl:in-package :chat-2-system)

(defsystem :chat-2
  :author      "Jan Moringen <jmoringe@techfak.uni-bielefeld.de>"
  :maintainer  "Jan Moringen <jmoringe@techfak.uni-bielefeld.de>"
  :version     "0.1.0"
  :license     "GPLv3+"
  :description "Simple RSB-based chat application."
  :depends-on  (:cl-rsb
		:chat-1)
  :components  ((:file       "avatar")))
