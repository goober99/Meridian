;;; Meridian - Timeline Creator

#lang racket

(require rackunit)              ; Import Test Framework
(require "../lib/timeline.scm") ; Import file to test

(test-case
  "Timeline data"
  ;; Try adding an event to the timeline:
  (check-equal? (add-point  "1941" "Citizen Kane")
                (list (list "1941" "Citizen Kane")))
                
  ;; Add an event that should be sorted after prev event:
  (check-equal? (add-point  "1946" "The Stranger")
                (list (list "1941" "Citizen Kane")
                      (list "1946" "The Stranger")))
  
  ;; Add an event that should be sorted between other two:
  (check-equal? (add-point  "1942" "The Magnificent Ambersons")
                (list (list "1941" "Citizen Kane")
                      (list "1942" "The Magnificent Ambersons")
                      (list "1946" "The Stranger"))))
