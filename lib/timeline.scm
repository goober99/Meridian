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

(provide add-point)

(define add-point
  (let ([timeline-data '()])
    (lambda (year desc)
      (and (and year desc)
        (set! timeline-data (append timeline-data (list (list year desc)))))
      (sort timeline-data (lambda (a b)
        (< (string->number (car a)) (string->number (car b))))))))
