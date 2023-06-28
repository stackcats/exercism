(ns anagram
  (:require [clojure.string :as str]))

(defn- aux [a b]
  (let [a (str/upper-case a)
        b (str/upper-case b)]
    (and (not= a b) (= (sort a) (sort b)))))

(defn anagrams-for [word prospect-list]
  (filter (partial aux word) prospect-list))
