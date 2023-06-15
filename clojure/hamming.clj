(ns hamming)

(defn- aux
  [s1 s2 acc]
  (cond (and (empty? s1) (empty? s2)) acc
        (or (empty? s1) (empty? s2)) nil
        (= (first s1) (first s2)) (aux (rest s1) (rest s2) acc)
        :else (aux (rest s1) (rest s2) (inc acc))))

(defn distance [strand1 strand2] (aux strand1 strand2 0))
