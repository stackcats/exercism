(ns acronym
  (:require [clojure.string :as str]))

(defn acronym
  "Converts phrase to its acronym."
  [phrase]
  (->> (str/split phrase #"(\p{Punct}|\p{Space}|\p{Lower}(?=\p{Upper}))")
       (map first)
       (apply str)
       (str/upper-case)))
