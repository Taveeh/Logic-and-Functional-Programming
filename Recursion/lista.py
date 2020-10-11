class Nod:
    def __init__(self, e):
        self.e = e
        self.urm = None
    
class Lista:
    def __init__(self):
        self.prim = None
    

'''
crearea unei liste din valori citite pana la 0
'''
def creareLista():
    lista = Lista()
    lista.prim = creareLista_rec()
    return lista

def creareLista_rec():
    x = int(input("x="))
    if x == 0:
        return None
    else:
        nod = Nod(x)
        nod.urm = creareLista_rec()
        return nod
    
'''
tiparirea elementelor unei liste
'''
def tipar(lista):
    tipar_rec(lista.prim)
    
def tipar_rec(nod):
    if nod != None:
        print (nod.e)
        tipar_rec(nod.urm)
        
def partA(nod):
    '''
    partA(l1l2...ln) = {
        0, if n = 0
        partA(l2...ln) + l1, l1 % 2 = 0
        partA(l2...ln) - l1, otherwise
    }
    '''
    if nod == None:
        return 0
    if nod.e % 2 == 0:
        return partA(nod.urm) + nod.e
    else:
        return partA(nod.urm) - nod.e

def add(lista, val):
    lista.prim = addRec(lista.prim, val)
    return lista

def addRec(nod, val):
    '''
    addRec(l1l2...ln, val) = {
        (val), if n = 0
        l1 + addRec(l2...ln, val), otherwise
    }
    '''
    if nod == None:
        return Nod(val)
    nod.urm = addRec(nod.urm, val)
    return nod

def findIn(nod, val):
    if nod == None:
        return False
    if nod.e == val:
        return True
    return findIn(nod.urm, val)

def difference(nod1, nod2, lis):
    '''
    difference(l1l2...ln, q1q2...qm, a1a2...ap) = {
        a1a2...an, if n = 0
        difference(l2...ln, q1q2...qm, a1a2...ap U l1), if l1 is not in q1q2...qn
        difference(l2...ln, q1q2...qm, a1a2...ap), otherwise
    }
    '''
    if nod1 == None:
        return lis
    if not findIn(nod2, nod1.e):    
        lis = add(lis, nod1.e)
    lis = difference(nod1.urm, nod2, lis)
    return lis

def partB(list1, list2):
    li = Lista()
    li = difference(list1.prim, list2.prim, li)
    return li
    
    
    

        

'''
program pentru test
'''
        
def main():
    lista = creareLista()
    print(" --- PART A ---")
    print(partA(lista.prim))
    print(" --- PART B ---")
    lista2 = creareLista()
    b = partB(lista, lista2)
    tipar(b)
    # print(" ---  LIST  ---")
    # tipar(lista)
    
main() 
    
    
    
    
    
