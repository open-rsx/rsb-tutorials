;;;; package.lisp --- Package definition for chat system.
;;;;
;;;; Copyright (C) 2011, 2013 Jan Moringen
;;;;
;;;; Author: Jan Moringen <jmoringe@techfak.uni-bielefeld.de>

(cl:defpackage #:chat
  (:use
   #:cl
   #:alexandria
   #:rsb
   #:rsb.filter
   #:rsb.patterns)

  (:export
   ;; chat-1
   #:chat

   ;; chat-2
   #:*avatar*

   #:start-avatar-server
   #:get-avatar))
