(ns word-count
  (:require [clojure.string :as str]))

(defn- upt
  [m k]
  (update m (str/lower-case k) #(inc (or % 0))))

(defn word-count [s]
  (->>
    (str/split s #"(\p{Punct}|\p{Space})")
    (filter seq)
    (reduce upt {})))
