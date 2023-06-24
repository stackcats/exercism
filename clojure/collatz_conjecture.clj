(ns collatz-conjecture)

(defn collatz
  ([num] (collatz num 0))
  ([num acc]
   (cond
     (= num 1) acc
     (even? num) (collatz (/ num 2) (inc acc))
     :else (collatz (inc (* 3 num)) (inc acc)))))
