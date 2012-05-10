;;; Meridian - Timeline Creator

;;; Copyright (C) 2011-2012 Matthew D. Miller

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

(provide display-timeline timeline-to-text)

(define (display-timeline dc timeline-data scale)
  (letrec ([year-to-pixels 10]
           [horiz-pos 50]
           [start-year (string->number (caar timeline-data))]
           [plot-points (lambda (timeline-data)
             (let ([prev-year (string->number (caar timeline-data))]
                   [trimmed-timeline (cdr timeline-data)])
	             (if (< (length trimmed-timeline) 1)
	               (begin
	                 (send dc set-pen "black" 1 'solid)
	                 (send dc draw-line horiz-pos 0 horiz-pos (* (+ (- prev-year start-year) 1) year-to-pixels)))
	               (begin
	                 (let ([this-year (string->number (caar trimmed-timeline))])
	                   (send dc draw-point horiz-pos (- (* (+ (- this-year start-year) 1) year-to-pixels) (/ year-to-pixels 2))))
	                 (plot-points trimmed-timeline)))))])
    (send dc set-pen "black" 5 'solid)
    (send dc draw-point horiz-pos (/ year-to-pixels 2))
    (plot-points timeline-data)))
        
(define (timeline-to-text timeline-data scale)
  (define (span gap bridge)
    (if (< gap 1)
      bridge
      (span (- gap 1) (string-append bridge "     |\n"))))
  (define (builder timeline-data timeline)
    (if (< (length timeline-data) 1)
      timeline
      (let ([timeline-point (car timeline-data)])
        (builder (cdr timeline-data)
          (string-append timeline
                         (car timeline-point)
                         " | "
                         (cadr timeline-point)
                         "\n"
                         (if (> (length timeline-data) 1)
                           (span (* (/ scale 100)
                                 (- (- (string->number (caadr timeline-data))
                                       (string->number (car timeline-point))) 1)) "")
                         ""))))))
  (builder timeline-data ""))