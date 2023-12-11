

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;


class MyFrame
        extends JFrame
        implements ActionListener {

    // Components of the Form
    private Container c;
    private JLabel title;
    private JLabel name;
    private JTextField tname;
    private JTextField uname;
    private JLabel pss;
    private JPasswordField tpss;
    private JLabel region;
    private JRadioButton euw;
    private JRadioButton eune;
    private JRadioButton na;
    private ButtonGroup gengp;
    private JCheckBox term;
    private JButton sub;
    private JButton reset;
    private JLabel tout;
    private JLabel res;
    private JTextArea resadd;
    public MyFrame()
    {
        setTitle("Registration Form");
        setBounds(300, 90, 900, 600);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setResizable(false);

        c = getContentPane();
        c.setLayout(null);

        title = new JLabel("Registration Form");
        title.setFont(new Font("Arial", Font.PLAIN, 30));
        title.setSize(300, 30);
        title.setLocation(300, 30);
        c.add(title);

        name = new JLabel("Name");
        name.setFont(new Font("Arial", Font.PLAIN, 20));
        name.setSize(100, 20);
        name.setLocation(100, 100);
        c.add(name);

        tname = new JTextField();
        tname.setFont(new Font("Arial", Font.PLAIN, 15));
        tname.setSize(190, 20);
        tname.setLocation(200, 100);
        c.add(tname);

        name = new JLabel("User");
        name.setFont(new Font("Arial", Font.PLAIN, 20));
        name.setSize(200, 20);
        name.setLocation(100, 150);
        c.add(name);

        uname = new JTextField();
        uname.setFont(new Font("Arial", Font.PLAIN, 15));
        uname.setSize(190, 20);
        uname.setLocation(200, 150);
        c.add(uname);

        pss = new JLabel("Password");
        pss.setFont(new Font("Arial", Font.PLAIN, 20));
        pss.setSize(100, 20);
        pss.setLocation(100, 200);
        c.add(pss);

        tpss = new JPasswordField();
        tpss.setFont(new Font("Arial", Font.PLAIN, 15));
        tpss.setSize(150, 20);
        tpss.setLocation(200, 200);
        c.add(tpss);

        region = new JLabel("Region");
        region.setFont(new Font("Arial", Font.PLAIN, 20));
        region.setSize(100, 20);
        region.setLocation(100, 250);
        c.add(region);

        euw = new JRadioButton("euw");
        euw.setFont(new Font("Arial", Font.PLAIN, 15));
        euw.setSelected(false);
        euw.setSize(80, 20);
        euw.setLocation(200, 250);
        c.add(euw);

        eune = new JRadioButton("eune");
        eune.setFont(new Font("Arial", Font.PLAIN, 15));
        eune.setSelected(false);
        eune.setSize(80, 20);
        eune.setLocation(290, 250);
        c.add(eune);

        na = new JRadioButton("na");
        na.setFont(new Font("Arial", Font.PLAIN, 15));
        na.setSelected(false);
        na.setSize(80, 20);
        na.setLocation(380, 250);
        c.add(na);

        gengp = new ButtonGroup();
        gengp.add(na);
        gengp.add(euw);
        gengp.add(eune);

        term = new JCheckBox("Accept Terms And Conditions.");
        term.setFont(new Font("Arial", Font.PLAIN, 15));
        term.setSize(250, 20);
        term.setLocation(150, 400);
        c.add(term);

        sub = new JButton("Submit");
        sub.setFont(new Font("Arial", Font.PLAIN, 15));
        sub.setSize(100, 20);
        sub.setLocation(150, 450);
        sub.addActionListener(this);
        c.add(sub);

        reset = new JButton("Reset");
        reset.setFont(new Font("Arial", Font.PLAIN, 15));
        reset.setSize(100, 20);
        reset.setLocation(270, 450);
        reset.addActionListener(this);
        c.add(reset);

        ImageIcon icon = new ImageIcon("League_Infobox_Wukong.jpg");
        tout = new JLabel();
        tout.setFont(new Font("Arial", Font.PLAIN, 15));
        tout.setSize(300, 400);
        tout.setLocation(500, 100);
        tout.setIcon(icon);
        c.add(tout);

        res = new JLabel("");
        res.setFont(new Font("Arial", Font.PLAIN, 20));
        res.setSize(500, 25);
        res.setLocation(100, 500);
        c.add(res);

        resadd = new JTextArea();
        resadd.setFont(new Font("Arial", Font.PLAIN, 15));
        resadd.setSize(200, 75);
        resadd.setLocation(580, 175);
        resadd.setLineWrap(true);
        c.add(resadd);



        setVisible(true);
    }

    // method actionPerformed()
    // to get the action performed
    // by the user and act accordingly
    public void actionPerformed(ActionEvent e)
    {

        if (e.getSource() == sub) {
            if (term.isSelected()) {
                String data1="Region: "+"\n";
                String data
                        = "Name : "
                        + tname.getText() + "\n"
                        + "Username : "
                        + tpss.getText() + "\n";
                if (euw.isSelected())
                    data1 = "Region : euw"
                            + "\n";
                else if(eune.isSelected())
                    data1 = "Region : eune"
                            + "\n";
                else if(na.isSelected())
                    data1 = "Region : na"
                            + "\n";


                res.setText("Registration Successfully..");
            }
            else {

                resadd.setText("");
                res.setText("Please accept the"
                        + " terms & conditions..");
            }
        }

        else if (e.getSource() == reset) {
            String def = "";
            tname.setText(def);
            tpss.setText(def);
            res.setText(def);
            tout.setText(def);
            term.setSelected(false);
            resadd.setText(def);
        }
    }
}

