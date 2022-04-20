import javax.swing.*;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

@SuppressWarnings("serial")
public class Schema extends JFrame implements ActionListener {

    Container container = getContentPane();
    
    JLabel name = new JLabel("NAME");
    JTextField jtfName = new JTextField();
    JLabel year = new JLabel("YEAR");
    JSpinner jsYear = new JSpinner(new SpinnerNumberModel(1995,1910,2022,1));
    JLabel price = new JLabel("PRICE");
    JSpinner jsPrice = new JSpinner(new SpinnerNumberModel(10000,0,1000000000,1000));
    JLabel kilometers = new JLabel("KILOMETERS");
    JSpinner jsKilometers = new JSpinner(new SpinnerNumberModel(10000,0,1000000,100));
    JLabel fuel = new JLabel("FUEL");
    String fuels[] = {"Petrol","Diesel","CNG","LPG","Electric"};
    JSpinner jsFuel = new JSpinner(new SpinnerListModel(fuels));
    JLabel transmission = new JLabel("TRANSMISSION");
    String transmisions[] = {"Manual","Automatic"};
    JSpinner jsTransmission = new JSpinner(new SpinnerListModel(transmisions));
    JLabel sellerType = new JLabel("SELLER TYPE");
    String sellers[] = {"NULL","Individual","Dealer","Trustmark Dealer"};
    JSpinner jsSellers = new JSpinner(new SpinnerListModel(sellers));
    JLabel ownerType = new JLabel("OWNERS");
    String owners[] = {"NULL","1st","2nd","3rd","4th & Above","Test car"};
    JSpinner jsOwners = new JSpinner(new SpinnerListModel(owners));

    JButton searchSeller = new JButton("SEARCH SELLER TYPE");
    JButton searchOwner = new JButton("SEARCH OWNER TYPE");
    
    JLabel result = new JLabel("RESULT:");
    JLabel searchedResult = new JLabel("NULL");


	int w=600;
	int h=300;
	DecissionTree d = new DecissionTree();

    public Schema() {
        setSize(w, h);
        setLocationRelativeTo(null);
        setResizable(false);
    	setTitle("Car prediction");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayoutManager();
        setLocationAndSize();
        addComponentsToContainer();
        addActionEvent();
        setVisible(true);

    }

    public void setLayoutManager() {
        container.setLayout(null);
    }

    public void setLocationAndSize() {
    	name.setBounds(25, 25, 175, 30);
    	jtfName.setBounds(175, 25, 175, 30);
    	year.setBounds(25, 50, 175, 30);
    	jsYear.setBounds(175, 50, 175, 30);
    	price.setBounds(25, 75, 175, 30);
    	jsPrice.setBounds(175, 75, 175, 30);
    	kilometers.setBounds(25, 100, 175, 30);
    	jsKilometers.setBounds(175, 100, 175, 30);
    	fuel.setBounds(25, 125, 175, 30);
    	jsFuel.setBounds(175, 125, 175, 30);
    	transmission.setBounds(25, 150, 175, 30);
    	jsTransmission.setBounds(175, 150, 175, 30);
    	sellerType.setBounds(25, 175, 175, 30);
    	jsSellers.setBounds(175, 175, 175, 30);
    	ownerType.setBounds(25, 200, 175, 30);
    	jsOwners.setBounds(175, 200, 175, 30);
    	searchSeller.setBounds(125, 230, 175, 30);
    	searchOwner.setBounds(300, 230, 175, 30);
    	result.setBounds(400, 100, 175, 30);
    	searchedResult.setBounds(400, 150, 200, 30);

    }

    public void addComponentsToContainer() {
        container.add(name);
        container.add(jtfName);
        container.add(jsYear);
        container.add(year);
        container.add(jsYear);
        container.add(price);
        container.add(jsPrice);
        container.add(kilometers);
        container.add(jsKilometers);
        container.add(fuel);
        container.add(jsFuel);
        container.add(transmission);
        container.add(jsTransmission);
        container.add(sellerType);
        container.add(jsSellers);
        container.add(ownerType);
        container.add(jsOwners);
        container.add(searchSeller);
        container.add(searchOwner);
        container.add(result);
        container.add(searchedResult);
    }

    public void addActionEvent() {
        searchSeller.addActionListener(this);
        searchOwner.addActionListener(this);
    }


	@Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == searchSeller) {
        	if ( ((String)jsSellers.getValue()).contentEquals("NULL") && !((String)jsOwners.getValue()).contentEquals("NULL")) {
                searchedResult.setText( d.findSeller((String)jtfName.getText(),(int)jsYear.getValue(),(int)jsPrice.getValue(),(int)jsKilometers.getValue(),(String)jsFuel.getValue(),(String)jsTransmission.getValue(),(String)jsSellers.getValue(),(String)jsOwners.getValue()) );
        	}else {
                searchedResult.setText("Incorrect for seller");
        	}
            revalidate();
        }        
        if (e.getSource() == searchOwner) {
        	if ( !((String)jsSellers.getValue()).contentEquals("NULL") && ((String)jsOwners.getValue()).contentEquals("NULL")) {
            	searchedResult.setText( d.findOwner((String)jtfName.getText(),(int)jsYear.getValue(),(int)jsPrice.getValue(),(int)jsKilometers.getValue(),(String)jsFuel.getValue(),(String)jsTransmission.getValue(),(String)jsSellers.getValue(),(String)jsOwners.getValue()) );
        	}else {
                searchedResult.setText("Incorrect for owner");
        	}
        	revalidate();
        }
    }
}