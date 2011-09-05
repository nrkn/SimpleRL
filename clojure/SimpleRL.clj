(ns simple-rl
  (:import
   (javax.swing JFrame JTextArea)
   (java.awt Font)
   (java.awt.event KeyAdapter KeyEvent)))

(def world [(vec (seq "####  ####\n"))
	    (vec (seq "#  ####  #\n"))
	    (vec (seq "#        #\n"))
	    (vec (seq "##      ##\n"))
	    (vec (seq " #      # \n"))
	    (vec (seq " #      # \n"))
	    (vec (seq "##      ##\n"))
	    (vec (seq "#        #\n"))
	    (vec (seq "#  ####  #\n"))
	    (vec (seq "####  ####\n"))])

(def x (ref 5))
(def y (ref 5))

(defn refresh []
  (.setText pane (str-world-with-hero)))

(defn world-with-hero []
  (let [x (deref x)
	y (deref y)
	row (world y)]
    (assoc world y (assoc row x \@))))

(defn str-world-with-hero []
  (let [world-seq (map #(apply str %) (world-with-hero))
	world-str (reduce str world-seq)]
    world-str))

(defn move [dx dy]
  (let [new-x (+ (deref x) dx)
	new-y (+ (deref y) dy)]
    (when (= ((world new-y) new-x) \space)
      (dosync
       (alter x + dx)
       (alter y + dy))
      (refresh))))

(def listener (proxy [KeyAdapter] []
		(keyPressed [e]
			    (let [key-code (.getKeyCode e)]
			      (cond
			       (= key-code KeyEvent/VK_LEFT) (move -1 0)
			       (= key-code KeyEvent/VK_RIGHT) (move 1 0)
			       (= key-code KeyEvent/VK_UP) (move 0 -1)
			       (= key-code KeyEvent/VK_DOWN) (move 0 1))))))

(def pane (JTextArea.))
(.addKeyListener pane listener)
(def frame (JFrame.))
(.setEditable pane false)
(.setFont pane (Font. "monospaced", Font/PLAIN 14))
(refresh)
(.setContentPane frame pane)
(.setDefaultCloseOperation frame JFrame/DISPOSE_ON_CLOSE)
(.pack frame)
(.setVisible frame true)