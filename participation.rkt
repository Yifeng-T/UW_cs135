;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname participation) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *
;; Yifeng Tang (20685656)
;; CS 135 WINTER 2017
;; Assignment 01, problem 4
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *

;; let a presents the total number of clicker questions asked in the year.
;; let b prestnts the number of questions you answered correctly.
;; let c presents the number of questions you answered incorrectly.
;;


(define (cs135-participation a b c)
  (* 100
     (/ (+ (* 2 (min (* 0.75 a) b))
           (max (min (- (* 0.75 a) b) c) 0))
        (* 0.75 2 a))))