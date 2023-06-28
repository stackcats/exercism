(ns all-your-base)

(defn- aux
  [n output-base]
  (when (pos? n)
    (loop [n n acc []]
      (if (zero? n)
        (reverse acc)
        (recur (quot n output-base) (conj acc (rem n output-base)))))))

(defn- digits-invalidate?
  [input-base digits]
  (some #(or (< % 0) (>= % input-base)) digits))

(defn convert
  [input-base digits output-base]
  (cond
    (< input-base 2) nil
    (< output-base 2) nil
    (empty? digits) ()
    (digits-invalidate? input-base digits) nil
    :else (let [n (reduce #(+ %2 (* input-base %1)) 0 digits)]
            (or (aux n output-base) '(0)))))

