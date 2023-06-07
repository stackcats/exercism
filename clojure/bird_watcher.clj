(ns bird-watcher)

(def last-week [0 2 5 3 7 8 4])

(defn today [birds] (get birds 6))

(defn inc-bird [birds] (assoc birds 6 (inc (today birds))))

(defn day-without-birds? [birds] (or (some #(= 0 %) birds) false))

(defn n-days-count [birds n] (reduce + (take n birds)))

(defn busy-days [birds] (reduce #(+ %1 (if (>= %2 5) 1 0)) 0 birds))

(defn odd-week?
  [birds]
  (or (= birds [1 0 1 0 1 0 1]) (= birds [0 1 0 1 0 1 0])))
