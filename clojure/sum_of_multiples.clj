(ns sum-of-multiples)

(defn- aux
  [curr n limit st]
  (if (>= curr limit) st (aux (+ curr n) n limit (conj st curr))))

(defn sum-of-multiples
  [lst limit]
  (apply + (reduce #(aux %2 %2 limit %1) #{} lst)))


