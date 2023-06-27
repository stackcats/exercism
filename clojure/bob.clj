(ns bob
  (:require [clojure.string :as str]))

(defn response-for [s]
  (let [trimmed (str/trim s)
        has-letter (re-find #"\p{Alpha}" trimmed)
        question? (= (last trimmed) \?)
        yelling? (and has-letter (= trimmed (str/upper-case trimmed)))]
    (cond
      (empty? trimmed) "Fine. Be that way!"
      (and question? yelling?) "Calm down, I know what I'm doing!"
      question? "Sure."
      yelling? "Whoa, chill out!"
      :else "Whatever.")))

