(ns tracks-on-tracks-on-tracks)

(defn new-list [] '())

(defn add-language [lang-list lang] (cons lang lang-list))

(defn first-language [lang-list] (first lang-list))

(defn remove-language [lang-list] (rest lang-list))

(defn count-languages [lang-list] (count lang-list))

(defn learning-list
  []
  (let [lst (new-list)
        lst (add-language lst "clojure")
        lst (add-language lst "lisp")
        lst (remove-language lst)
        lst (add-language lst "java")
        lst (add-language lst "javaScript")]
    (count-languages lst)))
