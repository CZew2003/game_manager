import javax.swing.*;
public class ImageFrame {
    ImageFrame() {
        JFrame f = new JFrame("Add an image to JFrame");
        ImageIcon icon = new ImageIcon("League_Infobox_Wukong.jpg");
        f.add(new JLabel(icon));
        f.pack();
        f.setVisible(true);
    }
}