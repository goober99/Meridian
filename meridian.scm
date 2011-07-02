;;; Meridian - Timeline Creator

;;; Copyright (C) 2011 Matthew D. Miller

;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.

;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.

;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

#lang racket

;; Racket Libraries
(require racket/gui)
;; Meridian Libraries
(require "core/timeline.scm")

(define frame (new frame% [label "Timeline"]))

(define input-panel (new horizontal-panel% [parent frame]))
(define year-field (new text-field% [label "Year:"]
                                    [parent input-panel]))
(define desc-field (new text-field% [label "Description:"]
                                    [parent input-panel]))
(new button% [label "Add to Timeline"]
             [parent input-panel]
             [callback (lambda (button event)
                         (send timeline-display set-value (add-point (send year-field get-value)
                                                                     (send desc-field get-value)
                                                                     (send scale-control get-value)))
                         ;; Reset fields:
                         (send year-field set-value "")
                         (send desc-field set-value ""))])

(define timeline-display (new text-field% [label #f]
                                          [parent frame]
                                          [style '(multiple)]
                                          [font (make-font #:family 'modern)]
                                          [min-height 250]))

(define scale-control (new slider% [label #f]
                                   [min-value 1]
                                   [max-value 200]
                                   [parent frame]
                                   [callback (lambda (button event)
                                               (send timeline-display set-value (add-point #f #f (send button get-value))))]
                                   [init-value 100]))

(send frame show #t)
