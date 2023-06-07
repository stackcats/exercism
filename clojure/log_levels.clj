(ns log-levels
  (:require [clojure.string :as str]))

(defn message
  [s]
  (str/trim (str/replace-first s #"\[(ERROR|INFO|WARNING)\]:" "")))

(defn log-level
  [s]
  (cond (str/starts-with? s "[ERROR]") "error"
        (str/starts-with? s "[INFO]") "info"
        (str/starts-with? s "[WARNING]") "warning"))

(defn reformat [s] (format "%s (%s)" (message s) (log-level s)))
