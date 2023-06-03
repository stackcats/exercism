(ns sublist)

(defn contain
  [list1 list2 ct]
  (cond (< (count list2) ct) false
        (= (take ct list2) list1) true
        :else (contain list1 (rest list2) ct)))


(defn classify
  [list1 list2]
  (cond (= list1 list2) :equal
        (empty? list1) :sublist
        (empty? list2) :superlist
        (contain list1 list2 (count list1)) :sublist
        (contain list2 list1 (count list2)) :superlist
        :else :unequal))
