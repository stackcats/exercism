(ns flatten-array
  (:refer-clojure :exclude [flatten]))

(defn flatten
  [xs]
  (mapcat #(cond (nil? %1) []
             (vector? %1) (flatten %1)
             :else [%1])
    xs))
