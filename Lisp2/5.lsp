;; formatWrite(node, val) = print(Node {node} is at level {val})

(defun formatWrite (node val)
(cond 
    ((null val) (print `(Node ,node is not in the tree)))
    (t (print `(Node ,node is at level ,val)))
))

;; getLevelAux(elementToSearch, currentNode, currentLevel, numberOfChildren, l1...ln) = {
;;      l1...ln, numberOfChildren = 0 OR n = 1,
;;      [], n = 0,
;;      [currentLevel], elementToSearch = currentNode
;;      getLevelAux(elementToSearch, currentNode, currentLevel, numberOfChildren - 1, getLevelAux(elementToSearch, l1, currentLevel + 1, l2, l3...ln)), otherwise
;; }

(defun getLevelAux (elementToSearch currentNode currentLevel numberOfChildren remainingList)
;; (print remainingList)
(cond 
    ((eq elementToSearch currentNode) ;; found the elmement
        (list currentLevel))
    ((null (cdr remainingList)) ;; there is only the level left in the remainingList
        remainingList) 
    ((eq numberOfChildren 0) ;; No more children to search
        remainingList) 
    ((null remainingList) ;; no element found + nowhere to search
        nil) 
    (t (getLevelAux 
            elementToSearch 
            currentNode 
            currentLevel 
            (- numberOfChildren 1) 
            (getLevelAux 
                elementToSearch 
                (car remainingList) 
                (+ currentLevel 1) 
                (cadr remainingList) 
                (cddr remainingList))))))

;; solve(elementToSearch, l1...ln) = formatWrite(elementToSearch, L1), if L = getLevelAux(elementToSearch, l1, 0, l2, l3...ln)
(defun solve (elementToSearch fullList)
(formatWrite 
    elementToSearch 
        (car 
            (getLevelAux 
                elementToSearch 
                (car fullList) 
                0 
                (cadr fullList) 
                (cddr fullList)))))

(solve 'C (list 'A 2 'B 0 'C 2 'D 0 'E 0))

(solve 'F (list 'A 2 'B 0 'C 2 'D 1 'F 0 'E 0))

(solve 'F (list 'A 2 'B 0 'C 2 'D 1 'E 0 'F 0))

(solve 'F (list 'A 2 'B 0 'C 2 'D 0 'E 0))

(solve 'C (list 'A 2 'B 2 'D 0 'E 1 'H 0 'C 2 'F 1 'I 0 'G 0))