import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class RL extends JApplet  {
    String map = "####  ####\n"
             + "#  ####  #\n"
             + "#        #\n"
             + "##      ##\n"
             + " #      # \n"
             + " #      # \n"
             + "##      ##\n"
             + "#        #\n"
             + "#  ####  #\n"
             + "####  ####\n";
    int x = 5, y = 5;

    JTextArea pane = new JTextArea();

    public RL() throws HeadlessException {

        // create GUI that predends to be a console
        setContentPane(pane);
        pane.setEditable(false);
        pane.setFont(new Font("monospaced",Font.PLAIN,14));

        // kickstart display
        repaintMap();

        // key listener
        pane.addKeyListener(new KeyAdapter() {
            public void keyPressed(KeyEvent e) {
                switch (e.getKeyCode()){
                    case KeyEvent.VK_LEFT:  moveHero (-1,0); break;
                    case KeyEvent.VK_RIGHT: moveHero (1,0);  break;
                    case KeyEvent.VK_UP:    moveHero (0,-1); break;
                    case KeyEvent.VK_DOWN:  moveHero (0,1);  break;
                }
                repaintMap();}
        });
    }

    private int indexFromCoords(int x, int y){
        return y * (map.indexOf("\n") + 1) + x;
    }

    private void moveHero(int dx, int dy) {
        if (map.charAt(indexFromCoords(x + dx, y + dy)) == ' ') {
            x = x + dx;
            y = y + dy;
        }
    }

    private void repaintMap(){
        char[] currentMap = map.toCharArray();
        currentMap[indexFromCoords(x, y)] = '@';
        pane.setText(new String(currentMap));
    }
} 