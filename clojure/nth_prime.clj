(ns nth-prime
  (:require [clojure.math :as math]))

(defn- prime?
  [n]
  (cond
    (< n 2) false
    (= n 2) true
    :else
    (let [sq (->> n (math/sqrt) (math/round) (inc) (range 2))]
      (every? #(> (rem n %) 0) sq))))

(defn nth-prime
  [n]
  (if (< n 1)
    (throw (IllegalArgumentException. "there is no zeroth prime"))
    (loop [n n p 2]
      (if (prime? p)
        (if (= n 1)
          p
          (recur (dec n) (inc p)))
        (recur n (inc p))))))
