;; a) Write a function to eliminate the n-th element of a linear list.
;; removeNth(l1...ln, pos) = {
;;      nil, n = 0
;;      l2...ln, pos = 0
;;      l1 U removeNth(l2...ln, pos - 1), otherwise
;; }

(defun removeNth(l pos)
(cond
    ((null l) nil)
    ((= pos 1) (CDR l))
    (t (CONS (CAR l) (removeNth (CDR l) (- pos 1))))))

(print (removeNth '(1 2 3 4 5 6 7 8) 5))
(print (removeNth '(1 2 3) 4))

;; b) Write a function to determine the successor of a number represented digit by digit as a list, without
;; transforming the representation of the number from list to number. Example: (1 9 3 5 9 9) --> (1 9 3 6 0 0)


;; rev(l1...ln) = revAcc(l1...ln, [])
(defun rev(l) (revAcc l '()))

;; revAcc(l1...ln, a1...am) = {
;;      a1...am, n = 0
;;      revAcc(l2...ln, l1 U a1...am), otherwise
;; }
(defun revAcc(l acc) 
(cond
    ((NULL l) acc)
    (t (revAcc (CDR l) (CONS (CAR l) acc)))))

;; division(n1 n2) = {
;;      1, n1 = 10
;;      0, otherwise

(defun division(n1 n2)
(cond
    ((= n1 10) 1)
    (t 0)
))


;; successor(l1...ln, c) = {
;;      nil, n = 0
;;      (l1 + c) % 10 U successor(l2...ln, (l1 + c) / 10), otherwise
;; }

(defun successor(l c) 
(cond 
    ((null l) 
    (cond 
        ((= c 1) '(1))
        (t nil)))
    (t (CONS  (mod (+ (CAR l) c) 10) (successor (CDR l)  (division (+ (CAR l) c) 10))))
))

;; b(l1...ln) = rev(successor(rev(l), 1))
(defun b(l) (rev (successor (rev l) 1)))

(print (b '(1 9 3 5 9 9)))
(print (b '(9 9)))
(print (b '(1 2 3)))

;; c) Write a function to return the set of all the atoms of a list.
;; Exemplu: (1 (2 (1 3 (2 4) 3) 1) (1 4)) ==> (1 2 3 4)


;; uniqueAtomsAcc(l1...ln, a1...am) = {
;;      a1...am, n = 0
;;      uniqueAtomsAcc(l1, a1...am), isList(l1)
;;      uniqueAtomsAcc(l2...ln, l1 U a1...am), isAtom(l1)
;; }
(defun uniqueAtomsAcc(l acc)
(cond
    ((null l) acc)
    ((listp (car l)) (uniqueAtomsAcc (car l) acc))
    ((atom (car l)) (uniqueAtomsAcc (cdr l) (cons (car l) acc)))
))

;; contains(l1...ln, elem) = {
;;      nil, n = 0
;;      true, l1 = elem
;;      contains(l2...ln, elem), otherwise
;; }

(defun contains(l elem)
(cond
    ((null l) nil)
    ((= (car l) elem) T)
    (T (contains (cdr l) elem))
))

;; makeSet(l1...ln, a1...am) = {
;;      a1...an, n = 0
;;      makeSet(l2...ln, a1...an), contains(acc, l1)
;;      makeSet(l2...ln, l1 U a1...an), otherwise
(defun makeSet(l acc)
(cond
    ((null l) acc)
    ((contains acc (car l)) (makeSet (cdr l) acc) )
    (T (makeSet (cdr l) (CONS (car l) acc)))
))

;; c(l1...ln) = makeSet(uniqueAtomsAcc(l1...ln, []), [])
(defun c(l)
(
    makeSet (uniqueAtomsAcc l '()) '()
))

(print (c '(1 (2 (1 3 (2 4) 3) 1) (1 4))))

;; d) Write a function to test whether a linear list is a set.

;; checkSet(l1...ln) = {
;;      true, n = 0
;;      nil, contains(l2...ln, l1)
;;      checkSet(l2...ln), otherwise
;; }
(defun checkSet(l)
(cond
    ((null l) T)
    ((contains (cdr l) (car l)) nil)
    (T (checkSet (cdr l)))
))

;; d(l1...ln) = {
;;      true, checkSet(l)
;;      false, otherwise
;; }
 
(defun d(l)
(cond 
    ((checkSet l) (print '"Is a set"))
    (T (print '"Is not a set"))
))
(d '(1 2 3 4))
(d '(1 2 3 2))
