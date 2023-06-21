(ns etl)

(defn transform
  [m]
  (into {}
        (for [[score letters] m
              letter letters]
          [(clojure.string/lower-case letter) score])))
