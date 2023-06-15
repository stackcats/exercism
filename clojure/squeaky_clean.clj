(ns squeaky-clean
  (:require [clojure.string :as str]))

(defn- filter-letter
  [s]
  (apply str (filter #(or (Character/isLetter %) (= \_ %)) s)))

(defn clean
  [s]
  (-> s
      (str/replace " " "_")
      (str/replace #"[\u0000-\u001F\u007F-\u009F]" "CTRL")
      (str/replace #"-(\p{L})" #(str/upper-case (%1 1)))
      (filter-letter)
      (str/replace #"[α-ω]" "")))
