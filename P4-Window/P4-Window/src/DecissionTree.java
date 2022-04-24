
public class DecissionTree {
	public String findSeller(String name, String year, String price, String kilometers, String fuel, String transmission, String seller, String owner) {

		if(owner.contentEquals("First Owner") || 
		   owner.contentEquals("Test Drive Car")) {
			if(transmission.contentEquals("Automatic")) {
				if(kilometers.contentEquals("50000 < x <= 65000") || 
				   kilometers.contentEquals("80000 < x <= 95000")) {
					return("Dealer (1%)");
				}else{
					if(price.contentEquals("200000 < x <= 300000") || 
					   price.contentEquals("500000 < x <= 600000")) {
						return("Dealer (1%)");
					}else{
						return("Individual (5%)");
					}
				}
			}else{
				if(price.contentEquals("300000 < x <= 400000") || 
				   price.contentEquals("400000 < x <= 500000") || 
				   price.contentEquals("x > 600000")){
					if(kilometers.contentEquals("50000 < x <= 65000")) {
						if(year.contentEquals("2010 < x <= 2015")) {
							return("Dealer (3%)");
						}else{
							return("Individual (2%)");
						}
					}else{
						return("Individual (31%)");
					}
				}else{
					return("Individual (21%)");
				}
			}
		}else{
			return("Individual (34%)");
		}
	}
	
	public String findOwner(String name, String year, String price, String kilometers, String fuel, String transmission, String seller, String owner) {
		
		if(year.contentEquals("year = 2015 < x <= 2020")) {
			return("First owner (33%)");
		}else{
			if(seller.contentEquals("Dealer") || 
			   seller.contentEquals("Trustmark Dealer")) {
				return("First owner (15%)");
			}else{
				if(kilometers.contentEquals("35000 < x <= 50000") || 
				   kilometers.contentEquals("x <= 35000")){
					return("First owner (12%)");
				}else{
					if(year.contentEquals("2010 < x <= 2015")) {
						return("First owner (22%)");
					}else{
						return("Second owner (18%)");
					}
				}
			}
		} 
	}	
}
