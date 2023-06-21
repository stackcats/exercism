(ns binary-search-tree)

(def value :v)

(def left :left)

(def right :right)

(defn singleton [v] {:v v, :left nil, :right nil})

(defn insert
  [v tree]
  (cond (nil? tree) (singleton v)
        (<= v (value tree)) (assoc tree :left (insert v (left tree)))
        :else (assoc tree :right (insert v (right tree)))))

(defn to-list
  [tree]
  (if tree
    (concat (to-list (left tree)) [(value tree)] (to-list (right tree)))
    []))

(defn from-list [xs] (reduce #(insert %2 %1) nil xs))
