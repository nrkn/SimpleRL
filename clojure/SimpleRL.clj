(ns simple-rl
  (:import
   (javax.swing JFrame JTextArea)
   (java.awt Font)))

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

(def pane (JTextArea.))
(def frame (JFrame.))
(.setEditable pane false)
(.setFont pane (Font. "monospaced", Font/PLAIN 14))
(.setText pane (reduce #(str %1 %2) (map #(apply str %) world)))
(.setContentPane frame pane)
;; SWANK really is allergic to EXIT_ON_CLOSE
;; Uncomment if only if you don't want to restart SWANK
;; on closing the frame...
;(.setDefaultCloseOperation frame JFrame/EXIT_ON_CLOSE)
(.pack frame)
(.setVisible frame true)

(def x (ref 5))
(def y (ref 5))

(defn world-with-hero []
  (let [x (deref x)
	y (deref y)
	row (world y)]
    (assoc world y (assoc row x \@))))


      
	     
