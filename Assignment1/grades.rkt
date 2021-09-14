;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname grades) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *
;; Yifeng Tang (20685656)
;; CS 135 WINTER 2017
;; Assignment 01, problem 3
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *

;; question a
(define mid-rate (/ 25 100))
(define par-rate (/ 5 100))
(define ass-rate (/ 20 100))
(define b-rate (/ 200 100))
(define (cs135-grade-sofar mid-grade par-grade ass-grade)
  (* b-rate ( + (+ (* mid-rate mid-grade)
                   (* par-rate par-grade))
                (* ass-rate ass-grade))))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *

;; question b
(define fin-rate (/ 50 100))
(define a-rate (/ 50 100))
(define (cs135-final-exam final-grade cs135-grade-sofar)
  (+ (* cs135-grade-sofar a-rate)
     (* final-grade fin-rate)))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *

;; question c
(define a 1.02)
(define (cs135-final-grade cs135-final-exam)
  (min 100
       (* a cs135-final-exam)))
