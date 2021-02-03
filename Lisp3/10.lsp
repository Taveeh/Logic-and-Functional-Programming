;;  Define a function that replaces one node with another one in a n-tree represented as: root list_of_nodes_subtree1... list_of_nodes_subtreen)
;; Eg: tree is (a (b (c)) (d) (e (f))) and node 'b' will be replace with node 'g' => tree (a (g (c)) (d) (e (f)))}

(defun changeNode(l elem new)
(COND
    ((ATOM l) (cond
        ((equal l elem) new)
        (t l)
    ))
    (t (MAPCAR #'(lambda (a) (changeNode a elem new)) l))
))

(print (changeNode '(a (b (c)) (d) (b (f))) 'b 'g))
(print (changeNode '(a (b (c)) (d) (e (f))) 'h 'g))
(print (changeNode '(a (b (c)) (d) (e (f))) 'e '[]))
(print (changeNode '(a (b (c)) ([]) (e (f))) '[] 'd))