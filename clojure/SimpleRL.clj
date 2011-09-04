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

(def x (ref 5))
(def y (ref 5))

(defn world-with-hero []
  (let [x (deref x)
	y (deref y)
	row (world y)]
    (assoc world y (assoc row x \@))))


      
	     
