(ns complex-numbers
  (:require [clojure.math :as math]))

(defn- sq-sum [[a b]] (+ (* a a) (* b b)))

(defn real [[a b]] a)

(defn imaginary [[a b]] b)

(def abs (comp math/sqrt sq-sum))

(defn conjugate [[a b]] [a (* -1 b)])

(defn add [[a b] [c d]] [(+ a c) (+ b d)])

(defn sub [[a b] [c d]] [(- a c) (- b d)])

(defn mul [[a b] [c d]] [(- (* a c) (* b d)) (+ (* b c) (* a d))])

(defn div
  [[a b] [c d]]
  (let [t (sq-sum [c d])]
    (if (zero? t)
      [(/ a c 1.0) 0.0]
      [(/ (+ (* a c) (* b d)) t 1.0) (/ (- (* b c) (* a d)) t 1.0)])))
