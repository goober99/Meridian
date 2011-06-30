#lang racket

;;;; ------------------------- INTERFACE ------------------------- ;;;;

(require racket/gui)

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
                                                                     (send desc-field get-value)))
                         ;; Reset fields:
                         (send year-field set-value "")
                         (send desc-field set-value ""))])

(define timeline-display (new text-field% [parent frame]
                                          [label ""]
                                          [style '(multiple)]
                                          [font (make-font #:family 'modern)]
                                          [min-height 250]))

(send frame show #t)

;;;; --------------------- APPLICATION LOGIC --------------------- ;;;;

(define add-point
  (let ([timeline-data '()])
    (lambda (year desc)
      (set! timeline-data (append timeline-data (list (list year desc))))
      (build-timeline (sort timeline-data (lambda (a b)
        (< (string->number (car a)) (string->number (car b)))))))))

(define (build-timeline timeline-data)
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
                           (span (- (- (string->number (caadr timeline-data))
                                       (string->number (car timeline-point))) 1) "")
                         ""))))))
  (builder timeline-data ""))
