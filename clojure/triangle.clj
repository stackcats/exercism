(ns triangle)

(defn- different-sides [& xs] (count (set xs)))

(defn is-valid? [a b c] (and (> (+ a b) c) (> (+ a c) b) (> (+ b c) a)))

(defn equilateral? [a b c] (and (is-valid? a b c) (= a b c)))

(defn isosceles? [a b c] (and (is-valid? a b c) (>= 2 (different-sides a b c))))

(defn scalene? [a b c] (and (is-valid? a b c) (= 3 (different-sides a b c))))
