
public class Vehicle {
	
	//Vehicle v = new Vehicle((String)jtfName.getText(),(String)jsYear.getValue(),(String)jsPrice.getValue(),(String)jsKilometers.getValue(),(String)jsFuel.getValue(),(String)jsTransmission.getValue(),(String)jsSellers.getValue(),(String)jsOwners.getValue())
	String name; 
	String year;
	String price; 
	String km;String fuel;
	String transmission; 
	String seller;
	String owner;

	public Vehicle(boolean i, String name, String year, String price, String km, String fuel, String transmission, String seller, String owner) {
		
		this.setName(name);
		this.setYear(year);
		this.setPrice(price);
		this.setKm(km);
		this.setFuel(fuel);
		this.setTransmission(transmission);
		if(i) {
			this.setOwner(owner);
		}else {
			this.setSeller(seller);
		}
		
	}

	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getKm() {
		return km;
	}

	public void setKm(String km) {
		this.km = km;
	}

	public String getFuel() {
		return fuel;
	}

	public void setFuel(String fuel) {
		this.fuel = fuel;
	}

	public String getTransmission() {
		return transmission;
	}

	public void setTransmission(String transmission) {
		this.transmission = transmission;
	}

	public String getSeller() {
		return seller;
	}

	public void setSeller(String seller) {
		this.seller = seller;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}
	
}
