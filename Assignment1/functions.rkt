;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *
;; Yifeng Tang (20685656)
;; CS 135 WINTER 2017
;; Assignment 01, problem 1
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *
;;
;; question(a)
(define (recall tp fn)
  (/ tp (+ tp fn)))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *

;; question(b)
(define g 9.8)
(define (height v t)
  (- (* v t) (* (* (* 0.5 g) t) t)))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *

;; question(c)
(define (stirling n)
  (* (sqrt (* (* 2 pi) n)) (expt (/ n e) n)))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *

;; question(d)
(define (logit p)
  (log (/ p (- 1 p))))