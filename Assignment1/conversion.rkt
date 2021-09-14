;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname conversion) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *
;; Yifeng Tang (20685656)
;; CS 135 WINTER 2017
;; Assignment 01, problem 2
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *

;; question a
(define number 32)
(define rate (/ 5 9))
(define (f->c F)
  (* (- F number) rate))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *

;; question b
(define numbere 32)
(define y (/ 9 5))
(define (c->f C)
   (+ (* y C) number))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *

;; question c
(define x (/ 2.2 35.2))
(define (ounces->pounds o)
  (* x o))

  