(ns elyses-destructured-enchantments)

(defn first-card [deck] (let [[x & xs] deck] x))

(defn second-card [deck] (let [[_ b & rest] deck] b))

(defn swap-top-two-cards [deck] (let [[a b & rest] deck] (vec (conj rest a b))))

(defn discard-top-card [deck] (let [[x & xs] deck] [x xs]))

(def face-cards ["jack" "queen" "king"])

(defn insert-face-cards
  [deck]
  (let [[x & xs] deck]
    (->> (concat (cons x face-cards) xs)
         (remove nil?)
         (vec))))

