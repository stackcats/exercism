(ns cars-assemble)

(defn production-rate
  [speed]
  (cond (= speed 0) 0.0
        (< speed 5) (* 221.0 speed)
        (< speed 9) (* 221.0 speed 0.9)
        (= speed 9) (* 221 speed 0.8)
        :else (* 221 speed 0.77)))

(defn working-items [speed] (clojure.math.floor-div (production-rate speed) 60))
