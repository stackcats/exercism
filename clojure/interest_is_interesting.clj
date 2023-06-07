(ns interest-is-interesting)

(defn interest-rate
  [balance]
  (cond (< balance 0) -3.213
        (< balance 1000) 0.5
        (< balance 5000) 1.621
        :else 2.475))

(defn annual-balance-update
  [balance]
  (->> balance
       (interest-rate)
       (bigdec)
       (* 0.01M)
       (abs)
       (+ 1M)
       (* balance)))

(defn amount-to-donate
  [balance tax-free-percentage]
  (if (<= balance 0) 0 (int (* 2 balance (/ tax-free-percentage 100)))))
