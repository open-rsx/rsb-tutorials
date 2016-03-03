;;;; chat-1.asd --- System definition for chat-1 tutorial.
;;;;
;;;; Copyright (C) 2011-2016 Jan Moringen
;;;;
;;;; Author: Jan Moringen <jmoringe@techfak.uni-bielefeld.de>

(defsystem :chat-1
  :author      "Jan Moringen <jmoringe@techfak.uni-bielefeld.de>"
  :maintainer  "Jan Moringen <jmoringe@techfak.uni-bielefeld.de>"
  :version     "0.1.0"
  :license     "GPLv3+"
  :description "Simple RSB-based chat application."
  :depends-on  (:cl-rsb)
  :components  ((:file       "package")
                (:file       "chat"
                 :depends-on ("package"))))
