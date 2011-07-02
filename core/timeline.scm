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

(provide add-point)

(define add-point
  (let ([timeline-data '()])
    (lambda (year desc scale)
      (and (and year desc)
        (set! timeline-data (append timeline-data (list (list year desc)))))
      (build-timeline (sort timeline-data (lambda (a b)
                        (< (string->number (car a)) (string->number (car b)))))
                      scale))))

(define (build-timeline timeline-data scale)
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
