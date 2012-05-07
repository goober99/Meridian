;;; Meridian - Timeline Creator

#lang racket

(require rackunit)              ; Import Test Framework
(require "../lib/timeline.scm") ; Import file to test

(test-case
  "Adding events to timeline"
  
  ;; Add an event to the timeline:
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

;(test-case
;  "Modifying events on timeline"
;  ;; Add Orson Welles first movie with wrong date and misspelled:
;  (add-point "1940" "Citizen Cane")
;  
;  ;; Fix date:
;  (check-equal? (modify-date "1940" "1941")
;                (list (list  "1941" "Citizen Cane")))
;  
;  ;; Correct misspelling:
;  (check-equal? (edit-desc  "1941" "Citizen Kane")
;                (list (list "1941" "Citizen Kane"))))
;
;(test-case
;  "Removing events from timeline"
;  ;; Add a couple movies to timeline:
;  (add-point "1941" "Citizen Kane")
;  (add-point "1967" "Casino Royale")
;  
;  ;; Remove movie not directed by Orson Welles:
;  (check-equal? (remove-point "1967")
;                (list (list "1941" "Citizen Kane")))
;                
;  ;; Removing the only event should result in an empty list:
;  (check-equal? (remove-point "1941") '()))