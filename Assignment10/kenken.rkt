;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname kenken) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *
;; Yifeng Tang (20685656)
;; CS 135 WINTER 2017
;; Assignment 10, problem 1
;;* * * * * * * * * * * * * * * * * * * * * * * * * * *
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
(require "kenken-draw.rkt")

(define-struct puzzle (size board constraints))
;; A Puzzle is a (make-puzzle 
;;                Nat 
;;                (listof (listof (anyof Sym Nat Guess)))
;;                (listof (list Sym Nat (anyof '+ '- '* '/ '=))))
;; requires: See Assignment Specifications

(define-struct guess (symbol number))
;; A Guess is a (make-guess Sym Nat)
;; requires: See Assignment Specifications

;; Some useful constants
;; from assignment specification


(define puzzle1
  (make-puzzle 
   4
   (list
    (list 'a 'b 'b 'c)
    (list 'a 'd 'e 'e)
    (list 'f 'd 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'd 5 '+)
    (list 'e 3 '-)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1
(define puzzle1partial
  (make-puzzle 
   4
   (list
    (list 'a 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1 with a cage partially filled in
(define puzzle1partial2
  (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) 'b 'b 'c)
    (list 'a 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; a partial solution to puzzle1 with a cage partially filled in
;; but not yet verified 
(define puzzle1partial3
  (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) 'b 'b 'c)
    (list (make-guess 'a 3) 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 6 '*)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-))))

;; The solution to puzzle 1
(define puzzle1soln
  (make-puzzle
   4
   '((2 1 4 3)
     (3 2 1 4)
     (4 3 2 1)
     (1 4 3 2))
   empty))

;; wikipedia KenKen example
(define puzzle2
  (make-puzzle
   6
   '((a b b c d d)
     (a e e c f d)
     (h h i i f d)
     (h h j k l l)
     (m m j k k g)
     (o o o p p g))
   '((a 11 +)
     (b 2 /)
     (c 20 *)
     (d 6 *)
     (e 3 -)
     (f 3 /)
     (g 9 +)
     (h 240 *)
     (i 6 *)
     (j 6 *)
     (k 7 +)
     (l 30 *)
     (m 6 *)
     (o 8 +)
     (p 2 /))))

;; The solution to puzzle 2
(define puzzle2soln
  (make-puzzle
   6
   '((5 6 3 4 1 2)
     (6 1 4 5 2 3)
     (4 5 2 3 6 1)
     (3 4 1 2 5 6)
     (2 3 6 1 4 5)
     (1 2 5 6 3 4))
   empty))

;; Tiny board
(define puzzle3
  (make-puzzle 
   2 
   '((a b) 
     (c b)) 
   '((b 3 +) 
     (c 2 =)
     (a 1 =))))

(define puzzle3partial
  (make-puzzle
   2 
   (list
    (list 'a (make-guess 'b 1))
    (list 'c (make-guess 'b 2)))
   '((b 3 +) 
     (c 2 =)
     (a 1 =))))  

;; a big board:  will take a *long* time without trying the bonus
(define puzzle4
  (make-puzzle
   9
   '((a a b c d e e f f)
     (g h b c d i j k l)
     (g h m m i i j k l)
     (n o m p p q q r s)
     (n o t u p v v r s)
     (n w t u x x y z z)
     (A w B C C C y D D)
     (A B B E E F G H I)
     (J J K K F F G H I))
   '((a 2 /)
     (b 11 +)
     (c 1 -)
     (d 7 *)
     (e 4 -)
     (f 9 +)
     (g 1 -)
     (h 4 /)
     (i 108 *)
     (j 13 +)
     (k 2 -)
     (l 5 -)
     (m 84 *)
     (n 24 *)
     (o 40 *)
     (p 18 *)
     (q 2 /)
     (r 2 -)
     (s 13 +)
     (t 10 +)
     (u 13 +)
     (v 2 -)
     (w 63 *)
     (x 1 -)
     (y 3 /)
     (z 2 /)
     (A 7 +)
     (B 13 +)
     (C 336 *)
     (D 1 -)
     (E 15 +)
     (F 12 *)
     (G 9 +)
     (H 5 -)
     (I 18 *)
     (J 3 /)
     (K 40 *))))

;;==============================================================================
;;1(a)
;; (find-blank puz) produces the position of the first blank
;; space in puz, or false if no cells are blank.  If the first constraint has
;; only guesses on the board, find-blank produces 'guess.  
;; find-blank: Puzzle -> (anyof Posn false 'guess)
;; Examples:
(check-expect (find-blank puzzle1) (make-posn 0 0))
(check-expect (find-blank (make-puzzle 1 '((r)) '((r 1 =)))) (make-posn 0 0))  ;; Test 001
(check-expect (find-blank (make-puzzle 2 '((a b) (c d))  ;; Test 002
                                       '((a 2 =) (b 1 =) (c 1 =) (d 2 =))))
              (make-posn 0 0))
(check-expect (find-blank (make-puzzle 2 '((a b) (c d))  ;; Test 003
                                       '((c 1 =) (b 1 =) (d 2 =) (a 2 =))))
              (make-posn 0 1))


;;Helper Function:
;;(check puz p q)find the first blank
;;check: Puzzle Num Num -> (anyof Posn false ;guess)
(define (check puz p q)
  (cond
    [(empty? (puzzle-constraints puz))
     false]
    [(empty? (puzzle-board puz)) 'guess]
    
    [(empty? (first (puzzle-board puz)))
     (check (make-puzzle (puzzle-size puz)
                         (rest (puzzle-board puz))
                         (puzzle-constraints puz)) 0 (add1 q))]
    [(equal? (first (first (puzzle-constraints puz)))
               (first (first (puzzle-board puz)))) (make-posn p q)]
    [else (check (make-puzzle (puzzle-size puz)
                              (cons (rest (first (puzzle-board puz)))
                                    (rest (puzzle-board puz)))
                              (puzzle-constraints puz)) (add1 p) q)])) 
;;Main Function:                              
(define (find-blank puz)
  (check puz 0 0))

;;Tests:
(check-expect (find-blank (make-puzzle 1 '((r)) '((r 1 =)))) (make-posn 0 0))  ;; Test 001
(check-expect (find-blank (make-puzzle 2 '((a b) (c d))  ;; Test 002
                                       '((a 2 =) (b 1 =) (c 1 =) (d 2 =))))
              (make-posn 0 0))
(check-expect (find-blank (make-puzzle 2 '((a b) (c d))  ;; Test 003
                                       '((c 1 =) (b 1 =) (d 2 =) (a 2 =))))
              (make-posn 0 1))
(check-expect (find-blank (make-puzzle 2 '((a b) (c d))  ;; Test 004
                                       '((d 2 =) (c 1 =) (b 1 =) (a 2 =))))
              (make-posn 1 1))
(check-expect (find-blank (make-puzzle 2 '((a a) (a a)) '((a 6 +)))) (make-posn 0 0))  ;; Test 005
(check-expect (find-blank (make-puzzle 2 '((b a) (a a)) '((a 5 +) (b 1 =)))) (make-posn 1 0))  ;; Test 006
(check-expect (find-blank (make-puzzle 2 '((b b) (a a)) '((a 2 *) (b 3 +)))) (make-posn 0 1))  ;; Test 007
(check-expect (find-blank (make-puzzle 3 '((b c a) (a a a) (d a e))  ;; Test 008
                                       '((a 18 *) (b 1 =) (c 2 =) (d 3 =) (e 1 =))))
              (make-posn 2 0))
(check-expect (find-blank (make-puzzle 3 '((b b c) (b a a) (a a d))  ;; Test 009
                                       '((a 9 *) (b 5 +) (c 3 =) (d 2 =))))
              (make-posn 1 1))
(check-expect (find-blank (make-puzzle 3 (list (list 1 2 'd)  ;; Test 010
                                               (list (make-guess 'b 2) 3'b)
                                               (list 'b 'b 'b))
                                       '((b 12 *) (d 3 =))))
              (make-posn 2 1))
(check-expect (find-blank (make-puzzle 4 '((a a c c) (2 a d a) (3 a a a) (1 4 b b))  ;; Test 011
                                       '((d 1 =) (b 1 -) (a 20 +) (c 3 /))))
              (make-posn 2 1))
(check-expect (find-blank (make-puzzle 4 (list (list (make-guess 'a 4) (make-guess 'a 2) 'c 'c)  ;; Test 012
                                               (list 'z (make-guess 'a 3) 'd (make-guess 'a 4))
                                               (list 'z (make-guess 'a 1) 'a 'a)
                                               (list 'z 'z 'b 'b))
                                       '((a 20 +) (c 3 /) (d 1 =) (b 1 -) (z 24 *))))
              (make-posn 2 2))
(check-expect (find-blank (make-puzzle 4 (list (list (make-guess 'a 4) (make-guess 'a 2) 'c 'c)  ;; Test 013
                                               (list 2 (make-guess 'a 3) 'd (make-guess 'a 4))
                                               (list 3 'a 'a 'a)
                                               (list 1 4 'b 'b))
                                       '((a 20 +) (c 3 /) (d 1 =) (b 1 -))))
              (make-posn 1 2))
(check-expect (find-blank (make-puzzle 1 '((1)) empty)) false)  ;; Test 014
(check-expect (find-blank (make-puzzle 3 '((1 2 3) (2 3 1) (3 1 2)) empty)) false)  ;; Test 015
(check-expect (find-blank (make-puzzle 4 '((4 2 3 1) (2 3 1 4) (3 1 4 2) (1 4 2 3)) empty)) false)  ;; Test 016
(check-expect (find-blank (make-puzzle 3 (list (list 1 2 'd)  ;; Test 017
                                               (list (make-guess 'b 2) 3 (make-guess 'b 1))
                                               (list (make-guess 'b 3) (make-guess 'b 1) (make-guess 'b 2)))
                                       '((b 12 *) (d 3 =))))
              'guess)
(check-expect (find-blank (make-puzzle 4 (list (list (make-guess 'a 4) (make-guess 'a 2) 'c 'c)  ;; Test 018
                                               (list 2 (make-guess 'a 3) 'd (make-guess 'a 4))
                                               (list 3 (make-guess 'a 1) (make-guess 'a 4) (make-guess 'a 2))
                                               (list 1 4 'b 'b))
                                       '((a 20 +) (c 3 /) (d 1 =) (b 1 -))))
              'guess)

(check-expect (find-blank puzzle1partial2) (make-posn 0 1))

;;==============================================================================
;;1(b)
;; Part (b)

;; (used-in-row puz pos) produces a list of numbers used in the same 
;; row as (x,y) position, pos, in the given puz.  
;; used-in-row: Puzzle Posn -> (listof Nat)
;; Examples:
(check-expect (used-in-row puzzle1 (make-posn 1 1)) empty)
(check-expect (used-in-row puzzle1partial (make-posn 2 2)) (list 3))
(check-expect (used-in-row puzzle1partial2 (make-posn 0 1)) (list 1 2 4))


(define (used-in-row puz pos)
  (quicksort (filter (lambda (x)
                       (cond
                         [(empty? x) false]
                         [else true]))
                     (map (lambda (item)
                            (cond
                              [(number? item) item]
                              [(guess? item) (guess-number item)]
                              [else empty]))
                          (list-ref (puzzle-board puz) (posn-y pos)))) <))

;; Tests:
(check-expect (used-in-row puzzle1partial (make-posn 2 2)) (list 3))
(check-expect (used-in-row puzzle1partial2 (make-posn 0 1)) (list 1 2 4))
(check-expect (used-in-row (make-puzzle 1 '((a)) '((a 1 =))) (make-posn 0 0)) empty)  ;; Test 001
(check-expect (used-in-row (make-puzzle 3 '((b b c) (b a a) (a a d))  ;; Test 002
                                        '((a 8 +) (b 4 *) (c 3 =) (d 2 =)))
                           (make-posn 1 1))
              empty)
(check-expect (used-in-row (make-puzzle 3 (list (list (make-guess 'a 1) (make-guess 'a 2) 'a)  ;; Test 003
                                                (list 2 3 1)
                                                (list 3 1 2))
                                        '((a 6 +)))
                           (make-posn 2 0))
              '(1 2))
(check-expect (used-in-row (make-puzzle 3 (list (list 'a 'a 3)  ;; Test 004
                                                (list 2 3 (make-guess 'b 1))
                                                (list (make-guess 'b 3) (make-guess 'b 1) 'b))
                                        '((b 6 *) (a 2 /)))
                           (make-posn 2 2))
              '(1 3))
(check-expect (used-in-row (make-puzzle 3 '((1 2 d) (b 3 b) (b b b))  ;; Test 005
                                        '((d 3 =) (b 12 *)))
                           (make-posn 2 0))
              '(1 2))
(check-expect (used-in-row (make-puzzle 3 '((1 2 d) (b 3 b) (b b b))  ;; Test 006
                                        '((b 12 *) (d 3 =)))
                           (make-posn 0 1))
              '(3))
(check-expect (used-in-row (make-puzzle 4 (list (list (make-guess 'a 4) (make-guess 'a 2) 'c 'c)  ;; Test 007
                                                (list 2 (make-guess 'a 3) 'd (make-guess 'a 4))
                                                (list 3 (make-guess 'a 1) 'a 'a)
                                                (list 1 4 'b 'b))
                                        '((a 20 +) (c 3 /) (d 1 =) (b 1 -)))
                           (make-posn 2 2))
              '(1 3))
(check-expect (used-in-row (make-puzzle 4 (list (list 4 'b 'b 1)  ;; Test 008
                                                (list (make-guess 'a 2) 'a 1 4)
                                                (list 'a 'a 'a 'a)
                                                (list 1 4 2 3))
                                        '((a 144 *) (b 5 +)))
                           (make-posn 1 1))
              '(1 2 4))


;; (used-in-column puz pos) produces a list of numbers used in the same
;; column as (x,y) position, pos, in the given puz.  
;; used-in-column: Puzzle Posn -> (listof Nat)
;; Examples:
(check-expect (used-in-column puzzle1 (make-posn 1 1)) empty)
(check-expect (used-in-column puzzle1partial (make-posn 2 2)) (list 1))
(check-expect (used-in-column puzzle1partial2 (make-posn 0 1)) (list 2))

(define (used-in-column puz pos)
   (quicksort (filter (lambda (item)
                        (cond
                          [(empty? item) false]
                          [else true]))
                      (map (lambda (x)
                             (cond
                               [(number? x) x]
                               [(guess? x) (guess-number x)]
                               [else empty]))
                           (map (lambda (y)
                                  (list-ref y (posn-x pos)))
                                (puzzle-board puz)))) <))

;; Tests:
(check-expect (used-in-column (make-puzzle 1 '((a)) '((a 1 =))) (make-posn 0 0)) empty)  ;; Test 001
(check-expect (used-in-column (make-puzzle 3 '((b b c) (b a a) (a a d))  ;; Test 002
                                           '((a 8 +) (b 4 *) (c 3 =) (d 2 =)))
                              (make-posn 1 1))
              empty)
(check-expect (used-in-column (make-puzzle 3 (list (list (make-guess 'a 1) (make-guess 'a 2) (make-guess 'a 3))  ;; Test 003
                                                   (list (make-guess 'a 2) (make-guess 'a 3) (make-guess 'a 1))
                                                   (list 3 'a 2))
                                           '((a 36 *)))
                              (make-posn 1 2))
              '(2 3))
(check-expect (used-in-column (make-puzzle 3 (list (list 1 2 (make-guess 'a 3))  ;; Test 004
                                                   (list (make-guess 'a 2) (make-guess 'a 3) 'a)
                                                   (list 3 1 'b))
                                           '((a 9 +) (b 2 =)))
                              (make-posn 2 1))
              '(3))
(check-expect (used-in-column (make-puzzle 3 (list (list (make-guess 'a 1) (make-guess 'a 2) 'a)  ;; Test 005
                                                   (list 2 3 1)
                                                   (list 3 1 2))
                                           '((a 6 +)))
                              (make-posn 2 0))
              '(1 2))
(check-expect (used-in-column (make-puzzle 3 '((1 d d) (a 3 b) (a 1 b))  ;; Test 006
                                           '((d 5 +) (a 5 +) (b 2 /)))
                              (make-posn 1 0))
              '(1 3))
(check-expect (used-in-column (make-puzzle 4 (list (list (make-guess 'a 4) (make-guess 'a 2) 'c 'c)  ;; Test 007
                                                   (list (make-guess 'a 2) 3 1 'c)
                                                   (list (make-guess 'a 3) 'a 4 'd)
                                                   (list 'b 4 2 'd))
                                           '((a 48 *) (b 1 =) (d 5 +) (c 12 *)))
                              (make-posn 1 2))
              '(2 3 4))
(check-expect (used-in-column (make-puzzle 4 (list (list 4 'a 3 1)  ;; Test 008
                                                   (list 2 3 (make-guess 'b 1) (make-guess 'b 4))
                                                   (list 3 1 (make-guess 'b 4) 'b)
                                                   (list 1 4 2 3))
                                           '((b 11 +) (a 2 =)))
                              (make-posn 3 2))
              '(1 3 4))

;;==============================================================================
;; Part (c)

;;This function may be useful as a helper for available-vals

;; (allvals n) produces a list of values from 1 to n
;; allvals: Nat -> (listof Nat)
;; Examples:
(check-expect (allvals 0) empty)
(check-expect (allvals 1) (list 1))

(define (allvals n)
  (build-list n (lambda (x) (add1 x))))

;; Tests:
(check-expect (allvals 3) (list 1 2 3))

;; (available-vals puz pos) produces a list of valid entries for the (x,y)  
;; position, pos, of the consumed puzzle, puz.  
;; available-vals: Puzzle Posn -> (listof Nat)
;; Examples:
(check-expect (available-vals puzzle1 (make-posn 2 3)) '(1 2 3 4))
(check-expect (available-vals puzzle1partial (make-posn 2 2)) '(2 4))
(check-expect (available-vals puzzle1partial2 (make-posn 0 1)) '(3))



(define (available-vals puz pos)
  (filter (lambda (x) (not (member? x (append (used-in-column puz pos)
                                              (used-in-row puz pos)))))
          (build-list (puzzle-size puz) add1)))

;; Tests:
(check-expect (available-vals puzzle1partial (make-posn 2 2)) '(2 4))
(check-expect (available-vals puzzle1partial2 (make-posn 0 1)) '(3))
(check-expect (available-vals (make-puzzle 1 '((a)) '((a 1 =))) (make-posn 0 0)) '(1))  ;; Test 001
(check-expect (available-vals (make-puzzle 3 '((b b c) (b a a) (a a d))  ;; Test 002
                                           '((a 9 *) (b 4 *) (c 3 =) (d 2 =)))
                              (make-posn 1 1))
              '(1 2 3))
(check-expect (available-vals (make-puzzle 4 (list (list 4 2 'b 'b)  ;; Test 003
                                                   (list 2 3 'b 4)
                                                   (list 3 (make-guess 'a 1) 'a 'a)
                                                   (list 'a 'a 'a 3))
                                           '((a 64 *) (b 5 +)))
                              (make-posn 2 2))
              '(2 4))
(check-expect (available-vals (make-puzzle 4 (list (list (make-guess 'a 4) (make-guess 'a 2) 'c 'c)  ;; Test 004
                                                   (list 'b 'a 'c 'c)
                                                   (list 'b 'b 4 'd)
                                                   (list 'b 4 2 'd))
                                           '((a 9 +) (b 6 *) (c 12 *) (d 5 +)))
                              (make-posn 1 1))
              '(1 3))
(check-expect (available-vals (make-puzzle 4 (list (list 'b 'b (make-guess 'a 3) 1)  ;; Test 005
                                                   (list (make-guess 'a 2) 'b 'a 4)
                                                   (list 'a 'b 'a 2)
                                                   (list 'a 'a 'a 3))
                                           '((a 576 *) (b 24 *)))
                              (make-posn 2 1))
              '(1))
(check-expect (available-vals (make-puzzle 4 (list (list 'b 'b (make-guess 'a 3) (make-guess 'a 1))  ;; Test 006
                                                   (list 'b 3 'a 'a)
                                                   (list 3 1 'a 2)
                                                   (list 1 4 'a 3))
                                           '((a 15 +) (b 8 +)))
                              (make-posn 2 1))
              '(1 2 4))

;;==============================================================================
;;==============================================================================
;; Part (d)

;; (place-guess brd pos val) fills in the (x,y) position, pos, of the board, brd, 
;; with the a guess with value, val
;; place-guess: (listof (listof (anyof Sym Nat Guess))) Posn Nat 
;;              -> (listof (listof (anyof Sym Nat Guess)))
;; Examples:
(check-expect (place-guess (puzzle-board puzzle1) (make-posn 3 2) 5)
              (list
               (list 'a 'b 'b 'c)
               (list 'a 'd 'e 'e)
               (list 'f 'd 'g (make-guess 'g 5))
               (list 'f 'h 'i 'i)))


;;(replace a alist val) find the place of the posn-point.
;;replace: Num List Num -> List
(define (replace a alist val)
  (cond
    [(= a 0) (cons (make-guess (first alist) val) (rest alist))]
    [else (cons (first alist) (replace (sub1 a) (rest alist) val))]))


(define (place-guess brd pos val)
  (cond
    [(empty? brd) empty]
    [(= 0 (posn-y pos))
     (cons (replace (posn-x pos) (first brd) val) (place-guess (rest brd) (make-posn -1 -1) val))] 
    [(> (posn-y pos) 0) (cons (first brd)
                              (place-guess (rest brd)
                                           (make-posn (posn-x pos) (sub1 (posn-y pos)))
                                           val))]
    [else brd]))


;;Tests:
(check-expect (place-guess '((a)) (make-posn 0 0) 1)  ;; Test 001
              (list (list (make-guess 'a 1))))
(check-expect (place-guess (list (list (make-guess 'a 4) (make-guess 'a 2) 'a 1)  ;; Test 002
                                 (list 2 3 'a 4)
                                 (list 3 1 4 2)
                                 (list 1 4 2 3))
                           (make-posn 2 0)
                           3)
              (list (list (make-guess 'a 4) (make-guess 'a 2) (make-guess 'a 3) 1)
                    (list 2 3 'a 4)
                    (list 3 1 4 2)
                    (list 1 4 2 3)))
(check-expect (place-guess '((4 2 3 1)  ;; Test 003
                             (a 3 1 4)
                             (a 1 4 2)
                             (a a a a))
                           (make-posn 0 1) 2)
              (list (list 4 2 3 1)
                    (list (make-guess 'a 2) 3 1 4)
                    (list 'a 1 4 2)
                    (list 'a 'a 'a 'a)))
(check-expect (place-guess (list (list 4 2 (make-guess 'a 3) (make-guess 'a 1))  ;; Test 004
                                 (list 2 3 'a 'd)
                                 (list 'b 'b 'a 'a)
                                 (list 'b 'b 'c 'c))
                           (make-posn 2 1) 1)
              (list (list 4 2 (make-guess 'a 3) (make-guess 'a 1))
                    (list 2 3 (make-guess 'a 1) 'd)
                    (list 'b 'b 'a 'a)
                    (list 'b 'b 'c 'c)))

;; (fill-in-guess puz pos val) fills in the (x,y) position, pos, of puz's board
;; with a guess wtih value, val
;; fill-in-guess: Puzzle Posn Nat -> Puzzle
;; Examples:
(check-expect (fill-in-guess puzzle1 (make-posn 3 2) 5)
              (make-puzzle
               4
               (list
                (list 'a 'b 'b 'c)
                (list 'a 'd 'e 'e)
                (list 'f 'd 'g (make-guess 'g 5))
                (list 'f 'h 'i 'i))
               (puzzle-constraints puzzle1)))

(define (fill-in-guess puz pos val)
  (make-puzzle (puzzle-size puz) 
               (place-guess (puzzle-board puz) pos val) 
               (puzzle-constraints puz)))

;; Tests:
(check-expect (fill-in-guess puzzle3 (make-posn 0 0) 1)
              (make-puzzle
               2
               (list (list (make-guess 'a 1) 'b)
                     (list 'c 'b))
               '((b 3 +) 
                 (c 2 =)
                 (a 1 =))))
;;==============================================================================
;; Part (e)

;; (guess-valid? puz) determines if the guesses in puz satisfy their constraint
;; guess-valid?: Puzzle -> Bool
;; Examples:
(check-expect (guess-valid? puzzle3partial) true)
(check-expect (guess-valid? (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) (make-guess 'b 1) 'b 'c)
    (list (make-guess 'a 3) 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 1.5 '/)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-)))) true)

;;Helper Function:
;;(calculate alist puz) produce the guess satisfy their constraint
(define (calculate alist puz)
  (cond
    [(symbol=? '+ (third (first (puzzle-constraints puz))))
     (= (second (first (puzzle-constraints puz)))
        (foldr + 0 (map (lambda (x) (guess-number x)) alist)))]
    [(symbol=? '* (third (first (puzzle-constraints puz))))
     (= (second (first (puzzle-constraints puz)))
        (foldr * 1 (map (lambda (x) (guess-number x)) alist)))]
    [(symbol=? '- (third (first (puzzle-constraints puz))))
     (or (= (second (first (puzzle-constraints puz)))
            (foldr - 0 (map (lambda (x) (guess-number x)) alist)))
         (= (second (first (puzzle-constraints puz)))
            (foldl - 0 (map (lambda (x) (guess-number x)) alist))))]
    [(symbol=? '/ (third (first (puzzle-constraints puz))))
     (or (= (second (first (puzzle-constraints puz)))
            (foldr / 1 (map (lambda (x) (guess-number x)) alist)))
         (= (second (first (puzzle-constraints puz)))
            (foldl / 1 (map (lambda (x) (guess-number x)) alist))))]
    [(symbol=? '= (third (first (puzzle-constraints puz))))
     (= (guess-number (first alist)) (second (first (puzzle-constraints puz))))]))

;;Main Function:
(define (guess-valid? puz)
  (calculate (filter (lambda (x) (symbol=? (guess-symbol x)
                                 (first (first (puzzle-constraints puz)))))
                     (filter guess? (foldr append empty (puzzle-board puz))))
             puz))

    

;; Tests:
(check-expect (guess-valid? puzzle3partial) true)
(check-expect (guess-valid? (make-puzzle 
   4
   (list
    (list (make-guess 'a 2) (make-guess 'b 1) 'b 'c)
    (list (make-guess 'a 3) 2 1 4)
    (list 'f 3 'g 'g)
    (list 'f 'h 'i 'i))
   (list
    (list 'a 1.5 '/)
    (list 'b 3 '-)
    (list 'c 3 '=)
    (list 'f 3 '-)
    (list 'g 2 '/)
    (list 'h 4 '=)
    (list 'i 1 '-)))) true)
(check-expect (guess-valid? (make-puzzle 1 (list (list (make-guess 'a 1))) '((a 1 =)))) true)  ;; Test 001
(check-expect (guess-valid? (make-puzzle 3 (list (list 'b 'b 3)  ;; Test 002
                                                 (list 'b 'a 'a)
                                                 (list 'a 'a (make-guess 'd 2)))
                                         '((d 2 =) (b 4 *) (a 9 *))))
              true)
(check-expect (guess-valid? (make-puzzle 3 (list (list 'b 'b 3)  ;; Test 003
                                                 (list 'b 'a 'a)
                                                 (list 'a 'a (make-guess 'd 1)))
                                         '((d 2 =) (b 4 *) (a 9 *))))
              false)
(check-expect (guess-valid? (make-puzzle 4 (list (list 'b (make-guess 'a 2) (make-guess 'a 3) 1)  ;; Test 004
                                                 (list 'b 'b (make-guess 'a 1) 4)
                                                 (list (make-guess 'a 3) (make-guess 'a 1) (make-guess 'a 4) (make-guess 'a 2))
                                                 (list 'c 'c 2 (make-guess 'a 3)))
                                         '((a 19 +) (c 4 *) (b 2 /))))
              true)
(check-expect (guess-valid? (make-puzzle 4 (list (list 'b 4 'b 'b)  ;; Test 005
                                                 (list 'b 'b 'b 'b)
                                                 (list (make-guess 'a 1) (make-guess 'a 3) (make-guess 'a 4) 2)
                                                 (list 'c (make-guess 'a 1) 'd 'd))
                                         '((a 12 +) (b 288 *) (c 1 =) (d 5 +))))
              false)
(check-expect (guess-valid? (make-puzzle 4 (list (list 4 2 'a 'a)  ;; Test 006
                                                 (list 'b (make-guess 'c 3) 'a 4)
                                                 (list 'b (make-guess 'c 1) (make-guess 'c 4) 2)
                                                 (list 1 (make-guess 'c 4) (make-guess 'c 2) 3))
                                         '((c 96 *) (b 5 +) (a 3 *))))
              true)
(check-expect (guess-valid? (make-puzzle 4 (list (list 4 2 'a 'a)  ;; Test 007
                                                 (list 'b (make-guess 'c 3) 'a 4)
                                                 (list 'b (make-guess 'c 1) (make-guess 'c 3) 2)
                                                 (list 1 (make-guess 'c 4) (make-guess 'c 2) 3))
                                         '((c 96 *) (b 5 +) (a 3 *))))
              false)
(check-expect (guess-valid? (make-puzzle 3 (list (list 'a 'a 'a)  ;; Test 008
                                                 (list 'a (make-guess 'b 3) (make-guess 'b 1))
                                                 (list 3 1 2))
                                         '((b 2 -) (a 8 +))))
              true)
(check-expect (guess-valid? (make-puzzle 3 (list (list 'a 'a 'a)  ;; Test 009
                                                 (list 'a (make-guess 'b 1) (make-guess 'b 3))
                                                 (list 3 2 1))
                                         '((b 2 -) (a 8 +))))
              true)
(check-expect (guess-valid? (make-puzzle 3 (list (list 'a 'a 'a)  ;; Test 010
                                                 (list 'a (make-guess 'b 2) (make-guess 'b 3))
                                                 (list 3 1 2))
                                         '((b 2 -) (a 8 +))))
              false)
(check-expect (guess-valid? (make-puzzle 3 (list (list 'a 'a 3)  ;; Test 011
                                                 (list 'a (make-guess 'b 3) 1)
                                                 (list 'a (make-guess 'b 1) 2))
                                         '((b 3 /) (a 8 +))))
              true)
(check-expect (guess-valid? (make-puzzle 3 (list (list 'a 'a 3)  ;; Test 012
                                                 (list 'a (make-guess 'b 1) 2)
                                                 (list 'a (make-guess 'b 3) 1))
                                         '((b 3 /) (a 8 +))))
              true)
(check-expect (guess-valid? (make-puzzle 3 (list (list 'a 'a 3)  ;; Test 013
                                                 (list 'a (make-guess 'b 3) 2)
                                                 (list 'a (make-guess 'b 2) 1))
                                         '((b 3 /) (a 8 +))))
              false)
;;==============================================================================
;; Part (f)

;; (apply-guess puz) converts all guesses in puz into their corresponding numbers
;; and removes the first contraint from puz's list of contraints
;; apply-guess:  Puzzle -> Puzzle
;; Examples:
(check-expect (apply-guess (make-puzzle 1 (list (list (make-guess 'a 1))) '((a 1 =))))  ;; Test 001
              (make-puzzle 1 '((1)) empty))
(check-expect (apply-guess (make-puzzle 3 (list (list 'b 'b 3)  ;; Test 002
                                                (list 'b 'a 'a)
                                                (list 'a 'a (make-guess 'd 2)))
                                        '((d 2 =) (b 4 *) (a 3 *))))
              (make-puzzle 3 (list (list 'b 'b 3)
                                   (list 'b 'a 'a)
                                   (list 'a 'a 2))
                           '((b 4 *) (a 3 *))))


(define (apply-guess puz)
  (make-puzzle (puzzle-size puz)
               (map (lambda (x)
                      (map (lambda (item)
                             (cond
                               [(and (guess? item)
                                     (symbol=? (guess-symbol item)
                                               (first (first (puzzle-constraints puz)))))
                                (guess-number item)]
                               [else item])) x))
                    (puzzle-board puz))
               (rest (puzzle-constraints puz))))
         

;; Tests:
(check-expect (apply-guess puzzle3partial)
              (make-puzzle
               2 
               (list
                (list 'a 1)
                (list 'c 2))
               '((c 2 =)
                 (a 1 =))))
(check-expect (apply-guess (make-puzzle 1 (list (list (make-guess 'a 1))) '((a 1 =))))  ;; Test 001
              (make-puzzle 1 '((1)) empty))
(check-expect (apply-guess (make-puzzle 3 (list (list 'b 'b 3)  ;; Test 002
                                                (list 'b 'a 'a)
                                                (list 'a 'a (make-guess 'd 2)))
                                        '((d 2 =) (b 4 *) (a 3 *))))
              (make-puzzle 3 (list (list 'b 'b 3)
                                   (list 'b 'a 'a)
                                   (list 'a 'a 2))
                           '((b 4 *) (a 3 *))))
(check-expect (apply-guess (make-puzzle 4 (list (list 'b (make-guess 'a 2) (make-guess 'a 3) 1)  ;; Test 003
                                                (list 'b 'b (make-guess 'a 1) 4)
                                                (list (make-guess 'a 3) (make-guess 'a 1) (make-guess 'a 4) (make-guess 'a 2))
                                                (list 'c 'c 2 (make-guess 'a 3)))
                                        '((a 19 +) (c 4 *) (b 2 /))))
              (make-puzzle 4 (list (list 'b 2 3 1)
                                   (list 'b 'b 1 4)
                                   (list 3 1 4 2)
                                   (list 'c 'c 2 3))
                           '((c 4 *) (b 2 /))))
(check-expect (apply-guess (make-puzzle 4 (list (list 4 2 'a 'a)  ;; Test 004
                                                (list 'b (make-guess 'c 3) 'a 4)
                                                (list 'b (make-guess 'c 1) (make-guess 'c 4) 2)
                                                (list 1 (make-guess 'c 4) (make-guess 'c 2) 3))
                                        '((c 96 *) (b 5 +) (a 3 *))))
              (make-puzzle 4 (list (list 4 2 'a 'a)
                                   (list 'b 3 'a 4)
                                   (list 'b 1 4 2)
                                   (list 1 4 2 3))
                           '((b 5 +) (a 3 *))))
(check-expect (apply-guess (make-puzzle 3 (list (list 'a 'a 3)  ;; Test 005
                                                (list 'a (make-guess 'b 1) 2)
                                                (list 'a (make-guess 'b 3) 1))
                                        '((b 3 /) (a 8 +))))
              (make-puzzle 3 (list (list 'a 'a 3)
                                   (list 'a 1 2)
                                   (list 'a 3 1))
                           '((a 8 +))))


;;==============================================================================
;; Part (g)

;; (neighbours puz) produces a list of next puzzles after puz in
;; the implicit graph
;; neighbours: Puzzle -> (listof Puzzle)
;; Examples:
(check-expect (neighbours puzzle3)
              (list 
               (make-puzzle 
                2 
                (list 
                 (list 'a (make-guess 'b 1)) 
                 (list 'c 'b)) 
                '((b 3 +) 
                  (c 2 =)
                  (a 1 =)))
               (make-puzzle 
                2 
                (list 
                 (list 'a (make-guess 'b 2)) 
                 (list 'c 'b)) 
                '((b 3 +) 
                  (c 2 =)
                  (a 1 =)))))

(define (neighbours puz)
  (cond
    [(false? (find-blank puz)) empty]
    [(posn? (find-blank puz))
     (map (lambda (item) (make-puzzle (puzzle-size puz)
                                      item
                                      (puzzle-constraints puz)))
          (map (lambda (x) (place-guess (puzzle-board puz)
                                        (find-blank puz)
                                        x))
               (available-vals puz (find-blank puz))))]
    [(guess-valid? puz)
     (list (apply-guess puz))]
    [else empty]))

;; Tests:
(check-expect (neighbours puzzle2soln) empty)
(check-expect (neighbours puzzle3partial)
              (list 
               (make-puzzle
                2 
                (list
                 (list 'a 1)
                 (list 'c 2))
                '((c 2 =)
                  (a 1 =)))))
(check-expect (neighbours (make-puzzle 1 '((a)) '((a 1 =))))  ;; Test 001
              (list (make-puzzle 1 (list (list (make-guess 'a 1))) '((a 1 =)))))
(check-expect (neighbours (make-puzzle 3 '((a a b) (a c b) (c c c))  ;; Test 002
                                       '((c 18 *) (a 5 +) (b 4 +))))
              (list (make-puzzle 3 (list (list 'a 'a 'b)
                                         (list 'a (make-guess 'c 1) 'b)
                                         (list 'c 'c 'c))
                                 '((c 18 *) (a 5 +) (b 4 +)))
                    (make-puzzle 3 (list (list 'a 'a 'b)
                                         (list 'a (make-guess 'c 2) 'b)
                                         (list 'c 'c 'c))
                                 '((c 18 *) (a 5 +) (b 4 +)))
                    (make-puzzle 3 (list (list 'a 'a 'b)
                                         (list 'a (make-guess 'c 3) 'b)
                                         (list 'c 'c 'c))
                                 '((c 18 *) (a 5 +) (b 4 +)))))
(check-expect (neighbours (make-puzzle 4 (list (list 4 2 3 1)  ;; Test 003
                                               (list 'b (make-guess 'a 3) 'c 4)
                                               (list 'b 'a 'c 'a)
                                               (list 'b 'a 'a 'a))
                                       '((a + 15) (c 4 /) (b 6 *))))
              (list (make-puzzle 4 (list (list 4 2 3 1)
                                         (list 'b (make-guess 'a 3) 'c 4)
                                         (list 'b (make-guess 'a 1) 'c 'a)
                                         (list 'b 'a 'a 'a))
                                 '((a + 15) (c 4 /) (b 6 *)))
                    (make-puzzle 4 (list (list 4 2 3 1)
                                         (list 'b (make-guess 'a 3) 'c 4)
                                         (list 'b (make-guess 'a 4) 'c 'a)
                                         (list 'b 'a 'a 'a))
                                 '((a + 15) (c 4 /) (b 6 *)))))
(check-expect (neighbours (make-puzzle 4 (list (list 'b 4 'b 'b)  ;; Test 004
                                               (list 'b 'b 'b 'b)
                                               (list (make-guess 'a 1) (make-guess 'a 3) (make-guess 'a 4) 2)
                                               (list 'c (make-guess 'a 1) 'd 'd))
                                       '((a 12 +) (b 288 *) (c 1 =) (d 5 +))))
              empty)
(check-expect (neighbours (make-puzzle 4 (list (list 4 2 'a 'a)  ;; Test 005
                                               (list 'b (make-guess 'c 3) 'a 4)
                                               (list 'b (make-guess 'c 1) (make-guess 'c 4) 2)
                                               (list 1 (make-guess 'c 4) (make-guess 'c 2) 3))
                                       '((c 96 *) (b 5 +) (a 3 *))))
              (list (make-puzzle 4 (list (list 4 2 'a 'a)
                                         (list 'b 3 'a 4)
                                         (list 'b 1 4 2)
                                         (list 1 4 2 3))
                                 '((b 5 +) (a 3 *)))))

;; This is just the find-route function from Module 12, slides
;; 31-37.  (Read a bit ahead if you want the deatils.) The explicit
;; graph G has been removed, and the termination condition (the desired
;; destination) is when the puzzle is complete (that is, find-blank
;; returns false).

;; (solve-kenken orig draw-option) finds the solution to a KenKen puzzle,
;; orig, or returns false if there is no solution.  A visual representiation
;; of the solution may be draw depending on the value of draw-option
;; solve-kenken: Puzzle Sym -> (anyof Puzzle false)
;; requires:  draw-option is one of 'off, 'norm, 'slow, 'fast
;; Examples:
(check-expect (solve-kenken puzzle1 'on) puzzle1soln)

(define (solve-kenken orig draw-option)
  (local
    [(define setup (puzzle-setup orig draw-option))
     (define (solve-kenken-helper to-visit visited)
       (cond
         [(empty? to-visit) false]
         [else (local
                 [(define draw (draw-board (first to-visit) draw-option))]
                 (cond
                   [(boolean? (find-blank (first to-visit))) (first to-visit)]
                   [(member (first to-visit) visited)
                    (solve-kenken-helper (rest to-visit) visited)]
                   [else
                    (local [(define nbrs (neighbours (first to-visit)))
                            (define new (filter (lambda (x) (not (member x visited))) nbrs))
                            (define new-to-visit (append new (rest to-visit)))
                            (define new-visited (cons (first to-visit) visited))]
                      (solve-kenken-helper new-to-visit new-visited))]))]))]
    (solve-kenken-helper (list orig) empty)))

;; Tests:
(check-expect (solve-kenken puzzle3partial 'off) false)
;; The time special form shows you the number of milliseconds spent
;; evaluating the given expression.  The first number (cpu time) is
;; the important one.
(check-expect (time (solve-kenken puzzle2 'off)) puzzle2soln)