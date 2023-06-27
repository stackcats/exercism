(ns prime-factors)

(defn of
  [n]
  (loop [n n curr 2 acc []]
    (cond
      (< n curr) acc
      (zero? (rem n curr)) (recur (quot n curr) curr (conj acc curr))
      :else (recur n (inc curr) acc))))
